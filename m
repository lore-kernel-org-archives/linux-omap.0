From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [BUGFIX PATCH] ARM: OMAP: fix type of return values in
 omap_device_get_by_hwmod_name()
Date: Thu, 21 Mar 2013 13:13:10 +0100
Message-ID: <1363867990-24593-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-omap@vger.kernel.org

VGhlIG1lcmdlIGJkYTVlMTQxZmJlOTYyOTVjNjY5NjkyMTE0ZDE4Njg3NzMwMjY5ZmIgZXJyb25l
b3VzbHkgY2hhbmdlZAp0aGUgcmV0dXJuIHZhbHVlIG9mIHNvbWUgZXJyb3IgZXhpdHMgb2Ygb21h
cF9kZXZpY2VfZ2V0X2J5X2h3bW9kX25hbWUoKQpmcm9tIEVSUl9QVFIoKSB0byAtRU5PREVWLgoK
VGhpcyBmaXhlcyB0aGUgd2FybmluZ3M6CmFyY2gvYXJtL21hY2gtb21hcDIvb21hcF9kZXZpY2Uu
YzogSW4gZnVuY3Rpb24gJ29tYXBfZGV2aWNlX2dldF9ieV9od21vZF9uYW1lJzoKYXJjaC9hcm0v
bWFjaC1vbWFwMi9vbWFwX2RldmljZS5jOjgyMTozOiB3YXJuaW5nOiByZXR1cm4gbWFrZXMgcG9p
bnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QKYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFw
X2RldmljZS5jOjgyNjozOiB3YXJuaW5nOiByZXR1cm4gbWFrZXMgcG9pbnRlciBmcm9tIGludGVn
ZXIgd2l0aG91dCBhIGNhc3QKCgpTaWduZWQtb2ZmLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtB
Uk8tZWxlY3Ryb25pY3MuZGU+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2RldmljZS5j
IHwgICAgNCArKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXBfZGV2aWNlLmMgYi9h
cmNoL2FybS9tYWNoLW9tYXAyL29tYXBfZGV2aWNlLmMKaW5kZXggMjQ0OGM3YS4uZWVlYTRmYSAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2RldmljZS5jCisrKyBiL2FyY2gv
YXJtL21hY2gtb21hcDIvb21hcF9kZXZpY2UuYwpAQCAtODE4LDEyICs4MTgsMTIgQEAgc3RydWN0
IGRldmljZSAqb21hcF9kZXZpY2VfZ2V0X2J5X2h3bW9kX25hbWUoY29uc3QgY2hhciAqb2hfbmFt
ZSkKIAlpZiAoIW9oKSB7CiAJCVdBUk4oMSwgIiVzOiBubyBod21vZCBmb3IgJXNcbiIsIF9fZnVu
Y19fLAogCQkJb2hfbmFtZSk7Ci0JCXJldHVybiAtRU5PREVWOworCQlyZXR1cm4gRVJSX1BUUigt
RU5PREVWKTsKIAl9CiAJaWYgKCFvaC0+b2QpIHsKIAkJV0FSTigxLCAiJXM6IG5vIG9tYXBfZGV2
aWNlIGZvciAlc1xuIiwgX19mdW5jX18sCiAJCQlvaF9uYW1lKTsKLQkJcmV0dXJuIC1FTk9ERVY7
CisJCXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOwogCX0KIAogCXJldHVybiAmb2gtPm9kLT5wZGV2
LT5kZXY7Ci0tIAoxLjcuMi41CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
