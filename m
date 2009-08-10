From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1.5/5] OMAP: Fix testing of cpu defines for mach-omap1
Date: Mon, 10 Aug 2009 14:52:38 +0300
Message-ID: <20090810115236.GC1938@atomide.com>
References: <20090805141051.1964.74687.stgit@localhost> <20090805141427.1964.66931.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58549 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbZHJLwr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 07:52:47 -0400
Content-Disposition: inline
In-Reply-To: <20090805141427.1964.66931.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Nishant Kamat <nskamat@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Looks like this is needed before the 2/5 patch for DMA workaround patch to
keep compile working on mach-omap1 machines.

Regards,

Tony

--gatW/ieO32f1wygP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="cpu-remove-ifdef.patch"

>From f60e4730feab2b3d0101d059534123e04fc26862 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 10 Aug 2009 14:04:15 +0300
Subject: [PATCH] OMAP: Fix testing of cpu defines for mach-omap1

There's no need to keep these defines limited in the ifdef block
for mach-omap2. It will just cause problems testing for the CPU
revision in the common code, like the next patch does for the DMA
errata.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 285eaa3..11e73d9 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -378,9 +378,6 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
 				cpu_is_omap44xx())
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-			defined(CONFIG_ARCH_OMAP4)
-
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
 #define OMAP2420_REV_ES1_0	0x24200024
@@ -436,5 +433,3 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
-
-#endif    /* defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) */

--gatW/ieO32f1wygP--
