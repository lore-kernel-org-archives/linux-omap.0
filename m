From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer
Date: Thu, 25 Oct 2012 19:31:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013213.21844.20016.stgit@dusk.lan> <20121025153805.GB11623@blackmetal.musicnaut.iki.fi> <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com> <20121025185755.GV11928@atomide.com>
 <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com> <20121025191936.GZ11928@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37865 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992551Ab2JYTbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 15:31:07 -0400
In-Reply-To: <20121025191936.GZ11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

On Thu, 25 Oct 2012, Tony Lindgren wrote:

> I wonder if we can now with multiple watchdogs supported to
> have also PRM/CM implement omap_prcm_wdt_ioctl() that just
> handles WDIOC_GETBOOTSTATUS and then just remove that handling
> from the other omap watchdog drivers?

The watchdog ioctl code needs access to internal watchdog state and 
functions, for example  WDIOC_KEEPALIVE and  WDIOC_SETTIMEOUT.  How would 
the approach you're thinking of implement those operations?



- Paul
