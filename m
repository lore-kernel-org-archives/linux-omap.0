From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] OMAP: hsmmc: fix memory leak
Date: Wed, 10 Feb 2010 14:28:00 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1002101419540.20129@ak-desktop>
References: <1265632385-27448-1-git-send-email-aaro.koskinen@nokia.com> <20100209231732.GM21755@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2137807480-1265804884=:20129"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29623 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab0BJM2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 07:28:20 -0500
In-Reply-To: <20100209231732.GM21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Koskinen Aaro (Nokia-D/Helsinki)" <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter Adrian (Nokia-D/Helsinki)" <adrian.hunter@nokia.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2137807480-1265804884=:20129
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,

On Wed, 10 Feb 2010, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@nokia.com> [100208 04:29]:
>> The platform data allocated with kmalloc() will become unreachable once
>> the init is complete, so it should be freed. The problem was discovered
>> by kmemleak.
>
> Looks like this is safe to do as platform_device_add_data does kmemdup
> on the data.
>
> BTW, if you want to create a version for 2.6.33, we should still have
> enough time to queue it as a fix. It's a very limited size leak though,
> but still a leak.

The version for 2.6.33 is below (also attached).

...

From: Aaro Koskinen <aaro.koskinen@nokia.com>
Date: Thu, 4 Feb 2010 13:06:59 +0200
Subject: [PATCH] OMAP: hsmmc: fix memory leak

The platform data allocated with kmalloc() will become unreachable once
the init is complete, so it should be freed. The problem was discovered
by kmemleak.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
  arch/arm/mach-omap2/mmc-twl4030.c |    7 ++++++-
  1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 0c3c72d..8afe9dd 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -408,6 +408,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
  {
  	struct twl4030_hsmmc_info *c;
  	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
+	int i;

  	if (cpu_is_omap2430()) {
  		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
@@ -434,7 +435,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
  		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
  		if (!mmc) {
  			pr_err("Cannot allocate memory for mmc device!\n");
-			return;
+			goto done;
  		}

  		if (c->name)
@@ -532,6 +533,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
  			continue;
  		c->dev = mmc->dev;
  	}
+
+done:
+	for (i = 0; i < nr_hsmmc; i++)
+		kfree(hsmmc_data[i]);
  }

  #endif
-- 
1.5.6.5

--8323329-2137807480-1265804884=:20129
Content-Type: TEXT/x-diff; name=0001-OMAP-hsmmc-fix-memory-leak.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.00.1002101428000.20129@ak-desktop>
Content-Description: patch
Content-Disposition: attachment; filename=0001-OMAP-hsmmc-fix-memory-leak.patch

RnJvbSA2ZDE1ZjQ4ZWNjMTc3YmRlMTgwMzNhZjI4ODRlYjJjNWNlNTNiZmQ3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogQWFybyBLb3NraW5l
biA8YWFyby5rb3NraW5lbkBub2tpYS5jb20+DQpEYXRlOiBUaHUsIDQgRmVi
IDIwMTAgMTM6MDY6NTkgKzAyMDANClN1YmplY3Q6IFtQQVRDSF0gT01BUDog
aHNtbWM6IGZpeCBtZW1vcnkgbGVhaw0KDQpUaGUgcGxhdGZvcm0gZGF0YSBh
bGxvY2F0ZWQgd2l0aCBrbWFsbG9jKCkgd2lsbCBiZWNvbWUgdW5yZWFjaGFi
bGUgb25jZQ0KdGhlIGluaXQgaXMgY29tcGxldGUsIHNvIGl0IHNob3VsZCBi
ZSBmcmVlZC4gVGhlIHByb2JsZW0gd2FzIGRpc2NvdmVyZWQNCmJ5IGttZW1s
ZWFrLg0KDQpTaWduZWQtb2ZmLWJ5OiBBYXJvIEtvc2tpbmVuIDxhYXJvLmtv
c2tpbmVuQG5va2lhLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL21hY2gtb21hcDIv
bW1jLXR3bDQwMzAuYyB8ICAgIDcgKysrKysrLQ0KIDEgZmlsZXMgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9tbWMtdHdsNDAzMC5jIGIvYXJj
aC9hcm0vbWFjaC1vbWFwMi9tbWMtdHdsNDAzMC5jDQppbmRleCAwYzNjNzJk
Li44YWZlOWRkIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9t
bWMtdHdsNDAzMC5jDQorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL21tYy10
d2w0MDMwLmMNCkBAIC00MDgsNiArNDA4LDcgQEAgdm9pZCBfX2luaXQgdHds
NDAzMF9tbWNfaW5pdChzdHJ1Y3QgdHdsNDAzMF9oc21tY19pbmZvICpjb250
cm9sbGVycykNCiB7DQogCXN0cnVjdCB0d2w0MDMwX2hzbW1jX2luZm8gKmM7
DQogCWludCBucl9oc21tYyA9IEFSUkFZX1NJWkUoaHNtbWNfZGF0YSk7DQor
CWludCBpOw0KIA0KIAlpZiAoY3B1X2lzX29tYXAyNDMwKCkpIHsNCiAJCWNv
bnRyb2xfcGJpYXNfb2Zmc2V0ID0gT01BUDI0M1hfQ09OVFJPTF9QQklBU19M
SVRFOw0KQEAgLTQzNCw3ICs0MzUsNyBAQCB2b2lkIF9faW5pdCB0d2w0MDMw
X21tY19pbml0KHN0cnVjdCB0d2w0MDMwX2hzbW1jX2luZm8gKmNvbnRyb2xs
ZXJzKQ0KIAkJbW1jID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG9tYXBfbW1j
X3BsYXRmb3JtX2RhdGEpLCBHRlBfS0VSTkVMKTsNCiAJCWlmICghbW1jKSB7
DQogCQkJcHJfZXJyKCJDYW5ub3QgYWxsb2NhdGUgbWVtb3J5IGZvciBtbWMg
ZGV2aWNlIVxuIik7DQotCQkJcmV0dXJuOw0KKwkJCWdvdG8gZG9uZTsNCiAJ
CX0NCiANCiAJCWlmIChjLT5uYW1lKQ0KQEAgLTUzMiw2ICs1MzMsMTAgQEAg
dm9pZCBfX2luaXQgdHdsNDAzMF9tbWNfaW5pdChzdHJ1Y3QgdHdsNDAzMF9o
c21tY19pbmZvICpjb250cm9sbGVycykNCiAJCQljb250aW51ZTsNCiAJCWMt
PmRldiA9IG1tYy0+ZGV2Ow0KIAl9DQorDQorZG9uZToNCisJZm9yIChpID0g
MDsgaSA8IG5yX2hzbW1jOyBpKyspDQorCQlrZnJlZShoc21tY19kYXRhW2ld
KTsNCiB9DQogDQogI2VuZGlmDQotLSANCjEuNS42LjUNCg0K

--8323329-2137807480-1265804884=:20129--
