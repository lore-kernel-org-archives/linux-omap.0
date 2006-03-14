From: "Keria Seymour" <subsun.ece94g@nctu.edu.tw>
Subject: Can't execute sshd
Date: Tue, 14 Mar 2006 21:58:43 +0800
Message-ID: <20060314135933.60B8D9126A@mailreg.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi.used the sshd debug mode on osk 5912

But I got the message below on the server, then the server suspended.Do you
know how to solve it?

============================================================================
=======================

debug1: sshd version OpenSSH_3.5p1

debug1: private host key: #0 type 0 RSA1

debug1: read PEM private key done: type RSA

debug1: private host key: #1 type 1 RSA

debug1: read PEM private key done: type DSA

debug1: private host key: #2 type 2 DSA

socket: Address family not supported by protocol

debug1: Bind to port 22 on 0.0.0.0.

Server listening on 0.0.0.0 port 22.

Generating 768 bit RSA key.

RSA key generation complete.

debug1: Server will not fork when running in debugging mode.

Connection from 192.168.0.191 port 42407

debug1: Client protocol version 2.0; client software version OpenSSH_3.5p1

debug1: match: OpenSSH_3.5p1 pat OpenSSH*

debug1: Enabling compatibility mode for protocol 2.0

debug1: Local version string SSH-1.99-OpenSSH_3.5p1

debug1: permanently_set_uid: 501/255

debug1: list_hostkey_types: ssh-rsa,ssh-dss

debug1: SSH2_MSG_KEXINIT sent

debug1: SSH2_MSG_KEXINIT received

debug1: kex: client->server aes128-cbc hmac-md5 none

debug1: kex: server->client aes128-cbc hmac-md5 none

debug1: SSH2_MSG_KEX_DH_GEX_REQUEST received

WARNING: /usr/local/etc/moduli does not exist, using old modulus

debug1: SSH2_MSG_KEX_DH_GEX_GROUP sent

debug1: dh_gen_key: priv key bits set: 131/256

debug1: bits set: 517/1024

debug1: expecting SSH2_MSG_KEX_DH_GEX_INIT

debug1: bits set: 532/1024

debug1: SSH2_MSG_KEX_DH_GEX_REPLY sent

debug1: kex_derive_keys

debug1: newkeys: mode 1

debug1: SSH2_MSG_NEWKEYS sent

debug1: waiting for SSH2_MSG_NEWKEYS

debug1: newkeys: mode 0

debug1: SSH2_MSG_NEWKEYS received

debug1: KEX done

debug1: userauth-request for user root service ssh-connection method none

debug1: attempt 0 failures 0

Failed none for root from 192.168.0.191 port 42407

ssh2

Failed none for root from 192.168.0.191 port 42407

ssh2

debug1: userauth-request for user root service ssh-connection method
publickey

debug1: attempt 1 failures 1

debug1: test whether pkalg/pkblob are acceptable

debug1: temporarily_use_uid: 0/0 (e=0/0)

debug1: trying public key file

/root/.ssh/authorized_keys

debug1: matching key found: file

/root/.ssh/authorized_keys, line 1

Found matching RSA key:

1e:74:35:fc:19:88:36:ab:93:6b:7a:d6:75:67:37:75

debug1: restore_uid: 0/0

Postponed publickey for root from 192.168.0.191 port

42407 ssh2

debug1: userauth-request for user root service ssh-connection method
publickey

debug1: attempt 2 failures 1

debug1: temporarily_use_uid: 0/0 (e=0/0)

debug1: trying public key file

/root/.ssh/authorized_keys

debug1: matching key found: file

/root/.ssh/authorized_keys, line 1

Found matching RSA key:

1e:74:35:fc:19:88:36:ab:93:6b:7a:d6:75:67:37:75

debug1: restore_uid: 0/0

debug1: ssh_rsa_verify: signature correct Accepted publickey for root from
192.168.0.191 port

42407 ssh2

debug1: monitor_child_preauth: root has been authenticated by privileged
processAccepted publickey for root from 192.168.0.191 port 42407 ssh2

debug1: newkeys: mode 0

debug1: newkeys: mode 1

debug1: Entering interactive session for SSH2.

debug1: fd 3 setting O_NONBLOCK

debug1: fd 7 setting O_NONBLOCK

debug1: server_init_dispatch_20

debug1: server_input_channel_open: ctype session rchan 0 win 65536 max 16384

debug1: input_session_request

debug1: channel 0: new [server-session]

debug1: session_new: init

debug1: session_new: session 0

debug1: session_open: channel 0

debug1: session_open: session 0: link with channel 0

debug1: server_input_channel_open: confirm session

debug1: server_input_channel_req: channel 0 request pty-req reply 0

debug1: session_by_channel: session 0 channel 0

debug1: session_input_channel_req: session 0 req pty-req

lastlog_get_entry: Error reading from

/var/log/lastlog: Bad file descriptor

debug1: Allocating pty.

openpty: No such file or directory

session_pty_req: session 0 alloc failed

debug1: server_input_channel_req: channel 0 request x11-req reply 0

debug1: session_by_channel: session 0 channel 0

debug1: session_input_channel_req: session 0 req x11-req

debug1: X11 forwarding disabled in server configuration file.

debug1: server_input_channel_req: channel 0 request shell reply 0

debug1: session_by_channel: session 0 channel 0

debug1: session_input_channel_req: session 0 req shell

debug1: fd 9 setting O_NONBLOCK

debug1: fd 11 setting O_NONBLOCK

The below message is appeared on client

Environment:

              USER=root

                         LOGNAME=root

                                       HOME=/root

                                                  

PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

                      MAIL=/var/mail/root

                                          

SHELL=/bin/sh

                                                      

   SSH_CLIENT=192.168.0.191 42407 22

             SSH_CONNECTION=192.168.0.191 42407

192.168.0.182 22

 
