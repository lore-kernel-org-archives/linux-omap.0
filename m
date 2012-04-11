From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies
Date: Wed, 11 Apr 2012 15:49:11 -0700
Message-ID: <20120411224911.GE31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-9-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111540060.29473@utopia.booyaka.com>
 <20120411215513.GA31197@animalcreek.com>
 <alpine.DEB.2.00.1204111555360.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38664 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965608Ab2DKXgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 19:36:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111555360.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 04:04:44PM -0600, Paul Walmsley wrote:
> On Wed, 11 Apr 2012, Mark A. Greer wrote:
> 
> > On Wed, Apr 11, 2012 at 03:44:38PM -0600, Paul Walmsley wrote:
> > 
> > > Looks like there are an extra set of commas here, maybe just use:
> > > 
> > > static struct clkdm_dep gfx_sgx_am35x_wkdeps[] = {
> > > 	{ .clkdm_name = "mpu_clkdm" },
> > > 	{ .clkdm_name = "wkup_clkdm" },
> > > 	{ NULL },
> > 
> > Yes, there are extra commas but they come from the code I'm copying
> > and removing iva2_clkdm from.  I was keeping things consistent so I
> > kept the commas.  Given that, do you still want them removed?
> > (I'm indifferent.)
> 
> Yes please.  I realize it's a minor issue, but I'd like to keep the format 
> of these files internally consistent.

Hrm, did you meant "No thanks"?  As in, leave the commas there since
that's what the code that is already there is like?

Mark
--
