From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [beagleboard] Re: TWL4030 intermittent freakout on boot
Date: Sat, 10 May 2008 06:42:32 -0700
Message-ID: <5e088bd90805100642s2ddf4048he6b01cc7a07e736e@mail.gmail.com>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com>
	 <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl>
	 <20080508182807.GE24454@atomide.com> <48249322.4060004@googlemail.com>
	 <20080509213608.GA5976@atomide.com>
	 <5e088bd90805091611q4a8a22d0l3dab427fe644a990@mail.gmail.com>
	 <48256CDE.6040600@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:36027 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbYEJNme (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 09:42:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1167901fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 10 May 2008 06:42:32 -0700 (PDT)
In-Reply-To: <48256CDE.6040600@googlemail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, beagleboard@googlegroups.com, Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, felipe.balbi@nokia.com, peter.de-schrijver@nokia.com

A grep of u-boot sources for the OMAP3 EVM does not yield any
occurrences of twl403 so you might be on to something with this
theory!

Also, I boot from on-board onenand so that is another major difference.

Steve

On Sat, May 10, 2008 at 2:37 AM, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Steve Sakoman wrote:
>
> > FWIW, I've never had any issues with the twl4030 on my OMAP3 EVM.
> > Both it and the MMC come up fine every boot.
> >
> > I'm sure that by saying that I have jinxed myself and will have no end
> > of issues from this point forward :-)
> >
> > It's not obvious from looking at the board files why this might be.
> > Perhaps the order of inits?
> >
>
>  How do you boot OMAP3 EVM? Or better, does your bootloader touch TWL?
>
>  Below, Tony mentioned "But what I'm thinking is that maybe the MMC driver
> does twl4030 calls before the twl4030 clock is programmed to the right
> value?"
>
>  Looking into U-Boot for Beagle in u-boot/cpu/omap3/mmc.c there is
>
>  void twl4030_mmc_config(void)
>  {
>         unsigned char data;
>
>         data = 0x20;
>         i2c_write(0x4B, 0x82, 1, &data, 1);
>         data = 0x2;
>         i2c_write(0x4B, 0x85, 1, &data, 1);
>         return 1;
>  }
>
>  So, on Beagle we are touching TWL *before* kernel (can program right clock
> value). Now, I wonder if u-boot code above is correct compared to
> kernel/drivers/i2c/chips/twl4030-core.c :
>
>  static int power_companion_init(void)
>  {
>         struct clk *osc;
>         u32 rate;
>         u8 ctrl = HFCLK_FREQ_26_MHZ;
>         int e = 0;
>
>         if (cpu_is_omap2430())
>
>                 osc = clk_get(NULL, "osc_ck");
>         else
>                 osc = clk_get(NULL, "osc_sys_ck");
>         if (IS_ERR(osc)) {
>                 printk(KERN_WARNING "Skipping twl3040 internal clock init
> and "
>                                 "using bootloader value (unknown osc
> rate)\n");
>                 return 0;
>         }
>
>         rate = clk_get_rate(osc);
>         clk_put(osc);
>
>         switch (rate) {
>         case 19200000 : ctrl = HFCLK_FREQ_19p2_MHZ; break;
>         case 26000000 : ctrl = HFCLK_FREQ_26_MHZ; break;
>         case 38400000 : ctrl = HFCLK_FREQ_38p4_MHZ; break;
>         }
>
>         ctrl |= HIGH_PERF_SQ;
>         e |= unprotect_pm_master();
>         /* effect->MADC+USB ck en */
>         e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl,
> R_CFG_BOOT);
>         e |= protect_pm_master();
>
>         return e;
>  }
>
>  or if we have to add/remove/fix something in U-Boot?
>
>  Dirk
>
>
>
>
> > On Fri, May 9, 2008 at 2:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> >
> > > * Dirk Behme <dirk.behme@googlemail.com> [080509 11:08]:
> > >
> > >
> > >
> > >
> > > > Tony Lindgren wrote:
> > > >
> > >
> > > >> * Koen Kooi <k.kooi@student.utwente.nl> [080508 11:22]:
> > > >>
> > > >>> Op 8 mei 2008, om 20:13 heeft Paul Walmsley het volgende geschreven:
> > > >>>
> > > >>>> Hello everyone,
> > > >>>>
> > > >>>> occasionally the TWL4030 driver on the 3430SDP freaks out on boot.
> > > >>>>  (This
> > > >>>> is either an ES2.0 or ES2.1, not sure.)  Here's a partial console
> > > >>>> log with
> > > >>>> initcall debugging enabled.  This probably happens every thirty or
> > > >>>> forty
> > > >>>> boots, I would guess.  The board does boot to userspace when this
> > > >>>> happens.
> > > >>>>
> > > >>>> Perhaps the TWL4030 experts out there might know what's going on?
> > > >>>>
> > > >>>> <3>i2c_omap i2c_omap.1: controller timed out
> > > >>>> <3>i2c_omap i2c_omap.1: controller timed out
> > > >>>> <3>twl4030_usb: i2c write failed, line 422
> > > >>>
> > > >>> Looks suspiciously like the symptons in
> > > >>>
> > > >>> http://code.google.com/p/beagleboard/issues/detail?id=14
> > > >>
> > > >>
> > > >> This also looks similar to the earlier twl4030 hangs where access
> > > >> to some domains caused twl4030 to hang. If twl4030 hangs, there's
> > > >> no way to reset it as all control is over I2C. When twl4030 hangs,
> > > >> bootloader won't be able to detect the chip either unless devices
> > > >> is power cycled (and USB cable detached).
> > > >>
> > > >> The reason earlier was that twl4030 internal clock was not being
> > > >> programmed properly, and was fixed by patch
> > > >> 0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d.
> > > >
> > > > Link for this is
> > > >
> > > >
> http://source.mvista.com/git/?p=linux-omap-2.6.git;a=commitdiff;h=0d81cf7e804c529c58d3054c1b9bdb7b3f1dec5d
> > > >
> > > > I don't know OMAP3 good enough yet, but which clock should we use on
> > > > OMAP3 here?
> > >
> > > It should be osc_sys_ck for 34xx.
> > >
> > >
> > > > Does it make sense to use osc_ck for OMAP3 instead of osc_sys_ck, too?
> > > >
> > > > E.g something like
> > > >
> > > > ...
> > > > if (cpu_is_omap2430() || cpu_is_omap34xx())
> > > >   osc = clk_get(NULL, "osc_ck");
> > > > else
> > > >   osc = clk_get(NULL, "osc_sys_ck");
> > > > ...
> > >
> > > There's no osc_ck in clock34xx.h.
> > >
> > > But what I'm thinking is that maybe the MMC driver does twl4030 calls
> > > before the twl4030 clock is programmed to the right value?
> > >
> > > Tony
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> >
> >
> >
>
>
