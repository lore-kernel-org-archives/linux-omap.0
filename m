From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/44] includecheck: fix multiple includes
Date: Fri, 10 Jul 2009 07:45:53 +0200
Message-ID: <20090710054552.GS2714@pengutronix.de>
References: <1247063308.4382.12.camel@ht.satnam> <1247076059.4382.127.camel@ht.satnam> <20090708211321.GA15928@flint.arm.linux.org.uk> <1247113711.2453.27.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33609 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbZGJFra (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 01:47:30 -0400
Content-Disposition: inline
In-Reply-To: <1247113711.2453.27.camel@ht.satnam>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, davinci <davinci-linux-open-source@linux.davincidsp.com>, Hugo Villeneuve <hugo.villeneuve@lyrtech.com>, philip@opensdr.com, Eduardo Valentin <eduardo.valentin@indt.org.br>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Ben Dooks <ben@simtec.co.uk>, dmitry pervushin <dpervushin@embeddedalley.com>, Vladislav Buzov <vbuzov@embeddedalley.com>, David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, arm <linux-arm@lists.arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jul 09, 2009 at 09:58:31AM +0530, Jaswinder Singh Rajput wrote:
> On Wed, 2009-07-08 at 22:13 +0100, Russell King wrote:
> > On Wed, Jul 08, 2009 at 11:30:59PM +0530, Jaswinder Singh Rajput wrote:
> > > I am still waiting ACK/NAK for :
> > > 
> > >       includecheck fix: arm, misc.c
> > >       includecheck fix: arm, atomic.h
> > >       includecheck fix: arm, board-dm355-evm.c
> > >       includecheck fix: arm, board-dm355-leopard.c
> > >       includecheck fix: arm, board-dm644x-evm.c
> > >       includecheck fix: arm, board-dm646x-evm.c
> > >       includecheck fix: arm, board-sffsdr.c
> > >       includecheck fix: arm, mach-mx3/devices.c
> > >       includecheck fix: arm, mach-omap1/mcbsp.c
> > >       includecheck fix: arm, mach-omap2/mcbsp.c
> > >       includecheck fix: arm, plat-s3c64xx/pm.c
> > >       includecheck fix: arm, plat-stmp3xxx/pinmux.c

For mach-mx3/devices.c:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
