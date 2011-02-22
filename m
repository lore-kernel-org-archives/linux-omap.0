From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Linux-next as of 20110222 broken on OMAP4
Date: Tue, 22 Feb 2011 18:43:52 +0530
Message-ID: <113477ac814f1e227f26f4963d7d624a@mail.gmail.com>
References: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com> <4D63B160.3010103@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175ca9e285b7f8049cdec0da
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40805 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812Ab1BVNNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 08:13:54 -0500
Received: by mail-qw0-f50.google.com with SMTP id 3so1775765qwk.9
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 05:13:53 -0800 (PST)
In-Reply-To: <4D63B160.3010103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Anand Gadiyar <gadiyar@ti.com>

--0015175ca9e285b7f8049cdec0da
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Cousson, Benoit
> Sent: Tuesday, February 22, 2011 6:22 PM
> To: Gadiyar, Anand
> Cc: linux-omap
> Subject: Re: Linux-next as of 20110222 broken on OMAP4
>
> Hi Anand,
>
> On 2/22/2011 10:49 AM, Gadiyar, Anand wrote:
> > Looks like linux-next as of today is broken on at least OMAP4.
> >
> > Turning on earlyprintk, I get a crash in omap_init_mcspi.
> Disabling
> > CONFIG_SPI_OMAP24XX gets me as far as the following lines from my
> > bootup log, but I haven't attempted to debug further.
> >
> > If there are any patches out there to fix this, let me know.
> > Else I will debug this sometime tomorrow.
>
> Yes, it was discussed with Tony and temporarily fixed yesterday.
>
> The SPI fix is is already in omap-for-linus, and the timer1 temp fix
> is below.
> We need to find a better way to handle timer now that they are
> initialized pretty soon.
>
Here is an alternate patch as per discussion with Paul.

------
>From e0bb923cb6fdde0f3f39184647238d6d1c6f5bf2 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 22 Feb 2011 16:46:29 +0530
Subject: [PATCH] omap: Move omap_hwmod_late_init() to mdesc->timer->init()
code

To adhere to recent early_init changes, commit '44dc0' made
omap_hwmod_late_init() to core_initcall to avoid ioremap() failures.

Later 'e7c7d7' removed _mpu_rt_va population omap_hwmod_late_init()

So now if we move the  omap_hwmod_late_init() to mdesc->timer->init(),
timer1 should work with hwmod instead of any special hwmod settings.

This was proposed by Paul Walmsley <paul@pwsan.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +--
 arch/arm/mach-omap2/timer-gp.c               |    4 +++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c
b/arch/arm/mach-omap2/omap_hwmod.c
index 9e89a58..b39cb40 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1646,7 +1646,7 @@ static int __init _populate_mpu_rt_base(struct
omap_hwmod *oh, void *data)
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-static int __init omap_hwmod_late_init(void)
+int __init omap_hwmod_late_init(void)
 {
 	int r;

@@ -1664,7 +1664,6 @@ static int __init omap_hwmod_late_init(void)

 	return 0;
 }
