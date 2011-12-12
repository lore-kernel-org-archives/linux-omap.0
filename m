From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 11/15] omap3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
Date: Mon, 12 Dec 2011 11:45:48 +0200
Message-ID: <1323683148.31914.14.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-12-git-send-email-t-kristo@ti.com>
	 <8762hpedtl.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46117 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852Ab1LLJpw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 04:45:52 -0500
In-Reply-To: <8762hpedtl.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, nm@ti.com

On Fri, 2011-12-09 at 11:37 -0800, Kevin Hilman wrote:
> +Paul
> 
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > This patch fixes the usecount tracking for omap3+, previously the
> > usecount numbers were rather bogus and were not really useful for
> > any purpose. Now usecount numbers track the number of really active
> > clients on each domain. 
> 
> Excellent!  
> 
> This dramatically improves the usefulness of <debugfs>/pm_debug/count.
> Adding the voltage domains to that debugfs would help even more.
> 
> Also, the changelog should be a bit more verbose about the new clk->autoidle
> field, it's usage, and how it affects usecounting.  

Okay, will try to add some more beef here.

> 
> Speaking of debugfs: not a requirement for this series, but another
> "nice to have" (which you can do while waiting for the slow maintainers
> to review :) would be for this debugfs to show the clkdomains under the
> powerdomains they are in, and the powerdomains under the voltage domains
> (instead of the current list of pwrdms followed by clkdms.)  Maybe using
> voltdm_for_each_pwrdm() + pwrdm_for_each_clkdm() might help there.

Yea, I have used something close to this myself for testing purposes, I
can maybe add something for this in next version.

> 
> > This patch also adds support for usecount tracking on powerdomain and
> > voltagedomain levels.
> 
> The clock/clkdm/pwrdm changes should probably be split separate patch
> for review/merge by Paul.  Then the voltdm changes can included in this
> series.  Although, with Paul's ack on the clock/clkdm/powerdomain
> changes, I'll be happy to queue this as well.

Okay, will wait for Paul's comment on this.

> 
> [...]
> 
> > diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> > index df4b968..f18dd5f 100644
> > --- a/arch/arm/plat-omap/include/plat/clock.h
> > +++ b/arch/arm/plat-omap/include/plat/clock.h
> > @@ -254,6 +254,7 @@ struct clk {
> >  	void			(*init)(struct clk *);
> >  	u8			enable_bit;
> >  	s8			usecount;
> > +	u8			autoidle;
> 
> should be bool, and assignments using true | false.

Yea can change that one.

-Tero

