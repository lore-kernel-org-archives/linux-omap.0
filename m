From: "andrzej zaborowski" <balrog@zabor.org>
Subject: [PATCH] ARM: OMAP: correct misc 15xx and non-15xx platform code
Date: Fri, 22 Sep 2006 22:01:20 +0200
Message-ID: <fb249edb0609221301u6fc66d0ci51ddf77449a2656f@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_36712_18378397.1158955280431"
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
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_36712_18378397.1158955280431
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Disable accesses to SOFT_REQ_REG2 and ULPD_SOFT_DISABLE_REQ_REG
registers for 15xx processors that don't have these registers. Enable
level 2 interrupt handler for processors that identify as OMAP 15xx
(e.g 310) and not 1510 specifically. Also fix the following compiler
warning (only visible with CONFIG_OMAP_RESET_CLOCKS):

arch/arm/mach-omap1/clock.c: In function 'omap1_clk_disable_unused':
arch/arm/mach-omap1/clock.c:634: warning: 'return' with a value, in
function returning void

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_36712_18378397.1158955280431
Content-Type: application/octet-stream; name=linux-310-irqs.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esezhr18
Content-Disposition: attachment; filename="linux-310-irqs.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDEvY2xvY2suYyBiL2FyY2gvYXJtL21hY2gt
b21hcDEvY2xvY2suYwppbmRleCA3YTI1ZThkLi5lOWFhYmNmIDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9tYWNoLW9tYXAxL2Nsb2NrLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMS9jbG9jay5jCkBA
IC02MzEsNyArNjMxLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXAxX2Nsa19kaXNhYmxlX3Vu
dQogCWNsay0+ZGlzYWJsZShjbGspOwogCXByaW50aygiIGRvbmVcbiIpOwogCi0JcmV0dXJuIDA7
CisJcmV0dXJuOwogfQogCiAjZWxzZQpAQCAtNjU2LDcgKzY1Niw4IEBAIGludCBfX2luaXQgb21h
cDFfY2xrX2luaXQodm9pZCkKIAkvKiBVU0JfUkVRX0VOIHdpbGwgYmUgZGlzYWJsZWQgbGF0ZXIg
aWYgbmVjZXNzYXJ5ICh1c2JfZGNfY2spICovCiAJcmVnID0gb21hcF9yZWFkdyhTT0ZUX1JFUV9S
RUcpICYgKDEgPDwgNCk7CiAJb21hcF93cml0ZXcocmVnLCBTT0ZUX1JFUV9SRUcpOwotCW9tYXBf
d3JpdGV3KDAsIFNPRlRfUkVRX1JFRzIpOworCWlmICghY3B1X2lzX29tYXAxNXh4KCkpCisJCW9t
YXBfd3JpdGV3KDAsIFNPRlRfUkVRX1JFRzIpOwogCiAJY2xrX2luaXQoJm9tYXAxX2Nsa19mdW5j
dGlvbnMpOwogCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAxL2lycS5jIGIvYXJjaC9h
cm0vbWFjaC1vbWFwMS9pcnEuYwppbmRleCAzZWExNDBiLi40ODU0ODUyIDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW9tYXAxL2lycS5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDEvaXJxLmMK
QEAgLTIzOCw3ICsyMzgsNyBAQCAjZW5kaWYKIAogCWlmIChjcHVfaXNfb21hcDczMCgpKQogCQlv
bWFwX3VubWFza19pcnEoSU5UXzczMF9JSDJfSVJRKTsKLQllbHNlIGlmIChjcHVfaXNfb21hcDE1
MTAoKSkKKwllbHNlIGlmIChjcHVfaXNfb21hcDE1eHgoKSkKIAkJb21hcF91bm1hc2tfaXJxKElO
VF8xNTEwX0lIMl9JUlEpOwogCWVsc2UgaWYgKGNwdV9pc19vbWFwMTZ4eCgpKQogCQlvbWFwX3Vu
bWFza19pcnEoSU5UXzE2MTBfSUgyX0lSUSk7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9t
YXAxL3BtLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAxL3BtLmMKaW5kZXggY2Q3NjE4NS4uYmUyMTNh
MCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMS9wbS5jCisrKyBiL2FyY2gvYXJtL21h
Y2gtb21hcDEvcG0uYwpAQCAtMjU2LDcgKzI1Niw4IEBAIHZvaWQgb21hcF9wbV9zdXNwZW5kKHZv
aWQpCiAJCXRwczY1MDEwX3NldF9sZWQoTEVEMSwgT0ZGKTsKIAl9CiAKLQlvbWFwX3dyaXRldygw
eGZmZmYsIFVMUERfU09GVF9ESVNBQkxFX1JFUV9SRUcpOworCWlmICghY3B1X2lzX29tYXAxNXh4
KCkpCisJCW9tYXBfd3JpdGV3KDB4ZmZmZiwgVUxQRF9TT0ZUX0RJU0FCTEVfUkVRX1JFRyk7CiAK
IAkvKgogCSAqIFN0ZXAgMTogdHVybiBvZmYgaW50ZXJydXB0cyAoRklYTUU6IE5PVEU6IGFscmVh
ZHkgZGlzYWJsZWQpCkBAIC00MzQsNyArNDM3LDggQEAgdm9pZCBvbWFwX3BtX3N1c3BlbmQodm9p
ZCkKIAkJTVBVSTE2MTBfUkVTVE9SRShPTUFQX0lIMl8zX01JUik7CiAJfQogCi0Jb21hcF93cml0
ZXcoMCwgVUxQRF9TT0ZUX0RJU0FCTEVfUkVRX1JFRyk7CisJaWYgKCFjcHVfaXNfb21hcDE1eHgo
KSkKKwkJb21hcF93cml0ZXcoMCwgVUxQRF9TT0ZUX0RJU0FCTEVfUkVRX1JFRyk7CiAKIAkvKgog
CSAqIFJlZW5hYmxlIGludGVycnVwdHMK
------=_Part_36712_18378397.1158955280431
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_36712_18378397.1158955280431--
