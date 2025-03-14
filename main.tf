resource "spacelift_stack" "stackdestroytest" {
  name        = "Stack to test stack destroy"
  autodeploy   = true
  repository   = "StackDestructor"
  branch       = "main"
  project_root = "S3bucket"
}


resource "spacelift_aws_integration" "this" {
  name                          = var.role_name
  role_arn                      = var.role_arn
  generate_credentials_in_worker = false
}

resource "spacelift_aws_integration_attachment" "this" {
  integration_id = spacelift_aws_integration.this.id
  stack_id       = spacelift_stack.stackdestroytest.id
  read           = true
  write          = true

  # The integration needs to exist before we attach it.
  depends_on = [
    spacelift_aws_integration.this
  ]
}

resource "spacelift_run" "this" {
  stack_id = spacelift_stack.stackdestroytest.id

  keepers = {
    branch = spacelift_stack.stackdestroytest.branch
  }
}
