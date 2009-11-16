From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [v3, for-next] OMAP: DMA: Use some define rather than a hexadecimal constant for LCD register
Date: Mon, 16 Nov 2009 23:46:51 +0100
Message-ID: <200911162346.53321.jkrzyszt@tis.icnet.pl>
References: <20091116222517.GT3684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:41129 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbZKPWrT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 17:47:19 -0500
In-Reply-To: <20091116222517.GT3684@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Monday 16 November 2009 23:25:18 Tony Lindgren napisa=C5=82(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091116 20:40]:
> > The patch corrects the issue introduced with my previous patch:
> >         "OMAP: DMA: Fix omapfb/lcdc on OMAP1510 broken when PM set"
> > as pointed out by OMAP subsystem maintainer.
> >
> > Created and tested against linux-omap for-next,
> > commit 155a75d9725e66e5ec8a383822957dee52427057
>
> Oops, looks like this needs one more update. This breaks building
> for mach-omap2 machines:
>
> arch/arm/plat-omap/dma.c: In function 'omap_dma_running':
> arch/arm/plat-omap/dma.c:1132: error: 'OMAP_LCDC_CONTROL' undeclared =
(first
> use in this function) arch/arm/plat-omap/dma.c:1132: error: (Each
> undeclared identifier is reported only once arch/arm/plat-omap/dma.c:=
1132:
> error: for each function it appears in.) arch/arm/plat-omap/dma.c:113=
2:
> error: 'OMAP_LCDC_CTRL_LCD_EN' undeclared (first use in this function=
)
>
> So removing from omap for-next.
[snip]
> >  	if (cpu_is_omap1510())
> > -		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> > +		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
> >  			return 1;
> >

Sorry, I was sure it would be optimized out by a compiler. I'll put tha=
t into=20
#ifdef block then.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
