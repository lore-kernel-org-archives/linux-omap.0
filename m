From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as
 default
Date: Sat, 13 Sep 2008 21:18:07 +0300 (EEST)
Message-ID: <20080913.211807.00070439.Hiroshi.DOYU@nokia.com>
References: <20080913.074844.161898930.Hiroshi.DOYU@nokia.com>
	<20080913084740.GA7007@frodo>
	<20080913.125342.137248158.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28305 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbYIMSSY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 14:18:24 -0400
In-Reply-To: <20080913.125342.137248158.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: me@felipebalbi.com, x00omar@ti.com

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as default
Date: Sat, 13 Sep 2008 12:53:42 +0300 (EEST)

> Hi Felipe,
> 
> From: "ext Felipe Balbi" <me@felipebalbi.com>
> Subject: Re: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as default
> Date: Sat, 13 Sep 2008 11:47:40 +0300
> 
> > Hi Hiroshi,
> > 
> > On Sat, Sep 13, 2008 at 07:48:44AM +0300, Hiroshi DOYU wrote:
> > > I think that this configuration name "FB_OMAP_CONSISTENT_DMA_SIZE"
> > > sounds a bit strange because it is not specific to framebuffer.
> > 
> > I agree here, it's really not fb specific.
> > 
> > > So how about renaming this more generic name like
> > > "OMAP_CONSISTENT_DMA_SIZE"? Or making "CONSISTENT_DMA_SIZE" itself
> > > configurable in menuconfig?
> > 
> > For me it sounds like that value would change depending on the board, no?
> 
> Hm...this can be considered as a board specific, yes.
> 
> > So maybe that size should be set up during board init. Maybe bundled
> > inside omapX_globals ??
> 
> This sounds reasonable to me. Since FB and IVA are the only modules
> which depend on this size so far, expanding flexibility in menuconfig
> may no be necessary.

"omapX_globals" seems to be a structure to keep information specific
to omap CPU types, like:

    282:static struct omap_globals omap242x_globals = {
    301:static struct omap_globals omap243x_globals = {
    320:static struct omap_globals omap343x_globals = {

Since "CONSISTENT_DMA_SIZE" is configurable and doesn't always depend
on omap CPU type, but can depend on the system requirement in some
cases, it cannot be set in a member of h/w information structure,
"struct omap_globals".

Although this may be considered as a board specific from framebuffer
perspective, it's a multimedia system requirement from IVA
perspective. So it may be better not to bind this to a
board. Considering the current situation that TI dspbridge hasn't been
integrated in l-o, it would be better to leave this for the meanwhile.

Instead, I did small clean-up with FB_OMAP_CONSISTENT_DMA_SIZE;)
Inlined below:
-----

>From 6d5737a000c78db4fa14315845c1a98683dc44ee Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Sat, 13 Sep 2008 20:18:11 +0300
Subject: [PATCH 1/1] ARM: OMAP: Clean up FB_OMAP_CONSISTENT_DMA_SIZE

Since this value can be limited by "range" in Kconfig, unnecessary
value checking is removed.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/memory.h |    9 +--------
 drivers/video/omap/Kconfig               |    4 ++--
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat-omap/include/mach/memory.h
index 2d80fa2..28b9644 100644
--- a/arch/arm/plat-omap/include/mach/memory.h
+++ b/arch/arm/plat-omap/include/mach/memory.h
@@ -89,15 +89,8 @@
 
 /* Override the ARM default */
 #ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-
-#if (CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE == 0)
-#undef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-#define CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE 2
-#endif
-
 #define CONSISTENT_DMA_SIZE \
-	(((CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE + 1) & ~1) * 1024 * 1024)
-
+	(DIV_ROUND_UP((CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE, 2) * SZ_1M)
 #endif
 
 #endif
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 5ebd591..4526a1d 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -77,13 +77,13 @@ config FB_OMAP_BOOTLOADER_INIT
 config FB_OMAP_CONSISTENT_DMA_SIZE
 	int "Consistent DMA memory size (MB)"
 	depends on FB_OMAP
-	range 1 14
+	range 2 14
 	default 2
 	help
 	  Increase the DMA consistent memory size according to your video
 	  memory needs, for example if you want to use multiple planes.
 	  The size must be 2MB aligned.
-	  If unsure say 1.
+	  If unsure say 2.
 
 config FB_OMAP_DMA_TUNE
         bool "Set DMA SDRAM access priority high"
-- 
1.6.0.rc2

