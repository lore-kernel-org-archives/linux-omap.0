From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4 RFC]OMAP:GPIO: Make GPIO an early init device
Date: Mon, 15 Feb 2010 09:49:28 -0800
Message-ID: <20100215174928.GC21755@atomide.com>
References: <1265981851-11970-1-git-send-email-charu@ti.com>
 <alpine.DEB.2.00.1002121530340.28188@utopia.booyaka.com>
 <alpine.DEB.2.00.1002141837240.28188@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54652 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab0BORsp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 12:48:45 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002141837240.28188@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [100214 17:38]:
> On Fri, 12 Feb 2010, Paul Walmsley wrote:
> 
> > On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:
> > 
> > >   OMAP: Convert GPIO into a early driver
> > 
> > The above patch appears to be missing.  Could you please re-send?
> 
> This patch was too big for the mailing list, so it's been posted here:
> 
> http://www.pwsan.com/omap/patches/gpio/0002-OMAP-GPIO-split-omap1-and-omap2.patch

What, make two almost identical copies of the shared code? No way!
Instead, please keep the common code under plat-omap:

arch/arm/plat-omap/gpio.c

Then implement the processor specific functions:

arch/arm/mach-omap1/gpio.c
arch/arm/mach-omap2/gpio.c
arch/arm/mach-omap2/gpio24xx.c
arch/arm/mach-omap2/gpio44xx.c

Then have a subsys_initcall in processor specific implementation
that sets the function pointers in the common code.

Regards,

Tony
