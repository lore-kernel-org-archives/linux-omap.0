From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [RFC] OMAP3+: boards: Fix the __initconst build error for devicetree/test
 branch
Date: Fri, 19 Aug 2011 16:24:00 +0200
Message-ID: <4E4E7200.6080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38150 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167Ab1HSOYM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Aug 2011 10:24:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Hi Grant,

The current devicetree/test branch is broken due to the introduction of the __initconst for dt_compat table.

My original basic fix is the following one, but Felipe figured out the root cause. So it can be fixed by adding an extra const to make the whole table const:
-	const char		**dt_compat;	/* array of device tree
+	const char		* const *dt_compat; /* array of device tree

That fix will require fixing all the current users of dt_compat with something like that:

-static const char *omap3_beagle_dt_match[] __initconst = {
+static const char * const omap3_beagle_dt_match[] __initconst = {

A couple of of_XXX APIs will have to updated as well, that's why I was wondering if you wanted to go that way.

Any thought?

Regards,
Benoit

---
>From fcee9dbfeb44dc5c5b79f002e63be6e00d8f82b6 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Mon, 8 Aug 2011 11:30:45 +0200
Subject: [PATCH] OMAP3+: boards: Fix the __initconst build error

The __initconst introduced some build errors with the following
compiler version:
 arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2010.09-50) 4.5.1

arch/arm/mach-omap2/board-omap3beagle.c:566:20: error:
omap3_beagle_dt_match causes a section type conflict

Replace them by __initdata.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/board-igep0020.c    |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c  |    2 +-
 arch/arm/mach-omap2/board-overo.c       |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 249165a..2521823 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -671,7 +671,7 @@ static void __init igep_init(void)
 	}
 }
 
-static const char *igep2_dt_compat[] __initconst = {
+static const char *igep2_dt_compat[] __initdata = {
 	"ISEE,igep-v2",
 	NULL
 };
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b3b9cbc..a7923ca 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -563,7 +563,7 @@ static void __init omap3_beagle_init(void)
 	beagle_opp_init();
 }
 
-static const char *omap3_beagle_dt_match[] __initconst = {
+static const char *omap3_beagle_dt_match[] __initdata = {
 	"ti,omap3-beagle",
 	NULL
 };
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b526aa9..1c583c7 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -581,7 +581,7 @@ static void __init omap4_panda_map_io(void)
 	omap44xx_map_common_io();
 }
 
-static const char *omap4_panda_match[] __initconst = {
+static const char *omap4_panda_match[] __initdata = {
 	"ti,omap4-panda",
 	NULL,
 };
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 18ae2c2..f0b8489 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -560,7 +560,7 @@ static void __init overo_init(void)
 					"OVERO_GPIO_USBH_CPEN\n");
 }
 
-static const char *omap3_overo_dt_match[] __initconst = {
+static const char *omap3_overo_dt_match[] __initdata = {
 	"gumstix,omap3-overo",
 	NULL
 };
-- 
1.7.0.4


