From: <Toshihiro.Kobayashi@nokia.com>
Subject: [PATCH] ARM: OMAP: Fix for mailbox-omap1
Date: Wed, 8 Nov 2006 15:49:39 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F550321202C@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C70302.10D1229B"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, hiroshi.doyu@nokia.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70302.10D1229B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fix for omap1 mailbox driver.
This will enable DSP Gateway again.

I'll work more on mudularization of dsp and mailbox.

BR,
Toshihiro Kobayashi

------_=_NextPart_001_01C70302.10D1229B
Content-Type: application/octet-stream;
	name="patch-mailbox-omap1-fix"
Content-Transfer-Encoding: base64
Content-Description: patch-mailbox-omap1-fix
Content-Disposition: attachment;
	filename="patch-mailbox-omap1-fix"

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC1vbWFwMS9hcmNoL2FybS9tYWNoLW9tYXAxL21haWxib3gu
YyBsaW51eC0yLjYuMTgtb21hcDEtbmV3L2FyY2gvYXJtL21hY2gtb21hcDEvbWFpbGJveC5jCi0t
LSBsaW51eC0yLjYuMTgtb21hcDEvYXJjaC9hcm0vbWFjaC1vbWFwMS9tYWlsYm94LmMJMjAwNi0x
MS0wOCAxNToyODowMiArMDk6MDAKKysrIGxpbnV4LTIuNi4xOC1vbWFwMS1uZXcvYXJjaC9hcm0v
bWFjaC1vbWFwMS9tYWlsYm94LmMJMjAwNi0xMS0wOCAxNDozNDo1MCArMDk6MDAKQEAgLTY3LDcg
KzY3LDcgQEAKIG9tYXAxX21ib3hfZmlmb193cml0ZShzdHJ1Y3Qgb21hcF9tYm94ICptYm94LCBt
Ym94X21zZ190IG1zZykKIHsKIAlzdHJ1Y3Qgb21hcF9tYm94MV9maWZvICpmaWZvID0KLQkJJigo
c3RydWN0IG9tYXBfbWJveDFfcHJpdiAqKW1ib3gtPnByaXYpLT5yeF9maWZvOworCQkmKChzdHJ1
Y3Qgb21hcF9tYm94MV9wcml2ICopbWJveC0+cHJpdiktPnR4X2ZpZm87CiAKIAltYm94X3dyaXRl
X3JlZyhtc2cgJiAweGZmZmYsIGZpZm8tPmRhdGEpOwogCW1ib3hfd3JpdGVfcmVnKG1zZyA+PiAx
NiwgZmlmby0+Y21kKTsKQEAgLTExMCw2ICsxMTAsNyBAQAogfQogCiBzdHJ1Y3Qgb21hcF9tYm94
X29wcyBvbWFwMV9tYm94X29wcyA9IHsKKwkudHlwZSA9IE9NQVBfTUJPWF9UWVBFMSwKIAkuZmlm
b19yZWFkID0gb21hcDFfbWJveF9maWZvX3JlYWQsCiAJLmZpZm9fd3JpdGUgPSBvbWFwMV9tYm94
X2ZpZm9fd3JpdGUsCiAJLmZpZm9fZW1wdHkgPSBvbWFwMV9tYm94X2ZpZm9fZW1wdHksCmRpZmYg
LXVyTiBsaW51eC0yLjYuMTgtb21hcDEvYXJjaC9hcm0vcGxhdC1vbWFwL21haWxib3guYyBsaW51
eC0yLjYuMTgtb21hcDEtbmV3L2FyY2gvYXJtL3BsYXQtb21hcC9tYWlsYm94LmMKLS0tIGxpbnV4
LTIuNi4xOC1vbWFwMS9hcmNoL2FybS9wbGF0LW9tYXAvbWFpbGJveC5jCTIwMDYtMTEtMDggMTU6
Mjg6MDIgKzA5OjAwCisrKyBsaW51eC0yLjYuMTgtb21hcDEtbmV3L2FyY2gvYXJtL3BsYXQtb21h
cC9tYWlsYm94LmMJMjAwNi0xMS0wOCAxNToxNzozOCArMDk6MDAKQEAgLTExNCwxMCArMTE0LDEz
IEBACiAJc3RydWN0IG9tYXBfbWJveCAqbWJveCA9IChzdHJ1Y3Qgb21hcF9tYm94ICopcDsKIAlz
dHJ1Y3Qgb21hcF9tYnEgKm1icSA9IG1ib3gtPm1icTsKIAltYm94X21zZ190IG1zZzsKKwlpbnQg
d2FzX2Z1bGw7CiAKIAl3aGlsZSAoIW1icV9lbXB0eShtYnEpKSB7CisJCXdhc19mdWxsID0gbWJx
X2Z1bGwobWJxKTsKIAkJbXNnID0gbWJxX2dldChtYnEpOwotCQllbmFibGVfbWJveF9pcnEobWJv
eCwgSVJRX1JYKTsKKwkJaWYgKHdhc19mdWxsKQkvKiBub3cgd2UgaGF2ZSBhIHJvb20gaW4gdGhl
IG1icS4gKi8KKwkJCWVuYWJsZV9tYm94X2lycShtYm94LCBJUlFfUlgpOwogCiAJCWlmICh1bmxp
a2VseShtYm94X3NlcV90ZXN0KG1ib3gsIG1zZykpKSB7CiAJCQlwcmludGsoS0VSTl9FUlIK

------_=_NextPart_001_01C70302.10D1229B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C70302.10D1229B--
