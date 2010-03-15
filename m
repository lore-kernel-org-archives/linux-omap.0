From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/6 Revised] SPI omap2_mcspi: Add max_clk_div field to
 mcspi platform config
Date: Mon, 15 Mar 2010 21:16:49 +0200
Message-ID: <20100315191648.GC25452@gandalf>
References: <1268407307.14445.51.camel@quad>
 <20100312172148.GG2900@atomide.com>
 <1268587548.30878.11.camel@quad>
 <20100315163246.GT2900@atomide.com>
 <20100315180351.GB3857@gandalf>
 <20100315185213.GW2900@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43454 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965718Ab0COTQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 15:16:40 -0400
Content-Disposition: inline
In-Reply-To: <20100315185213.GW2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Scott Ellis <scott@jumpnowtek.com>, spi-devel-general@lists.sourceforge.net, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Mon, Mar 15, 2010 at 11:52:13AM -0700, Tony Lindgren wrote:
> Yeah I've been thinking about that too earlier. We could have common
> devices.c with the init code, then dev24xx.c and dev34xx.c et al
> would just call the common init functions with something like this:
> 
> 
> static int __init dev34xx_init(void)
> {
> 	if (!cpu_is_omap34xx())
> 		return -ENODEV;
> 
> 	omap_init_mbox(omap34xx_mbox_resources, omap34xx_mbox_nr_resources);
> 	omap_init_sti(omap34xx_sti_resources, omap34xx_sti_nr_resources);
> 	...	
> 
> 	return 0;
> }
> 
> subsys_initcall(emu_init);
> 
> Of course that needs to be coordinated with the pending hwmod patches.

sure. Exactly what I was thinking :-p

> > personally I think we should have mach-omap3 and mach-omap4 directories
> > but that would be too intrusive IMO.
> 
> I think we can achieve most of that by right naming of the files and
> with hwmod. Having separate directories typically means multiple copies
> of almost the same code.

could be, but we already have separated clk, pm, cpuidle, mux and soon
to become devices. So pretty much the base support is already splitted,
then why not completely avoiding ifdefs also with dma (which today is
full of ifdefs and could be converted to a platform_device also).

-- 
balbi
