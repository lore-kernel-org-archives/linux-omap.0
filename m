From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap
 to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken
 when PM set)
Date: Wed, 25 Nov 2009 19:08:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911251905590.19371@utopia.booyaka.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911230154230.26334@utopia.booyaka.com> <200911251454.49078.jkrzyszt@tis.icnet.pl> <200911252357.10812.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43916 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbZKZCIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 21:08:24 -0500
In-Reply-To: <200911252357.10812.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Janusz,

On Wed, 25 Nov 2009, Janusz Krzysztofik wrote:

> It turned out not that simple. Since arch/arm/mach-omap1/lcd_dma.c 
> exports several functions that are called unconditionaly from 
> drivers/video/omap/lcdc.c AND the latter is linked into the omapfb 
> driver based on CONFIG_ARCH_OMAP1=y, linking in the former can't be 
> limited to selected OMAP1 subarchs unless at least 
> drivers/video/omap/{Kconfig,Makefile}, if not drivers/video/omap/lcdc.c 
> itself either, are modified for that as well. Am I missing something?
> 
> If not, I can see two options:
> 1. Keep arch/arm/mach-omap1/lcd_dma.c linked in for any OMAP1 subarch unless
> CONFIG_FB_OMAP is not set. That can be cleaned up further after the 
> drivers/video/omap/* stuff is ever modified.
> 2. Include drivers/video/omap/* modifications into this series.
> 
> What do you suggest?

Let's take option 1 for right now.  Maybe one of the htcwizard people 
might take that project up after the LCD DMA split is merged.



- Paul
