From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH C 05/13] OMAP2/3 clock: fix DPLL rate calculation
Date: Thu, 29 Jan 2009 10:27:23 +0000
Message-ID: <20090129102723.GA2577@dyn-67.arm.linux.org.uk>
References: <20090128190724.12092.22239.stgit@localhost.localdomain> <20090128190820.12092.1675.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46983 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbZA2K1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 05:27:35 -0500
Content-Disposition: inline
In-Reply-To: <20090128190820.12092.1675.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <tero.kristo@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Peter de Schrijver <peter.de-schrijver@nokia.com>, Tony Lindgren <tony@atomide.com>

On Wed, Jan 28, 2009 at 12:08:23PM -0700, Paul Walmsley wrote:
> +	if (cpu_is_omap24xx()) {
> +
> +		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
> +		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
> +			return clk->parent->rate;
> +
> +	} else if (cpu_is_omap34xx()) {
> +
> +		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
> +		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
> +			return dd->bypass_clk->rate;
> +
> +	}

You shouldn't introduce two ways of doing the same thing.  Make both
OMAP2 and OMAP3 behaviour the same so that you have less to think
about when looking at the code.

Also, when accepting patches, try to make sure that they conform to
the coding style, rather than repeatedly committing noisy coding style
cleanup patches.

So, the above should be:

+	if (cpu_is_omap24xx()) {
+		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
+			return dd->bypass_clk->rate;
+	} else if (cpu_is_omap34xx()) {
+		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
+			return dd->bypass_clk->rate;
+	}

And this patch should be combined with the previous one which creates
the whole 'bypass_clk' thing.  There's not much point to a patch which
just adds an unused field and initializers to a structure.
