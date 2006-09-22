From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: [PATCH] Request OMAP MMC Write-protect pin
Date: Fri, 22 Sep 2006 22:10:15 +0200
Message-ID: <fb249edb0609221310y33ac7b4dse744a587d5b9d2bb@mail.gmail.com>
References: <fb249edb0609221308t5669679cra80f9888b895a346@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_36856_12679704.1158955815120"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0609221308t5669679cra80f9888b895a346@mail.gmail.com>
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

------=_Part_36856_12679704.1158955815120
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[Sorry, forgot about the actual diff]

Adds code that requests and frees the WP GPIO pin in OMAP MMC host
driver, similarly to how the MMC Power and MMC Cover-switch GPIOs are
treated.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_36856_12679704.1158955815120
Content-Type: application/octet-stream; name=linux-omap-wppin.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esf0bu7k
Content-Disposition: attachment; filename="linux-omap-wppin.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL29tYXAuYyBiL2RyaXZlcnMvbW1jL29tYXAuYwppbmRl
eCBhZTA4YTM3Li5hMDE2ODJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9vbWFwLmMKKysrIGIv
ZHJpdmVycy9tbWMvb21hcC5jCkBAIC0xMDA5LDcgKzEwMDksNyBAQCBzdGF0aWMgaW50IG1tY19v
bWFwX2dldF9ybyhzdHJ1Y3QgbW1jX2hvCiB7CiAJc3RydWN0IG1tY19vbWFwX2hvc3QgKmhvc3Qg
PSBtbWNfcHJpdihtbWMpOwogCi0JcmV0dXJuIGhvc3QtPndwX3BpbiAmJiBvbWFwX2dldF9ncGlv
X2RhdGFpbihob3N0LT53cF9waW4pOworCXJldHVybiAoaG9zdC0+d3BfcGluID49IDApICYmIG9t
YXBfZ2V0X2dwaW9fZGF0YWluKGhvc3QtPndwX3Bpbik7CiB9CiAKIHN0YXRpYyBzdHJ1Y3QgbW1j
X2hvc3Rfb3BzIG1tY19vbWFwX29wcyA9IHsKQEAgLTExMTcsOSArMTExNywxOSBAQCBzdGF0aWMg
aW50IF9faW5pdCBtbWNfb21hcF9wcm9iZShzdHJ1Y3QgCiAJCW9tYXBfc2V0X2dwaW9fZGlyZWN0
aW9uKGhvc3QtPnBvd2VyX3BpbiwgMCk7CiAJfQogCisJaWYgKGhvc3QtPndwX3BpbiA+PSAwKSB7
CisJCWlmICgocmV0ID0gb21hcF9yZXF1ZXN0X2dwaW8oaG9zdC0+d3BfcGluKSkgIT0gMCkgewor
CQkJZGV2X2VycihtbWNfZGV2KGhvc3QtPm1tYyksCisJCQkJIlVuYWJsZSB0byBnZXQgR1BJTyBw
aW4gZm9yIE1NQyAiCisJCQkJIndyaXRlLXByb3RlY3Qgc3dpdGNoXG4iKTsKKwkJCWdvdG8gZXJy
X2ZyZWVfcG93ZXJfZ3BpbzsKKwkJfQorCQlvbWFwX3NldF9ncGlvX2RpcmVjdGlvbihob3N0LT53
cF9waW4sIDEpOworCX0KKwogCXJldCA9IHJlcXVlc3RfaXJxKGhvc3QtPmlycSwgbW1jX29tYXBf
aXJxLCAwLCBEUklWRVJfTkFNRSwgaG9zdCk7CiAJaWYgKHJldCkKLQkJZ290byBlcnJfZnJlZV9w
b3dlcl9ncGlvOworCQlnb3RvIGVycl9mcmVlX3dwX2dwaW87CiAKIAlob3N0LT5kZXYgPSAmcGRl
di0+ZGV2OwogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGhvc3QpOwpAQCAtMTE3NSw2ICsx
MTg1LDkgQEAgbm9fc3dpdGNoOgogCQltbWNfZnJlZV9ob3N0KGhvc3QtPm1tYyk7CiAJfQogCitl
cnJfZnJlZV93cF9ncGlvOgorCWlmIChob3N0LT53cF9waW4gPj0gMCkKKwkJb21hcF9mcmVlX2dw
aW8oaG9zdC0+d3BfcGluKTsKIGVycl9mcmVlX3Bvd2VyX2dwaW86CiAJaWYgKGhvc3QtPnBvd2Vy
X3BpbiA+PSAwKQogCQlvbWFwX2ZyZWVfZ3Bpbyhob3N0LT5wb3dlcl9waW4pOwpAQCAtMTIwMyw2
ICsxMjE2LDggQEAgc3RhdGljIGludCBtbWNfb21hcF9yZW1vdmUoc3RydWN0IHBsYXRmbwogCW1t
Y19yZW1vdmVfaG9zdChob3N0LT5tbWMpOwogCWZyZWVfaXJxKGhvc3QtPmlycSwgaG9zdCk7CiAK
KwlpZiAoaG9zdC0+d3BfcGluID49IDApCisJCW9tYXBfZnJlZV9ncGlvKGhvc3QtPndwX3Bpbik7
CiAJaWYgKGhvc3QtPnBvd2VyX3BpbiA+PSAwKQogCQlvbWFwX2ZyZWVfZ3Bpbyhob3N0LT5wb3dl
cl9waW4pOwogCWlmIChob3N0LT5zd2l0Y2hfcGluID49IDApIHsK
------=_Part_36856_12679704.1158955815120
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_36856_12679704.1158955815120--
