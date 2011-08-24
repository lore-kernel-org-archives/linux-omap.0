From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 1/7] OMAP3+: boards: Fix the __initconst build error
Date: Wed, 24 Aug 2011 12:17:14 +0200
Message-ID: <1314181040-22807-2-git-send-email-b-cousson@ti.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58821 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946Ab1HXKTF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 06:19:05 -0400
In-Reply-To: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

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

