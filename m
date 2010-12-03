From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
 driver
Date: Fri, 3 Dec 2010 22:13:17 +0530
Message-ID: <20101203164317.GB10048@GLPP-machine>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
 <1290603110-14119-10-git-send-email-manjugk@ti.com>
 <20101202184419.GR17222@atomide.com>
 <20101202184617.GS17222@atomide.com>
 <20101202184925.GT17222@atomide.com>
 <20101202200454.GA27696@manju-desktop>
 <20101202205219.GV17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:52788 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753283Ab0LCQmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 11:42:50 -0500
Received: by mail-gy0-f172.google.com with SMTP id 13so5419978gyb.31
        for <linux-omap@vger.kernel.org>; Fri, 03 Dec 2010 08:42:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101202205219.GV17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

* Tony Lindgren <tony@atomide.com> [2010-12-02 12:52:19 -0800]:

> * G, Manjunath Kondaiah <manjugk@ti.com> [101202 11:55]:
> > 
> > > 
> > > Note that even with these three fixes, 5912OSK still fails to
> > > boot to init. Maybe something wrong with the framebuffer DMA?
> > 
> > Not sure. I don't have omap1 board for testing. Patch series is only 
> > build tested for omap1.
> > 
> > Can you pls confirm if OSK5912 boots successfully without this patch
> > series?
> 
> Yeah boots just fine without these as always.
> 
> Anybody care to donate a OSK5912 or similar for the TI guys
> for doing quick omap1 boot testing on?
>  
> > If yes, I will cross verify omap1 changes again.
> 
> Found the problem. INT_DMA_LCD is handled in mach-omap1/lcd_dma.c.
> In your omap_system_dma_probe we now exit everything if request_irq
> fails for one channel. So let's skip INT_DMA_LCD.
> 
> Also, you should check the logic in omap_system_dma_probe as it's
> not very good handling right now. Note how platform_get_irq_byname
> does not free other dma_irqs like after request_irq we do.

Fixed error handling cases.

> 
> With your patches applied up to patch "Convert DMA library into
> platform driver" + my three earlie fixes + the following fix
> I can now boot OSK5912 and see the penguin on the LCD too.

Thanks a lot. I pulled in all these fixes into the patch series.

> 
> I suggest you break your series into two where the last patch
> in the first series is "Convert DMA library into platform driver".

I am ok with this approach.

> That way the init related changes are done, and we can merge
> those in for testing while you update the rest of the series.

cool.

I have done required changes to patch series and tested the same on
omap2+ boards. Can you pls test OSK5912 board boot from the below
git repo? If OSK5912 boots up(with LCD), I will post the 1st series to
LO ML.

git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git
Branch: dma_testing
commit 3047de5b11cc3fef9ea18a7e8d64fec7a9ea7a89
Author: G, Manjunath Kondaiah <manjugk@ti.com>
Date:   Fri Dec 3 20:03:23 2010 +0530

    OMAP: DMA: Convert DMA library into platform driver
    
    Convert DMA library into DMA platform driver and make use of
    platform data provided by hwmod data base for OMAP2+ onwards.
    
    For OMAP1 processors, the DMA driver in mach-omap uses resource
    structures for getting platform data.
    
    Thanks to Tony Lindgren <tony@atomide.com> for fixing various
    omap1 issues and testing the same on OSK5912 board.
    
    Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>
    Cc: Benoit Cousson <b-cousson@ti.com>
    Cc: Kevin Hilman <khilman@deeprootsystems.com>
    Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

> 
> Also, eventually within next few merge cycles we should have:
> 
> arch/arm/mach-omap1/dma.c	omap1 specific platform init
> arch/arm/mach-omap2/dma.c	omap2+ specific platform init

This seems to be ok.

> drivers/dma/omap-dma.c		driver using dmaengine.c

This might require more time.

-Manjunath

