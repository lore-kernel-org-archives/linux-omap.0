From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when PM set
Date: Wed, 11 Nov 2009 01:02:11 +0100
Message-ID: <200911110102.16009.jkrzyszt@tis.icnet.pl>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200910301542.27206.jkrzyszt@tis.icnet.pl> <alpine.DEB.2.00.0911100347320.20233@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:51191 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758703AbZKKADF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 19:03:05 -0500
In-Reply-To: <alpine.DEB.2.00.0911100347320.20233@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net

Tuesday 10 November 2009 11:50:52 Paul Walmsley napisa=C5=82(a):
> Hello Janusz et al,
>
> On Fri, 30 Oct 2009, Janusz Krzysztofik wrote:
> > More looking at it, I found that might be omap_dma_running() from
> > arch/arm/plat-omap/dma.c that needs correction. It already checks f=
or LCD
> > dma running for OMAP1610, but does nothing similiar for 1510. I hav=
e
> > revisited http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found=
 no
> > hint how to do that in a 1610 similiar way.
>
> Speaking of this code, here's a project suggestion if someone has som=
e
> spare time.  All of the LCD DMA code in plat-omap/dma.c appears to be
> OMAP1-only (and apparently only is available on a subset of OMAP1 chi=
ps).
> It would be great if this code could be moved to mach-omap1/lcd_dma.c=
 or
> a similar place.

Paul,

Thank you for putting me into right direction (I hope :-)). If there ar=
e no=20
more comments, I'll try to take care of what you suggest after the situ=
ation=20
with my pending patches AND Tomi Valkeinen's DSS2 patch series, that bo=
th=20
more or less fiddle with LCD DMA related files, gets clear.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
