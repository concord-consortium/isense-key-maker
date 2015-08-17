Dynamically add contributor keys to a set of iSENSE projects.

This is useful because iSENSE doesn't support filtering data by multiple fields. However, it is
possible to select datasets by contributor key. So by creating a new contributor key for
various segments of data, a user of the iSENSE project can filter by these segments and then
filter again by a specific iSENSE field.

The app requires no database. On startup it loads a list of iSENSE project ids from a URL
passed as an environment variable. The app uses a iSENSE username and password stored in 
environent variables, to authenticate with iSENSE.

The app make a API request to each of the iSENSE projects to create the contributor key.
The iSENSE API endpoint used is:

    POST /api/v1/projects/(project id)/add_key

This endpoint requires data in the form

    {
        "email": "email address (string)",
        "password": "password (string)",
        "contrib_key": {
        	'name': "Key's Name(string)",
            'key': "Key (string)"
        }
    }

The response codes can be:

- Success: 201 Created
- Fail: 401 Unauthorized
- Fail: 409 Conflict
- Fail: 422 Unprocessable Entity

And finally the user must be the owner of the project. So if we have projects with different
owners the ENV variable storage of credentials will need to be expanded.

The app end point will take data in the form:

    {
        'name': "Key's Name(string)",
        'key': "Key (string)"
    }

The app will simply send this on to each of the projects. If there is a conflict that should
means the key was already created for this project.

Question: when will the browser app do this? Every single time it starts up?
If that is the case isense-key-maker might need to do some caching so it doesn't try to
recreate the same keys again and again and again.

The browser client is already doing some localStorage caching so it could also cache the
fact that the key was created. However students usually bounce from computer to computer
so this still might result in lots of conflicting key requests. Best we can do is try this.
