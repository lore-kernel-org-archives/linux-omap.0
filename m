From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix bootup crash for LDP platform
Date: Sat, 18 Oct 2008 06:56:42 -0700
Message-ID: <20081018135642.GP18573@atomide.com>
References: <1224284642-13863-1-git-send-email-vikram.pandita@ti.com> <FCCFB4CDC6E5564B9182F639FC3560870239689773@dbde02.ent.ti.com> <20081017235020.GM31842@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53399 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYJRN4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 09:56:45 -0400
Content-Disposition: inline
In-Reply-To: <20081017235020.GM31842@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <me@felipebalbi.com> [081017 16:50]:
> On Sat, Oct 18, 2008 at 04:38:04AM +0530, Pandita, Vikram wrote:
> > 
> > From: Vikram Pandita <vikram.pandita@ti.com>
> > 
> > Fix following bootup crash on LDP platform by enabling T2 USB driver for MUSB
> > 
> > Backtrace:
> > [<c001b9ac>] (musb_platform_init+0x0/0x120) from [<c001b0a8>] (musb_probe+0x208/0xb0c)
> >  r5:00000000 r4:c0222ad4
> > [<c001aea0>] (musb_probe+0x0/0xb0c) from [<c0142e80>] (platform_drv_probe+0x20/0x24)
> > [<c0142e60>] (platform_drv_probe+0x0/0x24) from [<c0142118>] (driver_probe_device+0xd0/0x17c)
> > [<c0142048>] (driver_probe_device+0x0/0x17c) from [<c0142210>] (__driver_attach+ 0x4c/0x70)
> >  r7:c0233214 r6:c0233214 r5:c02229ec r4:c0222940
> > [<c01421c4>] (__driver_attach+0x0/0x70) from [<c0141790>] (bus_for_each_dev+0x4c/0x84)
> >  r7:c0233214 r6:c01421c4 r5:c781de94 r4:00000000
> > [<c0141744>] (bus_for_each_dev+0x0/0x84) from [<c0141f60>] (driver_attach+0x20/0x28)
> >  r7:c78999c0 r6:c0234c60 r5:c0233214 r4:00000000
> > [<c0141f40>] (driver_attach+0x0/0x28) from [<c0141c1c>] (bus_add_driver+0xa8/0x214)
> > [<c0141b74>] (bus_add_driver+0x0/0x214) from [<c0142404>] (driver_register+0x98/0x120)
> >  r8:00000000 r7:00000000 r6:c0234c60 r5:c0233214 r4:c001e5c4
> > [<c014236c>] (driver_register+0x0/0x120) from [<c014303c>] (platform_driver_register+0x78/0x94)
> > [<c0142fc4>] (platform_driver_register+0x0/0x94) from [<c0143070>] (platform_driver_probe+0x18/0x68)
> > [<c0143058>] (platform_driver_probe+0x0/0x68) from [<c001ad38>] (musb_init+0x3c/0x54)
> >  r5:c001e510 r4:c001e5c4
> > [<c001acfc>] (musb_init+0x0/0x54) from [<c0022298>] (__exception_text_end+0x50/0x168)
> > 
> > 
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Pushed. I hope you have a real fix for this coming from mainline soon :)

Tony


> 
> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> > ---
> >  arch/arm/configs/omap_ldp_defconfig |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
> > index da9146e..0acaee5 100644
> > --- a/arch/arm/configs/omap_ldp_defconfig
> > +++ b/arch/arm/configs/omap_ldp_defconfig
> > @@ -1,7 +1,7 @@
> >  #
> >  # Automatically generated make config: don't edit
> >  # Linux kernel version: 2.6.27-omap1
> > -# Fri Oct 17 14:00:54 2008
> > +# Fri Oct 17 17:56:45 2008
> >  #
> >  CONFIG_ARM=y
> >  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> > @@ -534,7 +534,7 @@ CONFIG_I2C_OMAP=y
> >  # CONFIG_TPS65010 is not set
> >  # CONFIG_SENSORS_TLV320AIC23 is not set
> >  CONFIG_TWL4030_MADC=y
> > -# CONFIG_TWL4030_USB is not set
> > +CONFIG_TWL4030_USB=y
> >  # CONFIG_TWL4030_PWRBUTTON is not set
> >  # CONFIG_TWL4030_POWEROFF is not set
> >  # CONFIG_SENSORS_MAX6875 is not set
> > -- 
> > 1.6.0.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