-core_initcall(omap_hwmod_late_init);

 /**
  * omap_hwmod_enable - enable an omap_hwmod
diff --git a/arch/arm/mach-omap2/timer-gp.c
b/arch/arm/mach-omap2/timer-gp.c
index 7b7c268..319ca42 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -37,8 +37,9 @@
 #include <linux/clockchips.h>

 #include <asm/mach/time.h>
-#include <plat/dmtimer.h>
 #include <asm/localtimer.h>
+#include <plat/dmtimer.h>
+#include <plat/omap_hwmod.h>

 #include "timer-gp.h"

@@ -231,6 +232,7 @@ static void __init omap2_gp_clocksource_init(void)

 static void __init omap2_gp_timer_init(void)
 {
+	omap_hwmod_late_init();
 #ifdef CONFIG_LOCAL_TIMERS
 	if (cpu_is_omap44xx()) {
 		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index fedd829..e2bdbb3 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -536,6 +536,7 @@ struct omap_hwmod {
 };

 int omap_hwmod_init(struct omap_hwmod **ohs);
+int omap_hwmod_late_init(void);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
-- 
1.6.0.4

--0015175ca9e285b7f8049cdec0da
Content-Type: application/octet-stream;
	name="0001-omap-Move-omap_hwmod_late_init-to-mdesc-timer-i.patch"
Content-Disposition: attachment;
	filename="0001-omap-Move-omap_hwmod_late_init-to-mdesc-timer-i.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1623363bb482aa8d_0.1

RnJvbSBlMGJiOTIzY2I2ZmRkZTBmM2YzOTE4NDY0NzIzOGQ2ZDFjNmY1YmYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUdWUsIDIyIEZlYiAyMDExIDE2OjQ2OjI5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gb21hcDogTW92ZSBvbWFwX2h3bW9kX2xhdGVfaW5pdCgpIHRvIG1kZXNjLT50aW1lci0+
aW5pdCgpIGNvZGUKClRvIGFkaGVyZSB0byByZWNlbnQgZWFybHlfaW5pdCBjaGFuZ2VzLCBjb21t
aXQgJzQ0ZGMwJyBtYWRlCm9tYXBfaHdtb2RfbGF0ZV9pbml0KCkgdG8gY29yZV9pbml0Y2FsbCB0
byBhdm9pZCBpb3JlbWFwKCkgZmFpbHVyZXMuCgpMYXRlciAnZTdjN2Q3JyByZW1vdmVkIF9tcHVf
cnRfdmEgcG9wdWxhdGlvbiBvbWFwX2h3bW9kX2xhdGVfaW5pdCgpCgpTbyBub3cgaWYgd2UgbW92
ZSB0aGUgIG9tYXBfaHdtb2RfbGF0ZV9pbml0KCkgdG8gbWRlc2MtPnRpbWVyLT5pbml0KCksCnRp
bWVyMSBzaG91bGQgd29yayB3aXRoIGh3bW9kIGluc3RlYWQgb2YgYW55IHNwZWNpYWwgaHdtb2Qg
c2V0dGluZ3MuCgpUaGlzIHdhcyBwcm9wb3NlZCBieSBQYXVsIFdhbG1zbGV5IDxwYXVsQHB3c2Fu
LmNvbT4KClNpZ25lZC1vZmYtYnk6IFNhbnRvc2ggU2hpbGlta2FyIDxzYW50b3NoLnNoaWxpbWth
ckB0aS5jb20+CkNjOiBQYXVsIFdhbG1zbGV5IDxwYXVsQHB3c2FuLmNvbT4KQ2M6IFRvbnkgTGlu
ZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwX2h3
bW9kLmMgICAgICAgICAgICAgfCAgICAzICstLQogYXJjaC9hcm0vbWFjaC1vbWFwMi90aW1lci1n
cC5jICAgICAgICAgICAgICAgfCAgICA0ICsrKy0KIGFyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRl
L3BsYXQvb21hcF9od21vZC5oIHwgICAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL29t
YXBfaHdtb2QuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZC5jCmluZGV4IDllODlh
NTguLmIzOWNiNDAgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZC5j
CisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcF9od21vZC5jCkBAIC0xNjQ2LDcgKzE2NDYs
NyBAQCBzdGF0aWMgaW50IF9faW5pdCBfcG9wdWxhdGVfbXB1X3J0X2Jhc2Uoc3RydWN0IG9tYXBf
aHdtb2QgKm9oLCB2b2lkICpkYXRhKQogICogdG8gc3RydWN0IGNsayBwb2ludGVycyBmb3IgZWFj
aCByZWdpc3RlcmVkIG9tYXBfaHdtb2QuICBBbHNvIGNhbGxzCiAgKiBfc2V0dXAoKSBvbiBlYWNo
IGh3bW9kLiAgUmV0dXJucyAwLgogICovCi1zdGF0aWMgaW50IF9faW5pdCBvbWFwX2h3bW9kX2xh
dGVfaW5pdCh2b2lkKQoraW50IF9faW5pdCBvbWFwX2h3bW9kX2xhdGVfaW5pdCh2b2lkKQogewog
CWludCByOwogCkBAIC0xNjY0LDcgKzE2NjQsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBvbWFwX2h3
bW9kX2xhdGVfaW5pdCh2b2lkKQogCiAJcmV0dXJuIDA7CiB9Ci1jb3JlX2luaXRjYWxsKG9tYXBf
aHdtb2RfbGF0ZV9pbml0KTsKIAogLyoqCiAgKiBvbWFwX2h3bW9kX2VuYWJsZSAtIGVuYWJsZSBh
biBvbWFwX2h3bW9kCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLWdwLmMg
Yi9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLWdwLmMKaW5kZXggN2I3YzI2OC4uMzE5Y2E0MiAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi90aW1lci1ncC5jCisrKyBiL2FyY2gvYXJt
L21hY2gtb21hcDIvdGltZXItZ3AuYwpAQCAtMzcsOCArMzcsOSBAQAogI2luY2x1ZGUgPGxpbnV4
L2Nsb2NrY2hpcHMuaD4KIAogI2luY2x1ZGUgPGFzbS9tYWNoL3RpbWUuaD4KLSNpbmNsdWRlIDxw
bGF0L2RtdGltZXIuaD4KICNpbmNsdWRlIDxhc20vbG9jYWx0aW1lci5oPgorI2luY2x1ZGUgPHBs
YXQvZG10aW1lci5oPgorI2luY2x1ZGUgPHBsYXQvb21hcF9od21vZC5oPgogCiAjaW5jbHVkZSAi
dGltZXItZ3AuaCIKIApAQCAtMjMxLDYgKzIzMiw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFw
Ml9ncF9jbG9ja3NvdXJjZV9pbml0KHZvaWQpCiAKIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwMl9n
cF90aW1lcl9pbml0KHZvaWQpCiB7CisJb21hcF9od21vZF9sYXRlX2luaXQoKTsKICNpZmRlZiBD
T05GSUdfTE9DQUxfVElNRVJTCiAJaWYgKGNwdV9pc19vbWFwNDR4eCgpKSB7CiAJCXR3ZF9iYXNl
ID0gaW9yZW1hcChPTUFQNDRYWF9MT0NBTF9UV0RfQkFTRSwgU1pfMjU2KTsKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL3BsYXQvb21hcF9od21vZC5oIGIvYXJjaC9hcm0v
cGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwX2h3bW9kLmgKaW5kZXggZmVkZDgyOS4uZTJiZGJi
MyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwX2h3bW9k
LmgKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvcGxhdC9vbWFwX2h3bW9kLmgKQEAg
LTUzNiw2ICs1MzYsNyBAQCBzdHJ1Y3Qgb21hcF9od21vZCB7CiB9OwogCiBpbnQgb21hcF9od21v
ZF9pbml0KHN0cnVjdCBvbWFwX2h3bW9kICoqb2hzKTsKK2ludCBvbWFwX2h3bW9kX2xhdGVfaW5p
dCh2b2lkKTsKIHN0cnVjdCBvbWFwX2h3bW9kICpvbWFwX2h3bW9kX2xvb2t1cChjb25zdCBjaGFy
ICpuYW1lKTsKIGludCBvbWFwX2h3bW9kX2Zvcl9lYWNoKGludCAoKmZuKShzdHJ1Y3Qgb21hcF9o
d21vZCAqb2gsIHZvaWQgKmRhdGEpLAogCQkJdm9pZCAqZGF0YSk7Ci0tIAoxLjYuMC40Cgo=
--0015175ca9e285b7f8049cdec0da--
