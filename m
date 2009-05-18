From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [PATCH][RFC] McSPI Slave and DMA,FIFO support
Date: Mon, 18 May 2009 14:38:55 +0530
Message-ID: <005201c9d798$46355170$LocalHost@wipultra793>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03056A123B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZERJJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 05:09:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Gadiyar, Anand" <gadiyar@ti.com>
To: "V, Hemanth" <hemanthv@ti.com>; "Kevin Hilman" 
<khilman@deeprootsystems.com>


> >> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
> >> ===================================================================
> >> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c 2009-05-14 
> >> 12:38:50.000000000 +0530
> >> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c 2009-05-15 
> >> 16:53:38.000000000 +0530

<snip>

> >>  };
> >>
> >>  static struct resource omap2_mcspi2_resources[] = {
> >> @@ -351,6 +359,14 @@
> >>
> >>  static void omap_init_mcspi(void)
> >>  {
> >> +
> >> + if (cpu_is_omap3430()) {
> >> + omap_cfg_reg(AA3_3430_McSPI2_CLK);
> >> + omap_cfg_reg(Y2_3430_McSPI2_SIMO);
> >> + omap_cfg_reg(Y3_3430_McSPI2_SOMI);
> >> + omap_cfg_reg(Y4_3430_McSPI2_CS0);
> >> + }
> >> +

>This will change the mux mode for these pads for all OMAP3 boards,
>even if they do not wish to use McSPI2. In particular, Beagleboard
>will be affected as it uses HSUSB on Port2 and these pads overlap.

I could add an option like below to plat-omap/Kconfig under
OMAP Feature Selections. Kevin, Your thoughts on this

config  OMAP3430_ENABLE_SPI2_PIN_MUX
        bool "Enable SPI2 pin mux configuration for OMAP3430"
        depends on ARCH_OMAP3430
        default n
        help
            Enable pin mux for SPI2 on OMAP3430 platform. Note
            that the same pins are used for EHCI port2 operation. Hence
            enabling this option effectively disables EHCI port 2 usage. 

