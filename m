From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc6 1/2] regulator: enumerate voltages (v2)
Date: Thu, 26 Feb 2009 13:12:42 -0800
Message-ID: <200902261312.42720.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902261148.36892.david-b@pacbell.net> <20090226202055.GE8595@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:33360 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752993AbZBZVMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 16:12:46 -0500
In-Reply-To: <20090226202055.GE8595@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 26 February 2009, Mark Brown wrote:
> On Thu, Feb 26, 2009 at 11:48:36AM -0800, David Brownell wrote:
> 
> > Updates since previous version:  address feedback, simplify.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> This looks good to merge to me - coincidentally I've got a use case for
> it lined up already.  Might it be worth merging the MMC client along
> with this patch if the relevant maintainers are OK with that, could help
> get it in faster?

You mean, that example MMC code I sent?  I think it's a bit
early to merge to mainline ... only the "generate ocr_mask"
call has really been verified.  I'll send the updated version
along though.

I had thought about sending that with patches to convert the
omap_hsmmc driver over to the regulator framework.  No skin
off my back if it goes with a different set of patches though.


> Just two very minor points which might be nice to fix at some point:
> 
> > +			cmin = INT_MIN;
> > +			cmax = INT_MAX;
> > +		}
> > +
> > +		/* else require explicit machine-level constraints */
> > +		else if (cmin <= 0 || cmax <= 0 || cmax < cmin) {
> 
> That indentation is going to catch some people out :)

Maybe.


> > +		/* final: [min_uV..max_uV] valid iff constraints valid */
> > +		if (max_uV < min_uV) {
> > +			pr_err("%s: %s '%s' voltage constraints\n",
> > +				       __func__, "unsupportable", name);
> > +			ret = -EINVAL;
> 
> That style is going to hurt grepability for the error.

"grep unsupportable" ... :)

Sharing the primary string saves about three dozen bytes,
and I'm not keen on needless bloat.

