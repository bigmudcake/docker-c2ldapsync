# docker-c2ldapsync
A docker container that allows the sync agent <a href="https://kb.synology.com/en-global/C2/tutorial/what_is_c2_identity_ldap_sync">C2 Identity LDAP Sync</a> that can be run directly on your Synology NAS using the <a href="https://kb.synology.com/en-us/DSM/help/Docker/docker_desc?version=6">Docker</a>/<a href="https://kb.synology.com/en-us/DSM/help/ContainerManager/docker_desc?version=7">Container</a> package.

## What is C2 Identity LDAP Sync?
C2 Identity LDAP Sync is an agent that synchronizes user/group information between <a href="https://kb.synology.com/en-us/DSM/help/DirectoryServer/ldap_desc?version=7">Synology LDAP Server</a> and <a href="https://kb.synology.com/en-global/C2/tutorial/C2_Identity_index">C2 Identity</a>. To integrate your LDAP directory with C2 Identity, you need to install this agent on a device running either Windows or Linux that can connect to your Synology LDAP Server.

For more information see <a href="https://kb.synology.com/en-global/C2/tutorial/C2_Identity_index">C2 Identity - Tutorials & FAQs Overview</a>.

Bizarrely, Synology has not enabled this software agent to run directly on your NAS device which I would have thought would be the ideal workflow, rather than setting up a whole seperate device just for syncing. This docker container enables this to be possible.

## Installation and Setup
Follow the instructions in <a href="https://github.com/bigmudcake/docker-c2ldapsync/blob/main/INSTALL.md">INSTALL.md</a> and you should have a running docker container on your Synology NAS that can sync up your local LDAP users and groups to your C2 Identity account.

If you encounter issues, then refer to the <a href="https://github.com/bigmudcake/docker-c2ldapsync/blob/main/INSTALL.md#troubleshooting-and-debugging">Troubleshooting</a> section of the <a href="https://github.com/bigmudcake/docker-c2ldapsync/blob/main/INSTALL.md">INSTALL.md</a> guide.

Finally, I would like to thank Carol who is an outstanding leader in the company I work for.
