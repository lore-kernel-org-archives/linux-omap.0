From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 03/11] DT: regulator: Helper routine to extract
 regulator_init_data
Date: Fri, 16 Sep 2011 10:52:30 +0100
Message-ID: <20110916095230.GM22062@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
 <1316085727-15023-4-git-send-email-rnayak@ti.com>
 <20110915221258.GK3523@ponder.secretlab.ca>
 <4E72F9A2.20608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38690 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751741Ab1IPJwc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 05:52:32 -0400
Content-Disposition: inline
In-Reply-To: <4E72F9A2.20608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Fri, Sep 16, 2011 at 12:54:18PM +0530, Rajendra Nayak wrote:
> On Friday 16 September 2011 03:42 AM, Grant Likely wrote:

> >However, I can imagine it possible for a regulator to have multiple
> >parents.  It may just be better to go with something like the gpio
> >scheme of<phandle gpio-specifier>  list of entries.  Or maybe just a
> >list of phandles would be sufficient.

> Ok, I can use phandles instead of the name, and have a list to specify
> multiple parents.
> The linux regulator framework though limits to just one parent I guess.

I think if we've got multiple parents they should be listed as named
supplies rather than as parents since it's probably important which is
which.  In fact we probably want to list all parents as supplies since
that's what they are, they just have special handling in the code due to
the recursion.

> >These map 1:1 to how Linux currently implements regulators; which
> >isn't exactly bad, but it means that even if Linux changes, we're
> >still have to support this binding.  Does this represent the best
> >layout for high level description of regulators?

> I guess, except for some like apply-uV, which like Mark pointed
> out are very linux/runtime policy specific.
> Mark, what do you think?

Yes, overall this feels far too direct.
