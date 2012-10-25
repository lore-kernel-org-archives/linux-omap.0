From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add
 read_reset_sources pdata function pointer
Date: Thu, 25 Oct 2012 12:19:36 -0700
Message-ID: <20121025191936.GZ11928@atomide.com>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
 <20121025185755.GV11928@atomide.com>
 <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11533 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760100Ab2JYTTm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 15:19:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [121025 12:11]:
> On Thu, 25 Oct 2012, Tony Lindgren wrote:
> 
> > Ideally we'd have some Linux generic function to implement in the PRM/CM
> > drivers for getting the bootreason. But I guess we don't?
> 
> Do you know of one, apart from WDIOC_GETBOOTSTATUS?

I wonder if we can now with multiple watchdogs supported to
have also PRM/CM implement omap_prcm_wdt_ioctl() that just
handles WDIOC_GETBOOTSTATUS and then just remove that handling
from the other omap watchdog drivers?

Regards,

Tony
