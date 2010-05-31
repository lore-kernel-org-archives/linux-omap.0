From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 6/6] omap: move generic omap3 features to generic
Date: Mon, 31 May 2010 22:18:14 +0300
Message-ID: <4C040B76.2090605@ti.com>
References: <1274585799-16226-1-git-send-email-nm@ti.com>	<1274585799-16226-2-git-send-email-nm@ti.com>	<1274585799-16226-3-git-send-email-nm@ti.com>	<1274585799-16226-4-git-send-email-nm@ti.com>	<1274585799-16226-5-git-send-email-nm@ti.com>	<1274585799-16226-6-git-send-email-nm@ti.com>	<1274585799-16226-7-git-send-email-nm@ti.com>	<AANLkTinsrRAYX4dvB8A8wPayfRc7wkULQtUSiJ9RxbWh@mail.gmail.com>	<4BFE9C14.9040703@ti.com>	<AANLkTinHOZXk9pYeSfsBiejU7x1w-rA2MRtC4BBoKK0r@mail.gmail.com>	<4C03ED47.6060308@gmail.com> <AANLkTin32ueXXPjVFbLt-cur2WlmFOmgPj6Zlr47tuff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000203030703080201060208"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0EaTS1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 15:18:27 -0400
In-Reply-To: <AANLkTin32ueXXPjVFbLt-cur2WlmFOmgPj6Zlr47tuff@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "S, Vishwanath" <vishwa.s@ti.com>

--------------000203030703080201060208
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 05/31/2010 09:46 PM, S, Venkatraman wrote:
> I understand that you might not have all platforms to test with, but
> let's not provide a
> 'generic feature api' without it being available for the supported platforms.
> It's incomplete without it.
well.. if you did read 0/6
http://marc.info/?l=linux-omap&m=127458581708411&w=2
"Caveat: this series just introduces the framework by reorganizing
the existing data, it does not attempt to define what the features
for OMAP1,2,3,4 would be. As usual, comments are welcome.
"
:) anyways, these are how the three follow on patches will look like 
(sample omap1,2,4 patches are attached), feel free to ack them after 
testing - but this patch 6/6 needs to be done prior to the remaining 
being added - that is one more reason why i stopped where I did.

Feel free to modify to rectify my patches and post good ones, as you 
see, you will need to do 6/6 before doing anything further anyways..

Regards,
Nishanth Menon

--------------000203030703080201060208
Content-Type: text/x-patch;
	name="0001-id-omap-introduce-omap4-feature.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-id-omap-introduce-omap4-feature.patch"

>From a4f7d23139f8ccfc6b0e910017a759faa0d59578 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Mon, 31 May 2010 14:03:28 -0500
Subject: [PATCH 1/3] omap: id: introduce omap4 feature

introduce basic omap4 feature framework

Signed-off-by: Nishanth Menon <nm@ti.com>
---
CAVEAT: COMPLETELY UNTESTED!!!
 arch/arm/mach-omap2/id.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 01555b6..e3f5994 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -267,6 +267,19 @@ static void __init omap3_check_revision(void)
 	}
 }
 
+static void __init omap4_check_features(void)
+{
+	/*
+	 * TODO: add a better check feature once we have
+	 * more decent feature check
+	 */
+	if (cpu_is_omap4430())
+		omap_features |= OMAP_HAS_L2CACHE |
+			OMAP_HAS_IVA |
+			OMAP_HAS_SGX |
+			OMAP_HAS_NEON;
+}
+
 static void __init omap4_check_revision(void)
 {
 	u32 idcode;
@@ -382,6 +395,7 @@ void __init omap2_check_revision(void)
 		return;
 	} else if (cpu_is_omap44xx()) {
 		omap4_check_revision();
+		omap4_check_features();
 		return;
 	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
-- 
1.6.3.3


--------------000203030703080201060208
Content-Type: text/x-patch;
	name="0002-omap-id-introduce-omap24xx-generic-features.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-omap-id-introduce-omap24xx-generic-features.patch"

>From 0e4c9df9870c29da19234a1f4be5227a289b6463 Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Mon, 31 May 2010 14:10:31 -0500
Subject: [PATCH 2/3] omap: id: introduce omap24xx generic features

introduce generic features for omap2. omap2 uses mbx, not sgx, and
it still has a dsp, though not iva2 as omap3 uses..

Signed-off-by: Nishanth Menon <nm@ti.com>
---
CAVEAT: COMPLETELY UNTESTED!!!
 arch/arm/mach-omap2/id.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e3f5994..fe634dd 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -102,6 +102,16 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
+static void __init omap24xx_check_features(void)
+{
+	/*
+	 * TODO: add a better check feature once we have
+	 * more decent feature check
+	 */
+	omap_features |= OMAP_HAS_L2CACHE |
+		OMAP_HAS_IVA;
+}
+
 static void __init omap24xx_check_revision(void)
 {
 	int i, j;
@@ -388,6 +398,7 @@ void __init omap2_check_revision(void)
 	 */
 	if (cpu_is_omap24xx()) {
 		omap24xx_check_revision();
+		omap24xx_check_features();
 	} else if (cpu_is_omap34xx()) {
 		omap3_check_revision();
 		omap3_check_features();
-- 
1.6.3.3


--------------000203030703080201060208
Content-Type: text/x-patch;
	name="0003-omap-id-add-feature-check-for-omap1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0003-omap-id-add-feature-check-for-omap1.patch"

>From c297e29bfd27c373af8d9bdc428f72cad2ef4e7a Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Mon, 31 May 2010 14:13:57 -0500
Subject: [PATCH 3/3] omap: id: add feature check for omap1

add a minimalist feature - l2cache for omap1.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
CAVEAT: COMPLETELY UNTESTED!!!
 arch/arm/mach-omap1/id.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 91dbb71..b98a17f 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -200,5 +200,11 @@ void __init omap1_check_revision(void)
 	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
 	       die_rev, omap_revision & 0xff, system_serial_low,
 	       system_serial_high);
+
+	/*
+	 * TODO: add a better check feature once we have
+	 * more decent feature check
+	 */
+	omap_features |= OMAP_HAS_L2CACHE;
 }
 
-- 
1.6.3.3


--------------000203030703080201060208--
