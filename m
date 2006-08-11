From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: [PATCH] Unmask omap-keypad interrupt on suspend
Date: Fri, 11 Aug 2006 13:31:47 +0200
Message-ID: <fb249edb0608110431s5e9bf0a3r818300334f8fa520@mail.gmail.com>
References: <fb249edb0608110428g7bedff21s9320f2da5df447dc@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_109071_802613.1155295907074"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <fb249edb0608110428g7bedff21s9320f2da5df447dc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_109071_802613.1155295907074
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Another try. Sorry for spam, I keep forgetting something.]

Prevent keyboard interrupt from staying masked when omap-keypad driver
is suspended. Otherwise, when the driver is compiled in, the kernel
won't resume from a sleep state if any key on the keypad was still
pressed during suspending. This is because the driver masks keyboard
interrupt when irq is received and doesn't unmask it until after keys
are released.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_109071_802613.1155295907074
Content-Type: application/octet-stream; name=linux-keypad-suspend2.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqqlobqz
Content-Disposition: attachment; filename="linux-keypad-suspend2.patch"

LS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9vbWFwLWtleXBhZC5jCTIwMDYtMDgtMDUgMDU6
MTg6MDEuMDAwMDAwMDAwICswMDAwCisrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvb21hcC1r
ZXlwYWQuYwkyMDA2LTA4LTEwIDA2OjE5OjExLjAwMDAwMDAwMCArMDAwMApAQCAtMzMsNiArMzMs
NyBAQAogI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1f
ZGV2aWNlLmg+CiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4KKyNpbmNsdWRlIDxsaW51eC9zcGlu
bG9jay5oPgogI2luY2x1ZGUgPGFzbS9hcmNoL2lycXMuaD4KICNpbmNsdWRlIDxhc20vYXJjaC9n
cGlvLmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gvaGFyZHdhcmUuaD4KQEAgLTU5LDYgKzYwLDggQEAg
c3RydWN0IG9tYXBfa3AgewogCWludCBpcnE7CiAJdW5zaWduZWQgaW50IHJvd3M7CiAJdW5zaWdu
ZWQgaW50IGNvbHM7CisJaW50IHN1c3BlbmRlZDsKKwlzcGlubG9ja190IHN1c3BlbmRfbG9jazsK
IH07CiAKIERFQ0xBUkVfVEFTS0xFVF9ESVNBQkxFRChrcF90YXNrbGV0LCBvbWFwX2twX3Rhc2ts
ZXQsIDApOwpAQCAtOTksNiArMTAyLDEzIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBvbWFwX2twX2lu
dGVycnVwdChpbnQKIAkJCQkgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzKQogewogCXN0cnVjdCBv
bWFwX2twICpvbWFwX2twID0gZGV2X2lkOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisJc3Bpbl9s
b2NrX2lycXNhdmUoJm9tYXBfa3AtPnN1c3BlbmRfbG9jaywgZmxhZ3MpOworCisJaWYgKG9tYXBf
a3AtPnN1c3BlbmRlZCkKKwkJcmV0dXJuIElSUV9IQU5ETEVEOworCisJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmb21hcF9rcC0+c3VzcGVuZF9sb2NrLCBmbGFncyk7CiAKIAkvKiBkaXNhYmxlIGtl
eWJvYXJkIGludGVycnVwdCBhbmQgc2NoZWR1bGUgZm9yIGhhbmRsaW5nICovCiAJaWYgKGNwdV9p
c19vbWFwMjR4eCgpKSB7CkBAIC0yNzEsMTUgKzI4MSwyOSBAQCBzdGF0aWMgREVWSUNFX0FUVFIo
ZW5hYmxlLCBTX0lSVUdPIHwgU19JCiAjaWZkZWYgQ09ORklHX1BNCiBzdGF0aWMgaW50IG9tYXBf
a3Bfc3VzcGVuZChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYsIHBtX21lc3NhZ2VfdCBzdGF0
ZSkKIHsKLQkvKiBOb3RoaW5nIHlldCAqLworCXN0cnVjdCBvbWFwX2twICpvbWFwX2twID0gcGxh
dGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCXNwaW5fbG9j
a19pcnFzYXZlKCZvbWFwX2twLT5zdXNwZW5kX2xvY2ssIGZsYWdzKTsKKworCS8qCisJICogUmUt
ZW5hYmxlIHRoZSBpbnRlcnJ1cHQgaW4gY2FzZSBpdCBoYXMgYmVlbiBtYXNrZWQgYnkgdGhlCisJ
ICogaGFuZGxlciBhbmQgYSBrZXkgaXMgc3RpbGwgcHJlc3NlZC4gIFdlIG5lZWQgdGhlIGludGVy
cnVwdAorCSAqIHRvIHdha2UgdXMgdXAgZnJvbSBzdXNwZW5kZWQuCisJICovCisJaWYgKGNwdV9j
bGFzc19pc19vbWFwMSgpKQorCQlvbWFwX3dyaXRldygwLCBPTUFQX01QVUlPX0JBU0UgKyBPTUFQ
X01QVUlPX0tCRF9NQVNLSVQpOwogCisJb21hcF9rcC0+c3VzcGVuZGVkID0gMTsKKworCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJm9tYXBfa3AtPnN1c3BlbmRfbG9jaywgZmxhZ3MpOwogCXJldHVy
biAwOwogfQogCiBzdGF0aWMgaW50IG9tYXBfa3BfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKmRldikKIHsKLQkvKiBOb3RoaW5nIHlldCAqLworCXN0cnVjdCBvbWFwX2twICpvbWFwX2tw
ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsKIAorCW9tYXBfa3AtPnN1c3BlbmRlZCA9IDA7
CiAJcmV0dXJuIDA7CiB9CiAjZWxzZQpAQCAtMzUxLDYgKzM3NSw5IEBAIHN0YXRpYyBpbnQgX19p
bml0IG9tYXBfa3BfcHJvYmUoc3RydWN0IHAKIAkJfQogCX0KIAorCXNwaW5fbG9ja19pbml0KCZv
bWFwX2twLT5zdXNwZW5kX2xvY2spOworCW9tYXBfa3AtPnN1c3BlbmRlZCA9IDA7CisKIAlpbml0
X3RpbWVyKCZvbWFwX2twLT50aW1lcik7CiAJb21hcF9rcC0+dGltZXIuZnVuY3Rpb24gPSBvbWFw
X2twX3RpbWVyOwogCW9tYXBfa3AtPnRpbWVyLmRhdGEgPSAodW5zaWduZWQgbG9uZykgb21hcF9r
cDsK
------=_Part_109071_802613.1155295907074
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_109071_802613.1155295907074--
