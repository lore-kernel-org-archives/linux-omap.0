From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci
 EMAC
Date: Thu, 19 Jul 2012 11:26:02 -0700
Message-ID: <20120719182602.GB24076@animalcreek.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
 <1336770778-23044-3-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1207171814100.28834@utopia.booyaka.com>
 <20120718213246.GD27904@animalcreek.com>
 <alpine.DEB.2.00.1207181723120.19048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38898 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2GSS0T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 14:26:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1207181723120.19048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Jul 18, 2012 at 05:25:16PM -0600, Paul Walmsley wrote:
> On Wed, 18 Jul 2012, Mark A. Greer wrote:
> 
> > On Tue, Jul 17, 2012 at 09:54:53PM -0600, Paul Walmsley wrote:
> > 
> > > Want to try something like this?  It's your patch but modified to not use 
> > > disable/enable_hlt().  If it doesn't work in your test case, maybe 
> > > try uncommenting that second set of deny_idle / allow_idle ...
> > 
> > I tested the modified patch (to get it to compile) below.
> 
> Doh, sorry about that. 

No worries.

> > It did not work with or without the core_dpll_ck deny_idle/allow_idle
> > commented out.
> 
> Here's a version with some of the CPUIdle states restricted.  Maybe try 
> this one if you're using CPUIdle?

I wasn't but I tried this lastest patch with and without CPUidle...

> If it happens to work, it would also be interesting to know if it works 
> with the CORE DPLL part commented out.

...and, unfortunately, it didnt' work in either case.

Mark
