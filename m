From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc3-git 1/2] regulator: twl4030 regulators
Date: Sun, 8 Feb 2009 23:29:23 +0000
Message-ID: <20090208232922.GA16966@sirena.org.uk>
References: <200902081037.06645.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3004 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbZBHX3n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 18:29:43 -0500
Content-Disposition: inline
In-Reply-To: <200902081037.06645.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Sun, Feb 08, 2009 at 10:37:06AM -0800, David Brownell wrote:

> +/*
> + * We list regulators here if systems need some level of
> + * software control over them after boot.
> + */
> +static struct twlreg_info twl4030_regs[] = {

> +	/*
> +	TWL_ADJUSTABLE_LDO(VPLL1, 0x2f, 7),
> +	TWL_ADJUSTABLE_LDO(VPLL2, 0x33, 8),
> +	*/

Minor nit, but I guess the comment would be a bit more accurate if the
comment said that the regulators that aren't likely to be changed have
been commented out (it required that little extra bit of thinking).

> +	/* Constrain board-specific capabilities according to what
> +	 * this driver and the chip itself can actually do.
> +	 */
> +	c = &initdata->constraints;
> +	if (!c->min_uV || c->min_uV < min_uV)
> +		c->min_uV = min_uV;

If we're going to do this I think it'd be better to push it into the
core and let the regulators pass in a set of constraints so that the
behaviour will be consistent between drivers.

I'd also expect to have the registration fail or at least issue a
warning if the code kicks in since that indicates that the board
constraints have been set up incorrectly.  There's a reasonable chance
that the fixed up constraints will still need to be changed for the
board to be configured properly and things may end up being driven out
of spec, potentially causing damage.
