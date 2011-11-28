From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv7 6/7] regulator: twl: add support for external controller
Date: Mon, 28 Nov 2011 15:56:27 +0000
Message-ID: <20111128155626.GC18958@opensource.wolfsonmicro.com>
References: <1322492005-27741-1-git-send-email-t-kristo@ti.com>
 <1322492005-27741-7-git-send-email-t-kristo@ti.com>
 <20111128145824.GB18958@opensource.wolfsonmicro.com>
 <1322495021.4489.35.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36980 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751795Ab1K1P43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 10:56:29 -0500
Content-Disposition: inline
In-Reply-To: <1322495021.4489.35.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, lrg@ti.com, khilman@ti.com, b-cousson@ti.com, rnayak@ti.com, gg@slimlogic.co.uk

On Mon, Nov 28, 2011 at 05:43:41PM +0200, Tero Kristo wrote:
> On Mon, 2011-11-28 at 14:58 +0000, Mark Brown wrote:

> > You shouldn't be including platform specific headers in generic code.

> Hmm, should I pass the function pointers through platform data also?
> Currently this does not seem to be too easy seeing we have a limited
> number of parameters that can be passed from board and these are already
> in use. regulator_init_data->driver_data is already used as a bitmask
> passing feature flags around.

> I could change driver_data to be a struct pointer and add the func
> pointers + feature flags inside it. However it will end up changing more
> code around.

Whatever you do you should preserve the ability of the driver to build
on non-OMAP platforms.

> > > +	/* voltagedomain, only used for VP controlled smps regulators */
> > > +	union {
> > > +		const char		*name;
> > > +		struct voltagedomain	*ptr;
> > > +	} voltdm;

> > This looks pretty icky...  Why are you using a union of a pointer to a
> > struct and a name?  How do things know which to use?

> Name is only used during probe, after that we always use the ptr. If
> name is not defined, ptr ends up as NULL and we use default mode.

That's fairly nasty, just use two variables or something.  The above is
just asking for breakage.
