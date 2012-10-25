From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add
 read_reset_sources pdata function pointer
Date: Thu, 25 Oct 2012 11:57:55 -0700
Message-ID: <20121025185755.GV11928@atomide.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26655 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760004Ab2JYS6C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 14:58:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [121025 11:53]:
> Terve,
> 
> On Thu, 25 Oct 2012, Aaro Koskinen wrote:
> 
> > On Mon, Oct 15, 2012 at 07:32:33PM -0600, Paul Walmsley wrote:
> > > The OMAP watchdog timer driver directly calls a function exported by
> > > code in arch/arm/mach-omap2.  This is not good; it tightly couples
> > > this driver to the mach-omap2 integration code.  Instead, add a
> > > temporary platform_data function pointer to abstract this function
> > > call.  A subsequent patch will convert the watchdog driver to use this
> > > function pointer.
> > 
> > Why a function is needed? Reset cause won't change until the next reset,
> > so it should be enough to read it once during the init and store it into
> > the platform data.
> 
> Once the PRM/CM drivers and DT conversion is complete, this driver won't 
> have any platform_data.  There won't be any watchdog driver initialization 
> code in arch/arm/mach-omap2.  At that point in time, the driver will just 
> call a function from the PRM driver that provides the reset source data.  
> 
> As you say, the watchdog can certainly do this from its probe code; it 
> would be more efficient.  Just didn't want to make that change now; seems 
> like it would be best done as a separate optimization patch.

Ideally we'd have some Linux generic function to implement in the PRM/CM
drivers for getting the bootreason. But I guess we don't?

Regards,

Tony
