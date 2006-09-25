From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Remove <linux/config.h>
Date: Mon, 25 Sep 2006 17:09:59 +0530
Message-ID: <1159184399.14719.271746409@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1159184399147190";
	charset="ISO-8859-1"
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

This is a multi-part message in MIME format.

--_----------=_1159184399147190
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 25 Sep 2006 11:39:59 UT

Tony,

Attached patch removes #include <linux/config.h>

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service


--_----------=_1159184399147190
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Remove-linux-config.h.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-Remove-linux-config.h.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 25 Sep 2006 11:39:59 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBN
b24sIDI1IFNlcCAyMDA2IDIyOjM4OjQzICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBSZW1vdmUgPGxpbnV4L2NvbmZpZy5oPgoKICAtIDxs
aW51eC9jb25maWcuaD4gYXV0b21hdGljYWxseSBnZXRzIGluY2x1ZGVkIGJ5
IGtidWlsZApTaWduZWQtb2ZmLWJ5OiBLb21hbCBTaGFoIDxrb21hbF9zaGFo
ODAyMDAzQHlhaG9vLmNvbT4KCi0tLQoKIGFyY2gvYXJtL21hY2gtb21hcDEv
bWFpbGJveC5jICAgfCAgICAxIC0KIGFyY2gvYXJtL21hY2gtb21hcDIvZGV2
aWNlcy5jICAgfCAgICAxIC0KIGFyY2gvYXJtL21hY2gtb21hcDIvbWFpbGJv
eC5jICAgfCAgICAxIC0KIGFyY2gvYXJtL21hY2gtb21hcDIvcG0tZG9tYWlu
LmMgfCAgICAxIC0KIDQgZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKNGMwZTcyNzIyN2NkZDgyMzIzMDBmM2RjNTI3
OWY1YmNlZmE4MTk1ZQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFw
MS9tYWlsYm94LmMgYi9hcmNoL2FybS9tYWNoLW9tYXAxL21haWxib3guYwpp
bmRleCBhZDA3N2FmLi4yNzMyZTBkIDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
YWNoLW9tYXAxL21haWxib3guYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAx
L21haWxib3guYwpAQCAtOSw3ICs5LDYgQEAKICAqIGZvciBtb3JlIGRldGFp
bHMuCiAgKi8KIAotI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgogI2luY2x1
ZGUgPGxpbnV4L2tlcm5lbC5oPgogI2luY2x1ZGUgPGFzbS9hcmNoL21haWxi
b3guaD4KICNpbmNsdWRlIDxhc20vYXJjaC9pcnFzLmg+CmRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLW9tYXAyL2RldmljZXMuYyBiL2FyY2gvYXJtL21h
Y2gtb21hcDIvZGV2aWNlcy5jCmluZGV4IDQ5ZDQ1YWUuLjU0NjE2ZjcgMTAw
NjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvZGV2aWNlcy5jCisrKyBi
L2FyY2gvYXJtL21hY2gtb21hcDIvZGV2aWNlcy5jCkBAIC05LDcgKzksNiBA
QAogICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICAq
LwogCi0jaW5jbHVkZSA8bGludXgvY29uZmlnLmg+CiAjaW5jbHVkZSA8bGlu
dXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5j
bHVkZSA8bGludXgvaW5pdC5oPgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFj
aC1vbWFwMi9tYWlsYm94LmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL21haWxi
b3guYwppbmRleCBkMzk5YzY4Li44MzVlMzQwIDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLW9tYXAyL21haWxib3guYworKysgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL21haWxib3guYwpAQCAtMTAsNyArMTAsNiBAQAogICogZm9yIG1v
cmUgZGV0YWlscy4KICAqLwogCi0jaW5jbHVkZSA8bGludXgvY29uZmlnLmg+
CiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVkZSA8bGludXgv
Y2xrLmg+CiAjaW5jbHVkZSA8bGludXgvZXJyLmg+CmRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLW9tYXAyL3BtLWRvbWFpbi5jIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMi9wbS1kb21haW4uYwppbmRleCA1ZTIwZTc0Li4yNDk0MDkxIDEw
MDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BtLWRvbWFpbi5jCisr
KyBiL2FyY2gvYXJtL21hY2gtb21hcDIvcG0tZG9tYWluLmMKQEAgLTE1LDcg
KzE1LDYgQEAKICAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLgogICovCiAKLSNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4K
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9p
bml0Lmg+CiAjaW5jbHVkZSA8bGludXgvY2xrLmg+Ci0tIAoxLjMuMwoK

--_----------=_1159184399147190
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1159184399147190--
