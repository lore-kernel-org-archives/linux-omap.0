From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH][RFC] McSPI Slave and DMA,FIFO support
Date: Mon, 18 May 2009 07:14:53 -0700
Message-ID: <87y6subiqq.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03056A123B@dbde02.ent.ti.com>
	<005201c9d798$46355170$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:46335 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbZEROOz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 10:14:55 -0400
Received: by pzk13 with SMTP id 13so2003964pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2009 07:14:56 -0700 (PDT)
In-Reply-To: <005201c9d798$46355170$LocalHost@wipultra793> (Hemanth V.'s message of "Mon\, 18 May 2009 14\:38\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

> ----- Original Message ----- 
> From: "Gadiyar, Anand" <gadiyar@ti.com>
> To: "V, Hemanth" <hemanthv@ti.com>; "Kevin Hilman"
> <khilman@deeprootsystems.com>
>
>
>> >> Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
>> >> ===================================================================
>> >> --- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c 2009-05-14
>> >> 12:38:50.000000000 +0530
>> >> +++ linux-omap-2.6/arch/arm/mach-omap2/devices.c 2009-05-15 >>
>> 16:53:38.000000000 +0530
>
> <snip>
>
>> >>  };
>> >>
>> >>  static struct resource omap2_mcspi2_resources[] = {
>> >> @@ -351,6 +359,14 @@
>> >>
>> >>  static void omap_init_mcspi(void)
>> >>  {
>> >> +
>> >> + if (cpu_is_omap3430()) {
>> >> + omap_cfg_reg(AA3_3430_McSPI2_CLK);
>> >> + omap_cfg_reg(Y2_3430_McSPI2_SIMO);
>> >> + omap_cfg_reg(Y3_3430_McSPI2_SOMI);
>> >> + omap_cfg_reg(Y4_3430_McSPI2_CS0);
>> >> + }
>> >> +
>
>>This will change the mux mode for these pads for all OMAP3 boards,
>>even if they do not wish to use McSPI2. In particular, Beagleboard
>>will be affected as it uses HSUSB on Port2 and these pads overlap.
>
> I could add an option like below to plat-omap/Kconfig under
> OMAP Feature Selections. Kevin, Your thoughts on this
>
> config  OMAP3430_ENABLE_SPI2_PIN_MUX
>        bool "Enable SPI2 pin mux configuration for OMAP3430"
>        depends on ARCH_OMAP3430
>        default n
>        help
>            Enable pin mux for SPI2 on OMAP3430 platform. Note
>            that the same pins are used for EHCI port2 operation. Hence
>            enabling this option effectively disables EHCI port 2

Don't use compile-time setup for this, use runtime.  Mux setup is
board-specific and should be done in board init code.

Kevin

