From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: [PATCH] ARM: OMAP: Fix sx1 build failure
Date: Mon, 4 Dec 2006 23:46:35 +0530
Message-ID: <3a5b1be00612041016j653fe738m9b3f77c6400e95d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_30127_3604132.1165256195048"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
Cc: vovan888@gmail.com
List-Id: linux-omap@vger.kernel.org

------=_Part_30127_3604132.1165256195048
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch from Vladimir Ananiev.

-- 
---Komal Shah
http://komalshah.blogspot.com

------=_Part_30127_3604132.1165256195048
Content-Type: text/plain; name=0001-ARM-OMAP-Fix-sx1-build-failure.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evb7a0qa
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Fix-sx1-build-failure.txt"

RnJvbSA3NzM0YmJkYWM2Y2Y0ZjJlNjcwZGU1Y2FhMzY4ZjU4ZjI1ODk3OGI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlhaG9vLmNv
bT4KRGF0ZTogTW9uLCA0IERlYyAyMDA2IDIzOjM5OjIxICswNTMwClN1YmplY3Q6IFtQQVRDSF0g
QVJNOiBPTUFQOiBGaXggc3gxIGJ1aWxkIGZhaWx1cmUKCnNvdW5kL2FybS9vbWFwL29tYXAtYWxz
YS1zeDEuYzozMjogZXJyb3I6IGBDTl9JRFhfU1gxU05EJyB1bmRlY2xhcmVkCmhlcmUgKG5vdCBp
biBhIGZ1bmN0aW9uKQpzb3VuZC9hcm0vb21hcC9vbWFwLWFsc2Etc3gxLmM6MzI6IGVycm9yOiBp
bml0aWFsaXplciBlbGVtZW50IGlzIG5vdCBjb25zdGFudApzb3VuZC9hcm0vb21hcC9vbWFwLWFs
c2Etc3gxLmM6MzI6IGVycm9yOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IKCQkJCQkgICBgY25f
c3gxc25kX2lkLmlkeCcpCnNvdW5kL2FybS9vbWFwL29tYXAtYWxzYS1zeDEuYzozMjogZXJyb3I6
IGBDTl9WQUxfU1gxU05EJyB1bmRlY2xhcmVkCmhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKQpzb3Vu
ZC9hcm0vb21hcC9vbWFwLWFsc2Etc3gxLmM6MzI6IGVycm9yOiBpbml0aWFsaXplciBlbGVtZW50
IGlzIG5vdCBjb25zdGFudApzb3VuZC9hcm0vb21hcC9vbWFwLWFsc2Etc3gxLmM6MzI6IGVycm9y
OiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IKCQkJCQkgICBgY25fc3gxc25kX2lkLnZhbCcpCgpT
aWduZWQtb2ZmLWJ5OiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlhaG9vLmNvbT4KU2ln
bmVkLW9mZi1ieTogVmxhZGltaXIgQW5hbmlldiA8dm92YW44ODhAZ21haWwuY29tPgotLS0KIGlu
Y2x1ZGUvbGludXgvY29ubmVjdG9yLmggfCAgICA2ICsrKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9jb25uZWN0b3IuaCBiL2luY2x1ZGUvbGludXgvY29ubmVjdG9yLmgKaW5kZXggNGMwMjExOS4u
YmE0OWEwMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9jb25uZWN0b3IuaAorKysgYi9pbmNs
dWRlL2xpbnV4L2Nvbm5lY3Rvci5oCkBAIC0zNiw5ICszNiwxMyBAQAogI2RlZmluZSBDTl9WQUxf
Q0lGUyAgICAgICAgICAgICAgICAgICAgIDB4MQogI2RlZmluZSBDTl9XMV9JRFgJCQkweDMJLyog
dzEgY29tbXVuaWNhdGlvbiAqLwogI2RlZmluZSBDTl9XMV9WQUwJCQkweDEKKyNkZWZpbmUgQ05f
SURYX1NYMVNORAkJCTB4NAorI2RlZmluZSBDTl9WQUxfU1gxU05ECQkJMHgxCisjZGVmaW5lIENO
X0lEWF9TWDFQTQkJCTB4NQorI2RlZmluZSBDTl9WQUxfU1gxUE0JCQkweDEKIAogCi0jZGVmaW5l
IENOX05FVExJTktfVVNFUlMJCTQKKyNkZWZpbmUgQ05fTkVUTElOS19VU0VSUwkJNgogCiAvKgog
ICogTWF4aW11bSBjb25uZWN0b3IncyBtZXNzYWdlIHNpemUuCi0tIAoxLjQuMy40Lmc4MmNjCgo=

------=_Part_30127_3604132.1165256195048
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_30127_3604132.1165256195048--
