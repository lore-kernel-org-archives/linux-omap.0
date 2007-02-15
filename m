From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: [PATCH 4/4] ARM: OMAP: Fix build breakage of OMAP1 camera driver
Date: Thu, 15 Feb 2007 17:15:16 +0530
Message-ID: <5d5443650702150345t636d2a62g63e5b6649255150d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_79301_26501349.1171539916853"
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

------=_Part_79301_26501349.1171539916853
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
--Trilok Soni

------=_Part_79301_26501349.1171539916853
Content-Type: text/plain;
	name=0004-ARM-OMAP-Fix-build-breakage-of-OMAP1-camera-driver.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ey7gh1rp
Content-Disposition: attachment;
	filename="0004-ARM-OMAP-Fix-build-breakage-of-OMAP1-camera-driver.txt"

RnJvbSA0Y2RlZjYwZmNiY2JmNzViMzM4NmFiOGExYTI1YzA4ZjM3NDEyNWZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcmlsb2sgU29uaSA8c29uaS50cmlsb2tAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDE1IEZlYiAyMDA3IDIxOjAyOjUwICswNTMwClN1YmplY3Q6IFtQQVRDSCA0LzRd
IFtQQVRDSF0gQVJNOiBPTUFQOiBGaXggYnVpbGQgYnJlYWthZ2Ugb2YgT01BUDEgY2FtZXJhIGRy
aXZlcgoKLSBUaGlzIGlzIGR1ZSB0byBjaGFuZ2UgaW4gc2Vuc29yIGludGVyZmFjZSB0byBicmlu
ZyBpbgogIE1pY3JvbiBzZW5zb3IgaW50ZXJmYWNlIGZvciBPTUFQMi4KClNpZ25lZC1vZmYtYnk6
IFRyaWxvayBTb25pIDxzb25pLnRyaWxva0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9tZWRpYS92
aWRlby9vbWFwL2NhbWVyYV9jb3JlLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3Zp
ZGVvL29tYXAvY2FtZXJhX2NvcmUuYyBiL2RyaXZlcnMvbWVkaWEvdmlkZW8vb21hcC9jYW1lcmFf
Y29yZS5jCmluZGV4IDk0NDA3MTguLjYwMGUxNjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVkaWEv
dmlkZW8vb21hcC9jYW1lcmFfY29yZS5jCisrKyBiL2RyaXZlcnMvbWVkaWEvdmlkZW8vb21hcC9j
YW1lcmFfY29yZS5jCkBAIC0xMDM3LDcgKzEwMzcsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBjYW1l
cmFfY29yZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWNhbS0+eGNsayA9
IGNhbS0+Y2FtX2hhcmR3YXJlLT5zZXRfeGNsayhjYW0tPnhjbGssIGNhbS0+aGFyZHdhcmVfZGF0
YSk7CiAKIAkvKiBpbml0aWFsaXplIHRoZSBzZW5zb3IgYW5kIGRlZmluZSBhIGRlZmF1bHQgY2Fw
dHVyZSBmb3JtYXQgY2FtLT5waXggKi8KLQljYW0tPnNlbnNvcl9kYXRhID0gY2FtLT5jYW1fc2Vu
c29yLT5pbml0KCZjYW0tPnBpeCk7CisJY2FtLT5zZW5zb3JfZGF0YSA9IGNhbS0+Y2FtX3NlbnNv
ci0+aW5pdCgmY2FtLT5waXgsICZjYW0tPnBpeDIpOwogCWlmICghY2FtLT5zZW5zb3JfZGF0YSkg
ewogCQljYW0tPmNhbV9oYXJkd2FyZS0+ZGlzYWJsZShjYW0tPmhhcmR3YXJlX2RhdGEpOwogCQlw
cmludGsoS0VSTl9FUlIgQ0FNX05BTUUgIjogY2Fubm90IGluaXRpYWxpemUgc2Vuc29yXG4iKTsK
LS0gCjEuNS4wCgo=
------=_Part_79301_26501349.1171539916853
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_79301_26501349.1171539916853--
