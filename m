From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Suspending with keypad bug (RFC)
Date: Sat, 5 Aug 2006 01:33:57 +0200
Message-ID: <fb249edb0608041633y58eef1b8we6f00cccf69c99a0@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_61545_26994874.1154734437328"
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

------=_Part_61545_26994874.1154734437328
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
  When the keypad driver is compiled in, the kernel won't resume from
a sleep state if any key on the keypad was pressed during suspending.
This is because the keypad driver masks the keyboard interrupt when
the irq is received and doesn't unmask it until after keys are
released. I don't know if it's true for all CPUs, it happens on my
board which is 15xx.

This may often be a problem when one of the keys is a power key (like
on PDAs) and you're in a console. If your device doesn't have UART2 it
effectively means a lock-up.

I unmasked the keyboard interrupt just before suspending, in pm.c and
this prevents the lock-ups but I don't know if it's a correct fix.
This results in that the device immediately resumes if any key is
still pressed after entering idle.

I came up with a different fix, in the keypad driver but it's a bit
more intrusive. With this the device sleeps peacefully until another
key-press is detected. What should be the correct behavior?
I'm attaching both changes.

Another approach could be to mask the irq in the MPU interrupt handler
registers instead of with keypad registers, maybe.
Regards,
Andrzej

------=_Part_61545_26994874.1154734437328
Content-Type: application/octet-stream; name=linux-keypad-suspend0.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqhadc23
Content-Disposition: attachment; filename="linux-keypad-suspend0.patch"

LS0tIGxpbnV4LW9tYXAtMi42LWdpdC9hcmNoL2FybS9tYWNoLW9tYXAxL3BtLmMJMjAwNi0wNy0w
NiAwMjo0Nzo1Ni4wMDAwMDAwMDAgKzAwMDAKKysrIGxpbnV4LW9tYXAtMi42LW5ld2J1aWxkL2Fy
Y2gvYXJtL21hY2gtb21hcDEvcG0uYwkyMDA2LTA4LTA1IDAwOjE2OjM4LjAwMDAwMDAwMCArMDAw
MApAQCAtNjAsNiArNjAsNyBAQAogI2luY2x1ZGUgPGFzbS9hcmNoL2RtYS5oPgogI2luY2x1ZGUg
PGFzbS9hcmNoL2RzcF9jb21tb24uaD4KICNpbmNsdWRlIDxhc20vYXJjaC9kbXRpbWVyLmg+Cisj
aW5jbHVkZSA8YXNtL2FyY2gvZ3Bpby5oPgogCiBzdGF0aWMgdW5zaWduZWQgaW50IGFybV9zbGVl
cF9zYXZlW0FSTV9TTEVFUF9TQVZFX1NJWkVdOwogc3RhdGljIHVuc2lnbmVkIHNob3J0IGRzcF9z
bGVlcF9zYXZlW0RTUF9TTEVFUF9TQVZFX1NJWkVdOwpAQCAtMjIyLDYgKzIyMSw5IEBAIHN0YXRp
YyB2b2lkIG9tYXBfcG1fd2FrZXVwX3NldHVwKHZvaWQpCiAJCQkJT01BUF9JUlFfQklUKElOVF83
MzBfTVBVSU9fS0VZUEFEKSksCiAJCQkJT01BUF9JSDJfMV9NSVIpOwogCX0gZWxzZSBpZiAoY3B1
X2lzX29tYXAxNXh4KCkpIHsKKwkJLyogTWFrZSBzdXJlIElOVF9LRVlCT0FSRCBpcyBlbmFibGVk
IGluIE1QVUlPICovCisJCW9tYXBfd3JpdGV3KDAsIE9NQVBfTVBVSU9fQkFTRSArIE9NQVBfTVBV
SU9fS0JEX01BU0tJVCk7CisKIAkJbGV2ZWwyX3dha2UgfD0gT01BUF9JUlFfQklUKElOVF9LRVlC
T0FSRCk7CiAJCW9tYXBfd3JpdGVsKH5sZXZlbDJfd2FrZSwgIE9NQVBfSUgyX01JUik7CiAJfSBl
bHNlIGlmIChjcHVfaXNfb21hcDE2eHgoKSkgewo=
------=_Part_61545_26994874.1154734437328
Content-Type: application/octet-stream; name=linux-keypad-suspend1.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqhaf04r
Content-Disposition: attachment; filename="linux-keypad-suspend1.patch"

