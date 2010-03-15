From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add max_clk_div field to
 mcspi platform config
Date: Mon, 15 Mar 2010 21:31:58 +0200
Message-ID: <20100315193158.GF25452@gandalf>
References: <1268407307.14445.51.camel@quad>
 <20100312172148.GG2900@atomide.com>
 <1268587548.30878.11.camel@quad>
 <20100315163246.GT2900@atomide.com>
 <20100315180351.GB3857@gandalf>
 <20100315185213.GW2900@atomide.com>
 <20100315191648.GC25452@gandalf>
 <20100315192909.GC2900@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52523 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0COTbt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 15:31:49 -0400
Content-Disposition: inline
In-Reply-To: <20100315192909.GC2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Scott Ellis <scott@jumpnowtek.com>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Mon, Mar 15, 2010 at 12:29:10PM -0700, Tony Lindgren wrote:
> > could be, but we already have separated clk, pm, cpuidle, mux and soon
> > to become devices. So pretty much the base support is already splitted,
> > then why not completely avoiding ifdefs also with dma (which today is
> > full of ifdefs and could be converted to a platform_device also).
> 
> Yeah there are tons of things that should be fixed and split into
> platform_data and generic code. At least gpio.c, dma.c and i2c-omap.c
> need some serious work.

problem with those guys is that they're used all over the place so any
changes there would always be extremelly intrusive and are prone to
cause regressions :-(

I could try to allocate some time to play with dma.c but I can only test
on omap3 since my n810 isn't mount root on mmc, maybe I screwed up
something and can't remember what :-s if you happen to have tips, I'm
all ears. The thing is rebooting with "mbus" bootreason. I'll have to
dig up some legacy docs to figure out what's that.

-- 
balbi
