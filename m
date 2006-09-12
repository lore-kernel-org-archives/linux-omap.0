From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: c55x dummy code as dspfs plugin
Date: Tue, 12 Sep 2006 15:05:26 +0530
Message-ID: <1158053726.18758.270711882@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1158053726187580";
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

--_----------=_1158053726187580
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Tue, 12 Sep 2006 09:35:26 UT

After applying the patch, please update arch/arm/mach-omap2/Makefile
to make it compile.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - Send your email first class


--_----------=_1158053726187580
Content-Disposition: attachment; filename="dsp.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="dsp.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Tue, 12 Sep 2006 09:35:26 UT

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvZHNwLmMgYi9hcmNo
L2FybS9tYWNoLW9tYXAyL2RzcC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAuLmZmYmEzMjAKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNo
L2FybS9tYWNoLW9tYXAyL2RzcC5jCkBAIC0wLDAgKzEsODcgQEAKKy8qCisg
KiBhcmNoL2FybS9tYWNoLW9tYXAyL2RzcC5jCisgKgorICogU3VwcG9ydCBE
U1AgKEM1NXgpIGZvciBPTUFQMjQyMCB1c2luZyBkc3Bmcy4KKyAqCisgKiBB
dXRob3I6IEtvbWFsIFNoYWggKGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29t
KQorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IHZlcnNpb24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb24uCisgKi8KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+
CisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgv
ZXJyLmg+CisjaW5jbHVkZSA8bGludXgvZHNwZnMuaD4KKyNpbmNsdWRlIDxs
aW51eC9tbS5oPgorI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2luY2x1
ZGUgPGxpbnV4L2ZzLmg+CisKK3N0cnVjdCBkZW50cnkgKmRlbnRyeTsKKwor
c3RhdGljIGludCBvbWFwX2RzcF9pbml0KHZvaWQqIGFyZykKK3sKKwlwcmlu
dGsoS0VSTl9OT1RJQ0UgIkRTUDogSW5pdGlhbGl6aW5nXG4iKTsKKworCXJl
dHVybiAwOworfQorCitzdGF0aWMgdm9pZCBvbWFwX2RzcF9leGl0KHZvaWQq
IGFyZykKK3sKKwlwcmludGsoS0VSTl9OT1RJQ0UgIkRTUDogRXhpdGluZ1xu
Iik7Cit9CisKK3N0YXRpYyBzc2l6ZV90IG9tYXBfZHNwX2Rpcl93cml0ZShz
dHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwKKwkJ
CQkgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCit7CisJcmV0dXJuIGdl
bmVyaWNfZmlsZV93cml0ZShmaWxlLCBidWYsIGNvdW50LCBwcG9zKTsKK30K
Kworc3RhdGljIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgb21hcF9kc3BfY29k
ZWNzX2Rpcl9mb3BzID0geworCS5vcGVuCQk9IGRjYWNoZV9kaXJfb3BlbiwK
KwkucmVsZWFzZQk9IGRjYWNoZV9kaXJfY2xvc2UsCisJLmxsc2VlawkJPSBk
Y2FjaGVfZGlyX2xzZWVrLAorCS5yZWFkCQk9IGdlbmVyaWNfcmVhZF9kaXIs
CisJLndyaXRlCQk9IG9tYXBfZHNwX2Rpcl93cml0ZSwKKwkucmVhZGRpcgk9
IGRjYWNoZV9yZWFkZGlyLAorfTsKKworc3RhdGljIHN0cnVjdCBmaWxlX29w
ZXJhdGlvbnMgb21hcF9kc3BfcGVyY29kZWNfZm9wcyA9IHsKKwkucmVhZCAg
PSBnZW5lcmljX2ZpbGVfcmVhZCwKKwkud3JpdGUgPSBnZW5lcmljX2ZpbGVf
d3JpdGUsCit9OworCitzdGF0aWMgc3RydWN0IHRyZWVfZGVzY3Igb21hcF9k
c3BfcGVyY29kZWNfZmlsZXNbXSA9IHsKKwl7ImZybWRhdGFfMCIsICZvbWFw
X2RzcF9wZXJjb2RlY19mb3BzLCBTX0lXVVNSIHwgU19JUlVHT30sCisJeyJm
cm1kYXRhXzEiLCAmb21hcF9kc3BfcGVyY29kZWNfZm9wcywgU19JV1VTUiB8
IFNfSVJVR099LAorCXsiIiB9LAorfTsKKworc3RhdGljIHN0cnVjdCBkc3Bf
aW5mbyBvbWFwX2RzcCA9IHsKKwkubmFtZQk9ICJjNTV4IiwKKwkucGFyZW50
ID0gTlVMTCwKKwkuaW5pdAk9IG9tYXBfZHNwX2luaXQsCisJLmV4aXQJPSBv
bWFwX2RzcF9leGl0LAorCS5mb3BzCT0gJm9tYXBfZHNwX2NvZGVjc19kaXJf
Zm9wcywKKwkucGVyY29kZWNfZmlsZXMgPSBvbWFwX2RzcF9wZXJjb2RlY19m
aWxlcywKK307CisKK3N0YXRpYyBpbnQgX19pbml0IG9tYXBfZHNwX2ZzX2lu
aXQodm9pZCkKK3sKKwlkZW50cnkgPSBkc3BfcmVnaXN0ZXIoJm9tYXBfZHNw
KTsKKworCWlmIChJU19FUlIoZGVudHJ5KSkKKwkJcmV0dXJuIFBUUl9FUlIo
ZGVudHJ5KTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBfX2V4
aXQgb21hcF9kc3BfZnNfZXhpdCh2b2lkKQoreworCWRzcF91bnJlZ2lzdGVy
KGRlbnRyeSk7Cit9CisKK21vZHVsZV9pbml0KG9tYXBfZHNwX2ZzX2luaXQp
OworbW9kdWxlX2V4aXQob21hcF9kc3BfZnNfZXhpdCk7CisKK01PRFVMRV9M
SUNFTlNFKCJHUEwiKTsK

--_----------=_1158053726187580
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1158053726187580--
