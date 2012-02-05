From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 12:51:57 -0800
Message-ID: <20120205205157.GO1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205172528.GA17029@n2100.arm.linux.org.uk>
 <20120205174700.GU20333@atomide.com>
 <20120205180812.GH17309@n2100.arm.linux.org.uk>
 <20120205183316.GL1426@atomide.com>
 <20120205184139.GI17309@n2100.arm.linux.org.uk>
 <20120205185939.GN1426@atomide.com>
 <20120205201146.GK17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab2BEUwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 15:52:04 -0500
Content-Disposition: inline
In-Reply-To: <20120205201146.GK17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 11:40]:
> On Sun, Feb 05, 2012 at 10:59:40AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 10:10]:
> > > On Sun, Feb 05, 2012 at 10:33:16AM -0800, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 09:37]:
> > > > > So in the meantime, people should put up with the kernel reporting an
> > > > > "Error" at error-message level at boot time because they didn't configure
> > > > > something?
> > > > > 
> > > > > No, it needs fixing, because it doesn't justify being an error.  It's
> > > > > wrong, plain and simple.  Again, if you don't want to send it during
> > > > > -rc, I'll send it to Linus as a patch for him to decide whether he wants
> > > > > to take it as -rc material.
> > > > 
> > > > Hmm, maybe I misunderstood you.
> > > > 
> > > > Certainly fixing the "Error" makes sense for -rc, but are also thinking
> > > > about adding error checking to all platform_device_register() calls?
> > > 
> > > I do think they're valid for -rc, because should it fail, things won't
> > > work as one desires.
> > 
> > OK, this easily gets into the area where we might get flames from
> > Linus like "fixing features during -rc that never worked properly
> > before"..
> 
> There is a sliding scale of what's acceptable during the -rc.
> Certainly this kind of thing would not be welcome during the final
> -rc or even the previous -rc, but we're not there yet.
> 
> And it's not like it's a feature that never worked.

Well at least sounds like you have points to argue merging it :)
 
> > I doubt that there's anything else behind it except trying to leave
> > out some ifdefs.
> 
> I don't think you've properly understood what _should_ be going on
> here.  Let me illustrate one possibility of how these code sections
> might look:
> 
> +static void __init xxx_wl12xx_init(void)
> +{
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA
> +       int ret;
> +
> +       /* WL12xx WLAN Init */
> +       ret = wl12xx_set_platform_data(&xxx_wlan_data);
> +       if (ret) {
> +               pr_err("error setting wl12xx data: %d\n", ret);
> +		return;
> +	}
> +       ret = platform_device_register(&xxx_wlan_regulator);
> +       if (ret)
> +               pr_err("error registering wl12xx device: %d\n", ret);
> +#endif
> +}
> 
> In that case, the xxx_wlan_regulator device should also be ifdef'd.
> 
> In other words, if we fail to setup the platform data, we avoid
> registering the device.
> 
> But... wait a moment, that device isn't the actual card itself but is a
> regulator for the card, and that makes it even less clear whether the
> ifdef should include it.  So, maybe this is the proper solution:
> 
> +static void __init xxx_wl12xx_init(void)
> +{
> +       int ret;
> +
> +#ifdef CONFIG_WL12XX_PLATFORM_DATA
> +       /* WL12xx WLAN Init */
> +       ret = wl12xx_set_platform_data(&xxx_wlan_data);
> +       if (ret)
> +               pr_err("error setting wl12xx data: %d\n", ret);
> +#endif
> +       ret = platform_device_register(&xxx_wlan_regulator);
> +       if (ret)
> +               pr_err("error registering wl12xx device: %d\n", ret);
> +}

Hmm I see. Ohad, care to take a look this one?

Regards,

Tony
