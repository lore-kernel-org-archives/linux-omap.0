From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: OMAP2: twl-common: fix compiler warnings
Date: Fri, 6 Jul 2012 13:02:34 +0300
Message-ID: <1341568954.2059.214.camel@sokoban>
References: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
	 <20120706085357.GS1122@atomide.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41743 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab2GFKCs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jul 2012 06:02:48 -0400
In-Reply-To: <20120706085357.GS1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com

On Fri, 2012-07-06 at 01:53 -0700, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [120628 03:54]:
> > OMAP2 does not use the external voltage controller code for TWL, and
> > thus OMAP2 only compilation generates following warnings:
> 
> Hmm well omap2420 does not have twl, but 2430 usually has. So do you
> mean that 2430 does not use the external voltage controller code?

Well, at least currently the external controller code is not used on any
omap2xxx chip. I guess it might be possible to extend the support for
omap2 also, but I don't know who can do that (personally I have no
access to omap2 hw.)

> 
> > arch/arm/mach-omap2/twl-common.c:51: warning: 'twl_set_voltage' defined but not used
> > arch/arm/mach-omap2/twl-common.c:57: warning: 'twl_get_voltage' defined but not used
> > 
> > This patch moves the code in question behind ARCH specific flags and
> > eliminates these warnings.
> ...
> 
> > --- a/arch/arm/mach-omap2/twl-common.c
> > +++ b/arch/arm/mach-omap2/twl-common.c
> > @@ -48,6 +48,7 @@ static struct i2c_board_info __initdata omap4_i2c1_board_info[] = {
> >  	},
> >  };
> >  
> > +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> >  static int twl_set_voltage(void *data, int target_uV)
> >  {
> >  	struct voltagedomain *voltdm = (struct voltagedomain *)data;
> > @@ -59,6 +60,7 @@ static int twl_get_voltage(void *data)
> >  	struct voltagedomain *voltdm = (struct voltagedomain *)data;
> >  	return voltdm_get_voltage(voltdm);
> >  }
> > +#endif
> 
> To avoid patching this piece of code for new SoCs, can we make it
> ifndef CONFIG_ARCH_OMAP2? Also in the makefile we should not even
> build twl-common.o for 2420 only builds..

Can't make it ifndef CONFIG_ARCH_OMAP2, as this would break on
omap2plus_defconfig then... as it defines all ARCH_OMAP2...ARCH_OMAP4.

And... can't drop it from makefile either, as parts of the code from
twl-common.c are still used with omap2 (omap_pmic_init &
omap_pmic_late_init). These would need to be moved elsewhere first.

-Tero


