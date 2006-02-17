From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] omap keypad H4 update
Date: Fri, 17 Feb 2006 07:56:36 -0800 (PST)
Message-ID: <20060217155636.86588.qmail@web32910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2008163791-1140191796=:84360"
Content-Transfer-Encoding: 8bit
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

--0-2008163791-1140191796=:84360
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Move H4 Menelaus specific gpio settings to board-h4.c and fix
get_row_gpio_val function.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2008163791-1140191796=:84360
Content-Type: application/octet-stream; name="kp.patch"
Content-Transfer-Encoding: base64
Content-Description: 1686646119-kp.patch
Content-Disposition: attachment; filename="kp.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtaDQuYyBi
L2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtaDQuYwppbmRleCA5ZTY0ODQy
Li45MTNhYjNkIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL2Jv
YXJkLWg0LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1oNC5j
CkBAIC0zNCw2ICszNCw3IEBACiAjaW5jbHVkZSA8YXNtL2FyY2gvYm9hcmQu
aD4KICNpbmNsdWRlIDxhc20vYXJjaC9jb21tb24uaD4KICNpbmNsdWRlIDxh
c20vYXJjaC9rZXlwYWQuaD4KKyNpbmNsdWRlIDxhc20vYXJjaC9tZW5lbGF1
cy5oPgogI2luY2x1ZGUgInByY20tcmVncy5oIgogCiAjaW5jbHVkZSA8YXNt
L2lvLmg+CkBAIC0zMjcsNiArMzI4LDE1IEBAIHN0YXRpYyB2b2lkIF9faW5p
dCBvbWFwX2g0X2luaXQodm9pZCkKIAlvbWFwX2NmZ19yZWcoSzE1XzI0WFhf
VUFSVDNfVFgpOwogCW9tYXBfY2ZnX3JlZyhLMTRfMjRYWF9VQVJUM19SWCk7
CiAjZW5kaWYKKworI2lmIGRlZmluZWQoQ09ORklHX0tFWUJPQVJEX09NQVAp
IHx8IGRlZmluZWQoQ09ORklHX0tFWUJPQVJEX09NQVBfTU9EVUxFKQorCWlm
IChvbWFwX2hhc19tZW5lbGF1cygpKSB7CisJCXJvd19ncGlvc1s1XSA9IDA7
CisJCWNvbF9ncGlvc1syXSA9IDE1OworCQljb2xfZ3Bpb3NbNl0gPSAxODsK
Kwl9CisjZW5kaWYKKwogCXBsYXRmb3JtX2FkZF9kZXZpY2VzKGg0X2Rldmlj
ZXMsIEFSUkFZX1NJWkUoaDRfZGV2aWNlcykpOwogCW9tYXBfYm9hcmRfY29u
ZmlnID0gaDRfY29uZmlnOwogCW9tYXBfYm9hcmRfY29uZmlnX3NpemUgPSBB
UlJBWV9TSVpFKGg0X2NvbmZpZyk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
cHV0L2tleWJvYXJkL29tYXAta2V5cGFkLmMgYi9kcml2ZXJzL2lucHV0L2tl
eWJvYXJkL29tYXAta2V5cGFkLmMKaW5kZXggYzdjYmQ4NS4uZTYwNTdmYSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9vbWFwLWtleXBh
ZC5jCisrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvb21hcC1rZXlwYWQu
YwpAQCAtODMsNyArODMsNyBAQCBzdGF0aWMgdTggZ2V0X3Jvd19ncGlvX3Zh
bChzdHJ1Y3Qgb21hcF9rCiAJaW50IHJvdzsKIAl1OCB2YWx1ZSA9IDA7CiAK
LQlmb3IgKHJvdyA9IDA7IHJvdyA8IG9tYXBfa3AtPmNvbHM7IHJvdysrKSB7
CisJZm9yIChyb3cgPSAwOyByb3cgPCBvbWFwX2twLT5yb3dzOyByb3crKykg
ewogCQlpZiAob21hcF9nZXRfZ3Bpb19kYXRhaW4ocm93X2dwaW9zW3Jvd10p
KQogCQkJdmFsdWUgfD0gKDEgPDwgcm93KTsKIAl9Cg==

--0-2008163791-1140191796=:84360
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-2008163791-1140191796=:84360--
