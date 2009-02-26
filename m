From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc6 1/2] regulator: enumerate voltages (v2)
Date: Thu, 26 Feb 2009 20:20:56 +0000
Message-ID: <20090226202055.GE8595@sirena.org.uk>
References: <200902081037.06645.david-b@pacbell.net> <200902231245.44360.david-b@pacbell.net> <200902231252.01980.david-b@pacbell.net> <200902261148.36892.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3677 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756369AbZBZUVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 15:21:00 -0500
Content-Disposition: inline
In-Reply-To: <200902261148.36892.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thu, Feb 26, 2009 at 11:48:36AM -0800, David Brownell wrote:

> Updates since previous version:  address feedback, simplify.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

This looks good to merge to me - coincidentally I've got a use case for
it lined up already.  Might it be worth merging the MMC client along
with this patch if the relevant maintainers are OK with that, could help
get it in faster?

Just two very minor points which might be nice to fix at some point:

> +			cmin = INT_MIN;
> +			cmax = INT_MAX;
> +		}
> +
> +		/* else require explicit machine-level constraints */
> +		else if (cmin <= 0 || cmax <= 0 || cmax < cmin) {

That indentation is going to catch some people out :)

> +		/* final: [min_uV..max_uV] valid iff constraints valid */
> +		if (max_uV < min_uV) {
> +			pr_err("%s: %s '%s' voltage constraints\n",
> +				       __func__, "unsupportable", name);
> +			ret = -EINVAL;

That style is going to hurt grepability for the error.
