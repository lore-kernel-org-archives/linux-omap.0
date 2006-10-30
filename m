From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: fix apollon USB device support
Date: Mon, 30 Oct 2006 10:54:54 +0000 (GMT)
Message-ID: <1677409.72261162205698728.JavaMail.weblogic@ep_ml02>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1925952371=="
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--===============1925952371==
Content-return: prohibited
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: base64

SGkgRGF2aWQsDQoNCkluIHRoZSBwcmV2aW91cyBwYXRjaCwgdGhlcmUncyBzb21lIGNoYW5nZXMg
aW4gVURDLg0KSXQgbWFrZXMgdGhlIGFwb2xsb24gVVNCIGNhbid0IHdvcmsuDQpBZnRlciBzb21l
IHdvcmssIEkgZm91bmQgdGhhdCB5b3UgY2hhbmdlZCB0aGUgZG91YmxlLWJ1ZmZlcmluZyBjb25k
aXRpb24uIEl0IGJyZWFrcyB0aGUgYXBvbGxvbiBiZWhhdmlvci4NCg0KUGxlYXNlIGFwcGVuZCBh
cG9sbG9uIGJvYXJkIGNvbmRpdGlvbiB3aGVuIHdlIHVzZSB0aGUgcGlvIG1vZGUsIHRoZW4gZG9u
J3QgdXNlIGRvdWJsZS1idWZmZXJpbmcuDQphbmQgYWxzbyBmaXggc29tZSBjb21waWxlciB3YXJu
aW5nDQoNCkFSTTogT01BUDogZml4IGFwb2xsb24gVVNCIGRldmljZSBzdXBwb3J0DQoNCgktIEFk
ZCBhcG9sbG9uIHVzZSB0aGUgbm9uLWRvdWJsZS1idWZmZXJpbmcgaW4gUElPIG1vZGUNCgktIGZp
eCBjb21waWxlciB3YXJuaW5nDQoNClNpZ25lZC1vZmYtYnk6IEt5dW5nbWluIFBhcmsgPGt5dW5n
bWluLnBhcmtAc2Ftc3VuZy5jb20+DQoNCi0tDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9n
YWRnZXQvb21hcF91ZGMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9vbWFwX3VkYy5jDQppbmRleCBj
ZWJhMGE0Li40NDliNzZiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L29tYXBfdWRj
LmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9vbWFwX3VkYy5jDQpAQCAtMjU3OSw2ICsyNTc5
LDcgQEAgb21hcF9lcF9zZXR1cChjaGFyICpuYW1lLCB1OCBhZGRyLCB1OCB0eQ0KIAkJICogKGZv
ciBtb3JlIHJlbGlhYmxlIGJlaGF2aW9yKQ0KIAkJICovDQogCQlpZiAoKCF1c2VfZG1hICYmIChh
ZGRyICYgVVNCX0RJUl9JTikpDQorCQkJCXx8IG1hY2hpbmVfaXNfb21hcF9hcG9sbG9uKCkNCiAJ
CQkJfHwgY3B1X2lzX29tYXAxNXh4KCkpDQogCQkJZGJ1ZiA9IDA7DQogDQpAQCAtMjk2Myw5ICsy
OTY0LDEwIEBAIGtub3duOg0KIAl9DQogDQogCWNyZWF0ZV9wcm9jX2ZpbGUoKTsNCi0JZGV2aWNl
X2FkZCgmdWRjLT5nYWRnZXQuZGV2KTsNCi0JcmV0dXJuIDA7DQotDQorCXN0YXR1cyA9IGRldmlj
ZV9hZGQoJnVkYy0+Z2FkZ2V0LmRldik7DQorCWlmICghc3RhdHVzKQ0KKwkJcmV0dXJuIHN0YXR1
czsNCisJLyogSWYgZmFpbCwgZmFsbCB0aHJvdWdoICovDQogI2lmZGVmCVVTRV9JU08NCiBjbGVh
bnVwMzoNCiAJZnJlZV9pcnEocGRldi0+cmVzb3VyY2VbMl0uc3RhcnQsIHVkYyk7DQoNCg==



--===============1925952371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1925952371==--
