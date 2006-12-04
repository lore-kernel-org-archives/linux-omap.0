From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: [PATCH] ARM: OMAP: board-sdp2430.c Remove unnecessary #includes
Date: Tue, 5 Dec 2006 00:32:23 +0530
Message-ID: <3a5b1be00612041102y5d2630d7r3c69e4736c706177@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_30995_19588684.1165258943853"
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
List-Id: linux-omap@vger.kernel.org

------=_Part_30995_19588684.1165258943853
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
---Komal Shah
http://komalshah.blogspot.com

------=_Part_30995_19588684.1165258943853
Content-Type: text/plain;
	name=0001-ARM-OMAP-board-sdp2430.c-Remove-unnecessary-includes.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_evb915fm
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-board-sdp2430.c-Remove-unnecessary-includes.txt"

RnJvbSA4Njg4YTU0MmNiOTIyMzI3MDA2NzU1YWU3ZTI1MTYxYTIwMzFhNzRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlhaG9vLmNv
bT4KRGF0ZTogVHVlLCA1IERlYyAyMDA2IDAwOjI4OjE5ICswNTMwClN1YmplY3Q6IFtQQVRDSF0g
QVJNOiBPTUFQOiBib2FyZC1zZHAyNDMwLmMgUmVtb3ZlIHVubmVjZXNzYXJ5ICNpbmNsdWRlcwoK
LSBhbmQgZml4IHRoZSBmaWxlIHBhdGguCgpTaWduZWQtb2ZmLWJ5OiBLb21hbCBTaGFoIDxrb21h
bF9zaGFoODAyMDAzQHlhaG9vLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTI0
MzBzZHAuYyB8ICAgMTAgKy0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2Fy
ZC0yNDMwc2RwLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTI0MzBzZHAuYwppbmRleCAw
NzYxMzBlLi45YjI2MmUwIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTI0
MzBzZHAuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTI0MzBzZHAuYwpAQCAtMSw1
ICsxLDUgQEAKIC8qCi0gKiBsaW51eC9hcmNoL2FybS9tYWNoLW9tYXAvb21hcDIvYm9hcmQtMjQz
MHNkcC5jCisgKiBsaW51eC9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTI0MzBzZHAuYwogICoK
ICAqIENvcHlyaWdodCAoQykgMjAwNiBUZXhhcyBJbnN0cnVtZW50cwogICoKQEAgLTE5LDggKzE5
LDYgQEAKICNpbmNsdWRlIDxsaW51eC9tdGQvbXRkLmg+CiAjaW5jbHVkZSA8bGludXgvbXRkL3Bh
cnRpdGlvbnMuaD4KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgotI2luY2x1ZGUgPGxpbnV4L3dv
cmtxdWV1ZS5oPgotI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CiAjaW5jbHVkZSA8bGludXgvZXJy
Lmg+CiAjaW5jbHVkZSA8bGludXgvY2xrLmg+CiAKQEAgLTMxLDE1ICsyOSw5IEBACiAjaW5jbHVk
ZSA8YXNtL21hY2gvZmxhc2guaD4KIAogI2luY2x1ZGUgPGFzbS9hcmNoL2dwaW8uaD4KLSNpbmNs
dWRlIDxhc20vYXJjaC9ncGlvZXhwYW5kZXIuaD4KICNpbmNsdWRlIDxhc20vYXJjaC9tdXguaD4K
LSNpbmNsdWRlIDxhc20vYXJjaC91c2IuaD4KLSNpbmNsdWRlIDxhc20vYXJjaC9pcmRhLmg+CiAj
aW5jbHVkZSA8YXNtL2FyY2gvYm9hcmQuaD4KICNpbmNsdWRlIDxhc20vYXJjaC9jb21tb24uaD4K
LSNpbmNsdWRlIDxhc20vYXJjaC9rZXlwYWQuaD4KLSNpbmNsdWRlIDxhc20vYXJjaC9tZW5lbGF1
cy5oPgotI2luY2x1ZGUgPGFzbS9hcmNoL2RtYS5oPgogI2luY2x1ZGUgPGFzbS9hcmNoL2dwbWMu
aD4KICNpbmNsdWRlICJwcmNtLXJlZ3MuaCIKIAotLSAKMS40LjMuNC5nODJjYwoK
------=_Part_30995_19588684.1165258943853
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_30995_19588684.1165258943853--
