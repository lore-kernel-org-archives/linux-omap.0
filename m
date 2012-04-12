From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies
Date: Thu, 12 Apr 2012 16:00:50 -0700
Message-ID: <20120412230050.GO31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-9-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111540060.29473@utopia.booyaka.com>
 <20120411215513.GA31197@animalcreek.com>
 <alpine.DEB.2.00.1204111555360.29473@utopia.booyaka.com>
 <20120411224911.GE31197@animalcreek.com>
 <alpine.DEB.2.00.1204111748540.29473@utopia.booyaka.com>
 <20120412022313.GN31197@animalcreek.com>
 <alpine.DEB.2.00.1204112028560.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:59836 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab2DLXAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 19:00:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204112028560.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 08:29:51PM -0600, Paul Walmsley wrote:
> On Wed, 11 Apr 2012, Mark A. Greer wrote:
> 
> > Okay, I'll get rid of the commas (fwiw, gfx_sgx_3xxx_wkdeps[] has commas
> > in k.o, the others don't).
> 
> Okay thanks, that's just an oversight in the mainline data.  If you're so 
> inclined, feel free to clean that up in your patch...

I am and I will. :)

Mark
--
