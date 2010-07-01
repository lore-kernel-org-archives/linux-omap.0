From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-apollon.c
Date: Thu, 01 Jul 2010 17:18:33 +0900
Message-ID: <004d01cb18f5$ff27be80$fd773b80$%park@samsung.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
 <20100630120719.2637.65586.stgit@baageli.muru.com>
 <1277967954.2474.269.camel@tubuntu.research.nokia.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49565 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0GAISf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 04:18:35 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4V004I3DQXJO70@mailout4.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 01 Jul 2010 17:18:33 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4V00K2MDQXDS@mmp2.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 01 Jul 2010 17:18:33 +0900 (KST)
In-reply-to: <1277967954.2474.269.camel@tubuntu.research.nokia.com>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tomi Valkeinen' <tomi.valkeinen@nokia.com>, 'ext Tony Lindgren' <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

This value is set from bootloader, and kernel side only change the mode.
Right it runs by luck.

Thank you,
Kyungmin Park

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, July 01, 2010 4:06 PM
> To: ext Tony Lindgren
> Cc: linux-arm-kernel@lists.infradead.org; Kyungmin Park; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 13/16] omap: mux: Mux Apollon LCD power in board-
> apollon.c
> 
> On Wed, 2010-06-30 at 14:07 +0200, ext Tony Lindgren wrote:
> > Use the new mux function for that.
> >
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/board-apollon.c |    3 +++
> >  drivers/video/omap/lcd_apollon.c    |    3 ---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
> omap2/board-apollon.c
> > index b86a879..bc67026 100644
> > --- a/arch/arm/mach-omap2/board-apollon.c
> > +++ b/arch/arm/mach-omap2/board-apollon.c
> > @@ -332,6 +332,9 @@ static void __init omap_apollon_init(void)
> >  	/* REVISIT: where's the correct place */
> >  	omap_cfg_reg(W19_24XX_SYS_NIRQ);
> >
> > +	/* LCD PWR_EN */
> > +	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA |
> OMAP_PULL_UP);
> 
> LCD_PWR_EN sounds like output pin. However, I don't see lcd_apollon.c
> nor board-apollon.c set the gpio.
> 
> I don't know what omap_cfg_reg(M21_242X_GPIO11) does, but if it does the
> same thing as the line above, then does the apollon LCD work by luck?
> OMAP pulling the line up, and by chance the pull is stronger than the
> LCDs (possible) pull down, and thus the LCD is powered up...
> 
>  Tomi


