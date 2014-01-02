From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 21/26] ARM: omap: dma: get rid of errata global
Date: Thu, 02 Jan 2014 15:12:21 +0000
Message-ID: <E1Vyjwb-0005FL-Ux@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54146 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751452AbaABPMr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:12:47 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

There's no need for this to be a global variable; move it into the
errata configuration function instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/dma.c |    4 ++--
 arch/arm/mach-omap2/dma.c |    5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index de30e28ff487..4aae75d40bdd 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -33,7 +33,6 @@
 #define OMAP1_DMA_BASE			(0xfffed800)
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
 
-static u32 errata;
 static u32 enable_1510_mode;
 
 static const struct omap_dma_reg reg_map[] = {
@@ -244,8 +243,9 @@ static void omap1_show_dma_caps(void)
 	return;
 }
 
-static u32 configure_dma_errata(void)
+static unsigned configure_dma_errata(void)
 {
+	unsigned errata = 0;
 
 	/*
 	 * Erratum 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index e633b48a3fcb..244ff5012aed 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -35,8 +35,6 @@
 #include "omap_hwmod.h"
 #include "omap_device.h"
 
-static u32 errata;
-
 static struct omap_dma_dev_attr *d;
 
 static enum omap_reg_offsets dma_common_ch_end;
@@ -124,8 +122,9 @@ static void omap2_show_dma_caps(void)
 	return;
 }
 
-static u32 configure_dma_errata(void)
+static unsigned configure_dma_errata(void)
 {
+	unsigned errata = 0;
 
 	/*
 	 * Errata applicable for OMAP2430ES1.0 and all omap2420
-- 
1.7.4.4

