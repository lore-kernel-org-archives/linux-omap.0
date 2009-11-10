From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when
 PM set
Date: Tue, 10 Nov 2009 03:50:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911100347320.20233@utopia.booyaka.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200910301542.27206.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36451 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637AbZKJKur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:50:47 -0500
In-Reply-To: <200910301542.27206.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net

Hello Janusz et al,

On Fri, 30 Oct 2009, Janusz Krzysztofik wrote:

> More looking at it, I found that might be omap_dma_running() from 
> arch/arm/plat-omap/dma.c that needs correction. It already checks for LCD dma 
> running for OMAP1610, but does nothing similiar for 1510. I have revisited 
> http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found no hint how to do 
> that in a 1610 similiar way.

Speaking of this code, here's a project suggestion if someone has some 
spare time.  All of the LCD DMA code in plat-omap/dma.c appears to be 
OMAP1-only (and apparently only is available on a subset of OMAP1 chips).  
It would be great if this code could be moved to mach-omap1/lcd_dma.c or 
a similar place.


- Paul
