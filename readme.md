Dynamically add contributor keys to an set of iSENSE projects.

This is useful because iSENSE doesn't support filtering data by multiple fields. However, it is
possible to select datasets by contributor key. So by creating a new contributor key for
various segments of data, a user of the iSENSE project can filter by these segments and then
filter again by a specific iSENSE field.

The app requires no database. On startup it loads a list of iSENSE project ids from a URL
passed as an environment variable.

It has a single REST endpoint for submitting contibutor key information. When a reuqest comes
in:

1. the app uses a iSENSE username and password stored in environent variables, to
authenticate with iSENSE.
2. the app make a API request to each of the iSENSE projects to create the contributor key.

This is all done synchronously, because the browser based client needs to know when the
contributor key has been created.