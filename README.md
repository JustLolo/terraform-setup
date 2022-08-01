<h1> Purpose </h1>
<p>
The purpose of this "project" is the fast deploy of the terraform backend on aws.
Check what a terraform backend is <a href="https://www.terraform.io/language/settings/backends/configuration"> here </a>
</p>
<p>
Use this in conjuntion with the other project named terraform-basic (in progress)
</p>
</br>


<h1> Requirements </h1>
<ul>
  <li> Unix Based Operating Systems (aka, Ubuntu 20.04) (I have run this only on ubuntu 20.04) </li>
  <li> <a href="https://www.terraform.io/language/settings/backends/configuration">terraform</a>, official installation/setup guide </li>
  <li> <a href="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html">aws cli</a>, official installation/setup guide </li>
  <li> an <a href="https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/">AWS account</a> </li>
</ul>
</br>

<h1> Configuring the environment </h1>
<p> What you'll need: </p>
<ol>
<li> An AWS account</li>
<li> The access keys of this account</li>

</ol>
</br>
<p>Terraform needs access to you aws account, you can either use your same root account <a hfref="https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#lock-away-credentials">(Not recommended)</a> or create a IAM user that have administrator privilegies, <a>here</a> is how to. </p>

</br>
<p>Open <b> bash </b> or any other bash based cli and paste the following (<b>REMEMBER:</b> you'll need your aws IAM keys for this): </p>
<pre>
<code> echo 'export AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY_ID' >> ~/.bashrc </code>
<code> echo 'export AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_ACCESS_KEY' >> ~/.bashrc </code>
<code> echo 'export AWS_DEFAULT_REGION=us-west-2' >> ~/.bashrc </code>
</pre>
<p> After this restart the console (<b>close it </b> and open it again) </p>

<ol>
  <li>
    Clone the project using: </br>
    <code> gh repo clone JustLolo/terraform-setup </code>
  </li>
  <li>
    Enter to the folder project: </br>
    <code> cd terraform-setup </code>
  </li>
  <li>
    <b>Testing AWS CLI credentials:</b></br>
    Run the following on the CLI: </br>
    <code> aws sts get-caller-identity</code>
  </li>
  <li>If you get no error, and it's showed an output with yout IAM user you are good.
  </li>
  <li>
    <b>Testing terraform</b> </br>
    On the CLI run: </br>
    <code>terraform init</code> </br>
    <code>terraform plan</code>
  </li>
</ol>
<p>
If you got no single error in the previous steps everything is working as expected
</p>
</br>

<h1>Running the project</h1>
<p>On the cli run: <code><b>terraform apply</b></code> </br>
and you backend will be created<p>

</br>
<h1>Output: </h1>
<ul>
  <li>"dynamodb-backend-id" = aws_dynamodb_table.terraform_state.id 
  </li>
  <li>"s3-backend-id" = aws_s3_bucket.terraform_state.id </li>
  <li>"s3-folder-ec2-keys" = aws_s3_object.ec2_keys_folder.key </li>
  <li>"s3-folder-status-keeper"= aws_s3_object.terraform-backend-folder.key </li>
</ul>
Check output.tf for details.



