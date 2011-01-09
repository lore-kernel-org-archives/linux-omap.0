From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC PATCH] Avoid aliasing mappings in DMA coherent allocator
Date: Sun, 9 Jan 2011 02:06:32 +0100
Message-ID: <201101090206.34096.jkrzyszt@tis.icnet.pl>
References: <20101224111125.GD20587@n2100.arm.linux.org.uk> <20110103095751.GA26785@n2100.arm.linux.org.uk> <201101031928.37091.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59542 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112Ab1AIBIN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 8 Jan 2011 20:08:13 -0500
In-Reply-To: <201101031928.37091.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

(Cc linux-omap, please refere to a copy of Russell's initial message:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/036463.html)

Monday 03 January 2011 19:28:36 Janusz Krzysztofik wrote:
> I'll try to prepare for review a followup patch that updates those
> <{mach,plat}/memory.h> and similiar include files which provided
> their own non-default CONSISTENT_DMA_SIZE values.

Below is an example of how a build time configuration for OMAP could 
be updated.

However, more looking at this, I think that a finer control of reserved 
memory area sizes, yet better selected at run time for a specific 
machine or board type, could be benefitial in case of kernels intended 
to run on multiple board types, like those built with omap1_defconfig, 
or even on multiple machine types, like in omap2plus_defconfig case.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---

--- linux-2.6.37-rc7/arch/arm/plat-omap/include/plat/memory.h.orig	2011-01-07 02:37:44.000000000 +0100
+++ linux-2.6.37-rc7/arch/arm/plat-omap/include/plat/memory.h	2011-01-07 03:01:25.000000000 +0100
@@ -86,17 +86,21 @@
 #endif	/* CONFIG_ARCH_OMAP15XX */
 
 /* Override the ARM default */
-#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
+#ifndef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
+#define CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE 0
+#endif
 
-#if (CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE == 0)
+#if (CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE == 0) && \
+	(defined(CONFIG_SND_OMAP_SOC) || defined(CONFIG_SND_OMAP_SOC_MODULE))
 #undef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-#define CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE 2
+#define CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE 1
 #endif
 
-#define CONSISTENT_DMA_SIZE \
-	(((CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE + 1) & ~1) * 1024 * 1024)
+#define CONSISTENT_WC_SIZE \
+	(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE * 1024 * 1024)
 
-#endif
+#define CONSISTENT_DMA_SIZE \
+	((CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE % 2 ? 1 : 2) * 1024 * 1024)
 
 #endif
 
--- linux-2.6.37-rc7/drivers/video/omap/Kconfig.orig	2010-12-24 13:42:46.000000000 +0100
+++ linux-2.6.37-rc7/drivers/video/omap/Kconfig	2011-01-07 01:56:45.000000000 +0100
@@ -85,9 +85,10 @@ config FB_OMAP_CONSISTENT_DMA_SIZE
	range 1 14
	default 2
 	help
- 	  Increase the DMA consistent memory size according to your video
+ 	  Increase the DMA writecombine memory size according to your video
 	  memory needs, for example if you want to use multiple planes.
-	  The size must be 2MB aligned.
+	  Note that 256kB can be consumed by OMAP sound driver if active.
+	  Specifying an odd number reduces DMA coherent memory from 2 to 1MB.
 	  If unsure say 1.
 
 config FB_OMAP_DMA_TUNE
