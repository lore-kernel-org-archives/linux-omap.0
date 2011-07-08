From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap twl cleanup for v3.1 merge window
Date: Fri, 8 Jul 2011 17:41:23 +0200
Message-ID: <201107081741.23425.arnd@arndb.de>
References: <20110708130102.GB5783@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55743 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab1GHPl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:41:28 -0400
In-Reply-To: <20110708130102.GB5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

On Friday 08 July 2011, Tony Lindgren wrote:
>
>I've attached a conflict resolution patch too, it's trivial execpt
>note that .vdac needs to be removed in board-rx51-peripherals.c.
>
>If this conflict causes problems for you, I can also base this series
>on omap/board.

The conflict resolution you suggested doesn't build here:

> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@@ -572,75 -395,10 +509,62 @@@ static struct regulator_init_data sdp44
>         },
>   };
>   
>  +static struct regulator_init_data sdp4430_vana = {
>  +      .constraints = {
>  +              .min_uV                 = 2100000,
>  +              .max_uV                 = 2100000,
>  +              .valid_modes_mask       = REGULATOR_MODE_NORMAL
>  +                                      | REGULATOR_MODE_STANDBY,
>  +              .valid_ops_mask  = REGULATOR_CHANGE_MODE
>  +                                      | REGULATOR_CHANGE_STATUS,
>  +      },
>  +};
>  +
>  +static struct regulator_init_data sdp4430_vcxio = {
>  +      .constraints = {
>  +              .min_uV                 = 1800000,
>  +              .max_uV                 = 1800000,
>  +              .valid_modes_mask       = REGULATOR_MODE_NORMAL
>  +                                      | REGULATOR_MODE_STANDBY,
>  +              .valid_ops_mask  = REGULATOR_CHANGE_MODE
>  +                                      | REGULATOR_CHANGE_STATUS,
>  +      },
>  +};
>  +
>  +static struct regulator_init_data sdp4430_vdac = {
>  +      .constraints = {
>  +              .min_uV                 = 1800000,
>  +              .max_uV                 = 1800000,
>  +              .valid_modes_mask       = REGULATOR_MODE_NORMAL
>  +                                      | REGULATOR_MODE_STANDBY,
>  +              .valid_ops_mask  = REGULATOR_CHANGE_MODE
>  +                                      | REGULATOR_CHANGE_STATUS,
>  +      },
>  +};
>  +
>  +static struct regulator_init_data sdp4430_vusb = {
>  +      .constraints = {
>  +              .min_uV                 = 3300000,
>  +              .max_uV                 = 3300000,
>  +              .apply_uV               = true,
>  +              .valid_modes_mask       = REGULATOR_MODE_NORMAL
>  +                                      | REGULATOR_MODE_STANDBY,
>  +              .valid_ops_mask  =      REGULATOR_CHANGE_MODE
>  +                                      | REGULATOR_CHANGE_STATUS,
>  +      },
>  +};
>  +
>  +static struct regulator_init_data sdp4430_clk32kg = {
>  +      .constraints = {
>  +              .valid_ops_mask         = REGULATOR_CHANGE_STATUS,
>  +              .always_on              = true,
>  +      },
>  +};

These are removed in the cleanup series, but changed in the fixes branch,
now the removal is undone

>   static struct twl4030_platform_data sdp4430_twldata = {
> -       .irq_base       = TWL6030_IRQ_BASE,
> -       .irq_end        = TWL6030_IRQ_END,
> - 
>         /* Regulators */
> -       .vmmc           = &sdp4430_vmmc,
> -       .vpp            = &sdp4430_vpp,
>         .vusim          = &sdp4430_vusim,
> -       .vana           = &sdp4430_vana,
> -       .vcxio          = &sdp4430_vcxio,
> -       .vdac           = &sdp4430_vdac,
> -       .vusb           = &sdp4430_vusb,
>         .vaux1          = &sdp4430_vaux1,
> -       .vaux2          = &sdp4430_vaux2,
> -       .vaux3          = &sdp4430_vaux3,
> -       .clk32kg        = &sdp4430_clk32kg,
> -       .usb            = &omap4_usbphy_data
>   };
>   

but the references remain.

I tried a different path, but then got

arch/arm/mach-omap2/board-4430sdp.c:406:41: warning: 'sdp4430_vmmc_supply' defined but not used [-Wunused-variable]

Should that variable be removed or kept referenced?

	Arnd
