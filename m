From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Thu, 18 Oct 2012 17:39:59 +0300
Message-ID: <1350571199.2143.53.camel@sokoban>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
	 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
	 <20121018103334.GA1449@arwen.pp.htv.fi> <1350562684.2143.52.camel@sokoban>
	 <20121018135352.GC2739@arwen.pp.htv.fi>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60320 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285Ab2JROkG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 10:40:06 -0400
In-Reply-To: <20121018135352.GC2739@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>

On Thu, 2012-10-18 at 16:53 +0300, Felipe Balbi wrote:
> hi,
> 
> On Thu, Oct 18, 2012 at 03:18:04PM +0300, Tero Kristo wrote:
> > > > +static int __init omap4430_phy_power_down(void)
> > > > +{
> > > > +	void __iomem *ctrl_base;
> > > > +
> > > > +	if (!cpu_is_omap44xx())
> > > > +		return 0;
> > > > +
> > > > +	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
> > > > +	if (!ctrl_base) {
> > > > +		pr_err("control module ioremap failed\n");
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	/* Power down the phy */
> > > > +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> > > > +
> > > > +	iounmap(ctrl_base);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +early_initcall(omap4430_phy_power_down);
> > > > +#endif
> > > 
> > > I think you could do it even if the driver is enabled.
> > 
> > Actually not at least now, it looks like the driver is not controlling
> > this bit at all, so the driver would fail if we do this.
> 
> then we can consider that a bug in the driver. Kishon, I thought you had
> added SCM address space to PHY driver for this particular reason until
> we get SCM driver, wasn't it ??

Yes, I would say its a bug in the driver. However we need this disable
mechanism for the case where we don't have the driver also (which is the
default config for omap.)

-Tero

> > > Just to make sure I understand the issue right: is the PHY enabled by
> > > default or did bootloader left this enabled ?
> > 
> > The reset value for the register is zero (at least according to TRM), so
> > it is enabled from boot. Also, I couldn't find any code from the u-boot
> > that would touch this bit with a quick look.
> 
> ok, so it looks like we must do this anyway, thanks ;-)
> 


