From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/12 diet] ARM: OMAP2+: Remove legacy mux code
Date: Tue, 26 Nov 2013 15:40:41 -0800
Message-ID: <20131126234040.GT26766@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <20131126012647.GB26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21597 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758137Ab3KZXkp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 18:40:45 -0500
Content-Disposition: inline
In-Reply-To: <20131126012647.GB26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131125 17:27]:
> We can now use drivers/pinctrl-single.c instead.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Here's a diet version of this patch that does not remove the mux*.[ch]
> files because it was too big for the mailing lists.
> 
> The full version of the patch is available at:
> 
> http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/?id=10f4ba76928338e78a63c7f68e5a491bdbc46554
> 
> And it also removes the following:
> 
>  arch/arm/mach-omap2/mux.c          | 1161 --------------------
>  arch/arm/mach-omap2/mux.h          |  355 ------
>  arch/arm/mach-omap2/mux34xx.c      | 2061 -------------------------------------
>  arch/arm/mach-omap2/mux34xx.h      |  402 -------
> 
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 66b7218..8e6b0a4 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  	-I$(srctree)/arch/arm/plat-omap/include
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o fb.o gpmc.o timer.o pm.o \
> +obj-y := id.o io.o control.o devices.o fb.o gpmc.o timer.o pm.o \
>  	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
>  	 omap_device.o sram.o drm.o
>  
> @@ -64,9 +64,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= omap4-restart.o
>  obj-$(CONFIG_SOC_OMAP5)			+= omap4-restart.o
>  obj-$(CONFIG_SOC_DRA7XX)		+= omap4-restart.o
>  
> -# Pin multiplexing
> -obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
> -
>  # SMS/SDRC
>  obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
>  # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 240db38..a3040a4 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -69,15 +69,6 @@ static inline int omap4_pm_init(void)
>  }
>  #endif
>  
> -#ifdef CONFIG_OMAP_MUX
> -int omap_mux_late_init(void);
> -#else
> -static inline int omap_mux_late_init(void)
> -{
> -	return 0;
> -}
> -#endif
> -
>  extern void omap2_init_common_infrastructure(void);
>  
>  extern void omap2_sync32k_timer_init(void);

Looks like we can now also move the related Kconfig entries from plat-omap to be
mach-omap1 specific, so I'll fold in the following changes.

Regards,

Tony


--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -31,6 +31,32 @@ config ARCH_OMAP16XX
 	select ARCH_OMAP_OTG
 	select CPU_ARM926T
 
+config OMAP_MUX
+	bool "OMAP multiplexing support"
+	depends on ARCH_OMAP
+	default y
+	help
+	  Pin multiplexing support for OMAP boards. If your bootloader
+	  sets the multiplexing correctly, say N. Otherwise, or if unsure,
+	  say Y.
+
+config OMAP_MUX_DEBUG
+	bool "Multiplexing debug output"
+	depends on OMAP_MUX
+	help
+	  Makes the multiplexing functions print out a lot of debug info.
+	  This is useful if you want to find out the correct values of the
+	  multiplexing registers.
+
+config OMAP_MUX_WARNINGS
+	bool "Warn about pins the bootloader didn't set up"
+	depends on OMAP_MUX
+	default y
+	help
+	  Choose Y here to warn whenever driver initialization logic needs
+	  to change the pin multiplexing setup.	 When there are no warnings
+	  printed, it's safe to deselect OMAP_MUX for your product.
+
 comment "OMAP Board Type"
 	depends on ARCH_OMAP1
 
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -60,32 +60,6 @@ config OMAP_RESET_CLOCKS
 	  probably do not want this option enabled until your
 	  device drivers work properly.
 
-config OMAP_MUX
-	bool "OMAP multiplexing support"
-	depends on ARCH_OMAP
-	default y
-	help
-	  Pin multiplexing support for OMAP boards. If your bootloader
-	  sets the multiplexing correctly, say N. Otherwise, or if unsure,
-	  say Y.
-
-config OMAP_MUX_DEBUG
-	bool "Multiplexing debug output"
-	depends on OMAP_MUX
-	help
-	  Makes the multiplexing functions print out a lot of debug info.
-	  This is useful if you want to find out the correct values of the
-	  multiplexing registers.
-
-config OMAP_MUX_WARNINGS
-	bool "Warn about pins the bootloader didn't set up"
-	depends on OMAP_MUX
-	default y
-	help
-	  Choose Y here to warn whenever driver initialization logic needs
-	  to change the pin multiplexing setup.	 When there are no warnings
-	  printed, it's safe to deselect OMAP_MUX for your product.
-
 config OMAP_IOMMU_IVA2
 	bool
 
