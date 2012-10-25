From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer
Date: Thu, 25 Oct 2012 19:57:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210251944540.21193@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013213.21844.20016.stgit@dusk.lan> <20121025153805.GB11623@blackmetal.musicnaut.iki.fi> <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com> <20121025185755.GV11928@atomide.com>
 <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com> <20121025191936.GZ11928@atomide.com> <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com> <20121025193413.GA11928@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37924 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760191Ab2JYT5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 15:57:32 -0400
In-Reply-To: <20121025193413.GA11928@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org

On Thu, 25 Oct 2012, Tony Lindgren wrote:

> I have not looked how the watchdog subsystem handles multiple
> watchdogs, but..

In the new watchdog core code, each watchdog driver gets a separate 
/dev/watchdog* character device.  The ioctls are called on those device 
nodes.

[ As an aside, neither the OMAP watchdog driver, nor the TWL watchdog 
driver have been updated to use the new watchdog core code.  So they both 
can't be loaded at the same time until one or both are fixed. ]

> Can't we have the omap watchdog and twl watchdog return -ENOTSUPP for 
> WDIOC_GETBOOTSTATUS and have the watchdog core fail over to the third 
> wathcdog omap_prcm_wdt_ioctl() that only implements WDIOC_GETBOOTSTATUS? 
> Or something like that.

Sounds like a question better asked of Alan Cox and Wim, who wrote the 
watchdog core code.

Two other observations:

- It's possible that two different watchdogs could report different boot 
reasons.  The TWL might store its own watchdog boot reason which could be 
different from what's reported via the OMAP PRM.  For example, the TWL can 
record a thermal shutdown reset event, STS_BOOT.TS, which wouldn't be 
reflected in the PRM reset source data, which would just see some kind of 
external reset or power-off event.

- The PRM doesn't contain a hardware watchdog, so not sure it makes sense 
to create a watchdog driver for it.


- Paul