LS0tIGxpbnV4LW9tYXAtMi42LWdpdC9kcml2ZXJzL2lucHV0L2tleWJvYXJkL29tYXAta2V5cGFk
LmMJMjAwNi0wNy0wNiAwMjo0ODowOS4wMDAwMDAwMDAgKzAwMDAKKysrIGxpbnV4LW9tYXAtMi42
LW5ld2J1aWxkL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvb21hcC1rZXlwYWQuYwkyMDA2LTA4LTA1
IDAwOjQwOjU0LjAwMDAwMDAwMCArMDAwMApAQCAtNTksNiArNTksNyBAQCBzdHJ1Y3Qgb21hcF9r
cCB7CiAJaW50IGlycTsKIAl1bnNpZ25lZCBpbnQgcm93czsKIAl1bnNpZ25lZCBpbnQgY29sczsK
KwlpbnQgc3VzcGVuZGVkOwogfTsKIAogREVDTEFSRV9UQVNLTEVUX0RJU0FCTEVEKGtwX3Rhc2ts
ZXQsIG9tYXBfa3BfdGFza2xldCwgMCk7CkBAIC0xMDAsNiArMTAxLDkgQEAgc3RhdGljIGlycXJl
dHVybl90IG9tYXBfa3BfaW50ZXJydXB0KGludAogewogCXN0cnVjdCBvbWFwX2twICpvbWFwX2tw
ID0gZGV2X2lkOwogCisJaWYgKG9tYXBfa3AtPnN1c3BlbmRlZCkKKwkJcmV0dXJuIElSUV9IQU5E
TEVEOworCiAJLyogZGlzYWJsZSBrZXlib2FyZCBpbnRlcnJ1cHQgYW5kIHNjaGVkdWxlIGZvciBo
YW5kbGluZyAqLwogCWlmIChjcHVfaXNfb21hcDI0eHgoKSkgewogCQlpbnQgaTsKQEAgLTI2OSwx
NSArMjczLDI0IEBAIHN0YXRpYyBERVZJQ0VfQVRUUihlbmFibGUsIFNfSVJVR08gfCBTX0kKICNp
ZmRlZiBDT05GSUdfUE0KIHN0YXRpYyBpbnQgb21hcF9rcF9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKmRldiwgcG1fbWVzc2FnZV90IHN0YXRlKQogewotCS8qIE5vdGhpbmcgeWV0ICov
CisJc3RydWN0IG9tYXBfa3AgKm9tYXBfa3AgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOwor
CisJb21hcF9rcC0+c3VzcGVuZGVkID0gMTsKKwkvKgorCSAqIFJlLWVuYWJsZSB0aGUgaW50ZXJy
dXB0IGluIGNhc2UgaXQgaGFzIGJlZW4gbWFza2VkIGJ5IHRoZQorCSAqIGhhbmRsZXIgYW5kIGEg
a2V5IGlzIHN0aWxsIHByZXNzZWQuICBXZSBuZWVkIHRoZSBpbnRlcnJ1cHQKKwkgKiB0byB3YWtl
IHVzIHVwIGZyb20gc3VzcGVuZGVkLgorCSAqLworCW9tYXBfd3JpdGV3KDAsIE9NQVBfTVBVSU9f
QkFTRSArIE9NQVBfTVBVSU9fS0JEX01BU0tJVCk7CiAKIAlyZXR1cm4gMDsKIH0KIAogc3RhdGlj
IGludCBvbWFwX2twX3Jlc3VtZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpCiB7Ci0JLyog
Tm90aGluZyB5ZXQgKi8KKwlzdHJ1Y3Qgb21hcF9rcCAqb21hcF9rcCA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKGRldik7CiAKKwlvbWFwX2twLT5zdXNwZW5kZWQgPSAwOwogCXJldHVybiAwOwogfQog
I2Vsc2UKQEAgLTM0OSw2ICszNjIsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBvbWFwX2twX3Byb2Jl
KHN0cnVjdCBwCiAJCX0KIAl9CiAKKwlvbWFwX2twLT5zdXNwZW5kZWQgPSAwOworCiAJaW5pdF90
aW1lcigmb21hcF9rcC0+dGltZXIpOwogCW9tYXBfa3AtPnRpbWVyLmZ1bmN0aW9uID0gb21hcF9r
cF90aW1lcjsKIAlvbWFwX2twLT50aW1lci5kYXRhID0gKHVuc2lnbmVkIGxvbmcpIG9tYXBfa3A7
Cg==
------=_Part_61545_26994874.1154734437328
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_61545_26994874.1154734437328--
