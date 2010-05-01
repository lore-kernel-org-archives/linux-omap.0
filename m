From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: mailbox_mach dependency problem
Date: Sat, 1 May 2010 20:33:32 +0300
Message-ID: <20100501173328.GA4706@gandalf>
References: <h2g94a0d4531005010747n6ef7b7d0r9b4714d289d61032@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60212 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab0EARdY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 13:33:24 -0400
Content-Disposition: inline
In-Reply-To: <h2g94a0d4531005010747n6ef7b7d0r9b4714d289d61032@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <hiroshi.doyu@gmail.com>

Hi,

On Sat, May 01, 2010 at 05:47:57PM +0300, Felipe Contreras wrote:
> There seems to be a problem with 'mailbox' and 'mailbox_mach' modules.
> When another module, like bridgedriver, uses mailbox stuff, only the
> 'mailbox' module is loaded which doesn't register the platform device.
> 
> The easiest solution would be to make mailbox_mach built-in when
> mailbox is configured, however, mailbox_mach needs mailbox to be
> loaded.
> 
> I tried to add a poke() function in mailbox_mach so that the module is
> loaded when mailbox is loaded, but apparently linux doesn't like loop
> dependencies:
> WARNING: Loop detected: kernel/arch/arm/mach-omap2/mailbox_mach.ko
> needs mailbox.ko which needs mailbox_mach.ko again!
> 
> Any ideas how to solve this issue?

generally platform_device instantiation isn't compiled as a module. The
patch below should probably help but I didn't test it.

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index b6a537c..39a9e9e 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -15,8 +15,7 @@ obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 obj-$(CONFIG_PM) += pm.o sleep.o
 
 # DSP
-obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
-mailbox_mach-objs		:= mailbox.o
+obj-$(CONFIG_OMAP_MBOX_OMAP1)	+= mailbox.o
 
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
 obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..6813a60 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -86,8 +86,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 
-obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
-mailbox_mach-objs			:= mailbox.o
+obj-$(CONFIG_OMAP_MBOX_OMAP2)		+= mailbox.o
 
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6da796e..1c826c4 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -102,10 +102,18 @@ config OMAP_MCBSP
 config OMAP_MBOX_FWK
 	tristate "Mailbox framework support"
 	depends on ARCH_OMAP
+	select OMAP_MBOX_OMAP2 if ARCH_OMAP2PLUS
+	select OMAP_MBOX_OMAP1 if ARCH_OMAP1
 	help
 	  Say Y here if you want to use OMAP Mailbox framework support for
 	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
 
+config OMAP_MBOX_OMAP1
+	bool
+
+config OMAP_MBOX_OMAP2
+	bool
+
 config OMAP_IOMMU
 	tristate
 

-- 
balbi
