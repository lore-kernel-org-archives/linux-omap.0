From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: SmartReflex driver, reference source
	and header files
Date: Wed, 11 Jun 2008 10:40:03 -0700
Message-ID: <20080611174003.GX23796@atomide.com>
References: <1212745789-13926-1-git-send-email-ext-kalle.jokiniemi@nokia.com> <20080610222046.GP23796@atomide.com> <1213181284.9988.12.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:53683 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbYFKRkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 13:40:04 -0400
Content-Disposition: inline
In-Reply-To: <1213181284.9988.12.camel@kj-ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

I guess you had some of the stuff I commented on already fixed earlier,
looks like I missed your integration patch.

* Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [080611 03:47]:
> Hi,
> 
> Good comments. I'll tighten the patch-set into only two patches: regdefs
> and implementation. Some other comments below.
> 
> On ti, 2008-06-10 at 15:20 -0700, ext Tony Lindgren wrote:

<snip>

> > 
> > > +static inline void sr_write_reg(struct omap_sr *sr, int offset, u32 value)
> > > +{
> > > +	omap_writel(value, sr->srbase_addr + offset);
> > > +}
> > > +
> > > +static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
> > > +								u32 value)
> > > +{
> > > +	u32 reg_val;
> > > +
> > > +	reg_val = omap_readl(sr->srbase_addr + offset);
> > > +	reg_val &= ~mask;
> > > +	reg_val |= value;
> > > +
> > > +	omap_writel(reg_val, sr->srbase_addr + offset);
> > > +}
> > > +
> > > +static inline u32 sr_read_reg(struct omap_sr *sr, int offset)
> > > +{
> > > +	return omap_readl(sr->srbase_addr + offset);
> > > +}
> > > +
> > > +
> > 
> > The read and write registers are better done using __raw_readl/writel()
> > instead. Unless the register address is static, the function adds the
> > IO offset every time unnecessarily.
> > 
> > So please set the sr->srbase_addr = io_v2p(SOME_PHYS_ADDR) during init
> > and change the read and write to use __raw_readl/writel() instead.
> 
> did you mean "sr->srbase_addr = io_p2v(SOME_PHYS_ADDR)" ?

Yeah, sorry that's a pretty confusing typo there :)

Regards,

Tony

