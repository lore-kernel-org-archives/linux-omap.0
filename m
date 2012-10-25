From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add
 read_reset_sources pdata function pointer
Date: Thu, 25 Oct 2012 12:34:13 -0700
Message-ID: <20121025193413.GA11928@atomide.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
 <20121025185755.GV11928@atomide.com>
 <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
 <20121025191936.GZ11928@atomide.com>
 <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48962 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757050Ab2JYTeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 15:34:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [121025 12:32]:
> On Thu, 25 Oct 2012, Tony Lindgren wrote:
> 
> > I wonder if we can now with multiple watchdogs supported to
> > have also PRM/CM implement omap_prcm_wdt_ioctl() that just
> > handles WDIOC_GETBOOTSTATUS and then just remove that handling
> > from the other omap watchdog drivers?
> 
> The watchdog ioctl code needs access to internal watchdog state and 
> functions, for example  WDIOC_KEEPALIVE and  WDIOC_SETTIMEOUT.  How would 
> the approach you're thinking of implement those operations?

I have not looked how the watchdog subsystem handles multiple
watchdogs, but.. Can't we have the omap watchdog and twl watchdog
return -ENOTSUPP for WDIOC_GETBOOTSTATUS and have the watchdog
core fail over to the third wathcdog omap_prcm_wdt_ioctl() that
only implements WDIOC_GETBOOTSTATUS? Or something like that.

Regards,

Tony
