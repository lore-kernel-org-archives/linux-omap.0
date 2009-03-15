From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Sun, 15 Mar 2009 00:37:44 +0000
Message-ID: <20090315003743.GB11052@sirena.org.uk>
References: <200903111743.34708.david-b@pacbell.net> <200903111932.16317.david-b@pacbell.net> <20090312120119.GB24376@sirena.org.uk> <200903141725.35541.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2850 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbZCOAhx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Mar 2009 20:37:53 -0400
Content-Disposition: inline
In-Reply-To: <200903141725.35541.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Sat, Mar 14, 2009 at 05:25:35PM -0700, David Brownell wrote:

> +	} else if (ops->is_enabled) {
> +		/* ... if the bootloader left it on, drivers need a
> +		 * nonzero enable count else it can't be disabled.
> +		 */
> +		ret = ops->is_enabled(rdev);
> +		if (ret > 0)
> +			rdev->use_count = 1;
> +		ret = 0;

This means that drivers that do balanced enables and disables will never
be able to cause the regulator to actually be disabled since there will
always be this extra reference count there.  Without this patch what'll
happen with those drivers is that they'll do an enable then later on
when the last one disables its supply the reference count will fall to
zero and the regulator will be disabled.
