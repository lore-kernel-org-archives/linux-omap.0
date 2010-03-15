From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add max_clk_div field to
 mcspi platform config
Date: Mon, 15 Mar 2010 13:06:43 -0700
Message-ID: <20100315200643.GD2900@atomide.com>
References: <1268407307.14445.51.camel@quad>
 <20100312172148.GG2900@atomide.com>
 <1268587548.30878.11.camel@quad>
 <20100315163246.GT2900@atomide.com>
 <20100315180351.GB3857@gandalf>
 <20100315185213.GW2900@atomide.com>
 <20100315191648.GC25452@gandalf>
 <20100315192909.GC2900@atomide.com>
 <20100315193158.GF25452@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51926 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936641Ab0COUF3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 16:05:29 -0400
Content-Disposition: inline
In-Reply-To: <20100315193158.GF25452@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Scott Ellis <scott@jumpnowtek.com>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

* Felipe Balbi <me@felipebalbi.com> [100315 12:30]:
> Hi,
> 
> On Mon, Mar 15, 2010 at 12:29:10PM -0700, Tony Lindgren wrote:
> > > could be, but we already have separated clk, pm, cpuidle, mux and soon
> > > to become devices. So pretty much the base support is already splitted,
> > > then why not completely avoiding ifdefs also with dma (which today is
> > > full of ifdefs and could be converted to a platform_device also).
> > 
> > Yeah there are tons of things that should be fixed and split into
> > platform_data and generic code. At least gpio.c, dma.c and i2c-omap.c
> > need some serious work.
> 
> problem with those guys is that they're used all over the place so any
> changes there would always be extremelly intrusive and are prone to
> cause regressions :-(

Well it's not too hard, just need to be careful and do it in small
patches and test carefully between each patch :)

> I could try to allocate some time to play with dma.c but I can only test
> on omap3 since my n810 isn't mount root on mmc, maybe I screwed up
> something and can't remember what :-s if you happen to have tips, I'm
> all ears. The thing is rebooting with "mbus" bootreason. I'll have to
> dig up some legacy docs to figure out what's that.

For some reason only one of the MMC slots works on both n800 and n810,
maybe some menelaus slot switching issue. So you need to try mounting
root on the external card on n810 for now until somebody figures out
the problem.

Tony
