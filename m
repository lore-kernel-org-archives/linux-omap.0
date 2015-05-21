From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] omap1 sparse irq support for v4.2
Date: Thu, 21 May 2015 14:47:13 +0200
Message-ID: <12764506.jQAKye8BGv@wuerfel>
References: <4094934.StqYY08vL5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62779 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbbEUMrs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 08:47:48 -0400
In-Reply-To: <4094934.StqYY08vL5@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, arm@kernel.org, linux-omap@vger.kernel.org

On Thursday 21 May 2015 14:14:12 Arnd Bergmann wrote:
> On Wednesday 20 May 2015 15:36:05 Tony Lindgren wrote:
> > Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
> > to making omap1 support multiarch. After this series we still need to
> > make omap1 use the common clock framework and fix up the drivers to not
> > rely on includes from mach and plat directories.
> > 
> > Note that this branch depends on a GPIO driver fix in v4.1-rc3
> > d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").
> > 
> 
> fwiw, I have another patch in my 'multiplatform' series that will add
> another baby step.
> 
> 8<---
> ARM: OMAP1: make header files local if possible
> 
> A number of header files in mach-omap1 are never included from outside
> of mach-omap1, so we can move them directly to that directory.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

and three more:

diff --git a/arch/arm/mach-omap1/board-h3.h b/arch/arm/mach-omap1/board-h3.h
index 78de535be3c5..f70c42801969 100644
--- a/arch/arm/mach-omap1/board-h3.h
+++ b/arch/arm/mach-omap1/board-h3.h
@@ -27,6 +27,8 @@
 #ifndef __ASM_ARCH_OMAP_H3_H
 #define __ASM_ARCH_OMAP_H3_H
 
+#include <mach/irqs.h>
+
 #define H3_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
 #	define H3_TPS_GPIO_MMC_PWR_EN	(H3_TPS_GPIO_BASE + 4)
 
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index e2fcdb8e5596..8a3690b2acbd 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -45,6 +45,7 @@
 
 #include <linux/omap-dma.h>
 
+#include <mach/hardware.h>
 #include <mach/usb.h>
 
 #include "omap_udc.h"
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6bb623a2a4df..1f6c8d91f738 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -34,6 +34,7 @@
 #include <sound/omap-pcm.h>
 
 #ifdef CONFIG_ARCH_OMAP1
+#include <mach/soc.h>
 #define pcm_omap1510()	cpu_is_omap1510()
 #else
 #define pcm_omap1510()	0

