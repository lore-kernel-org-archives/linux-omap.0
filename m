From: Tony Lindgren <tony@atomide.com>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Tue, 7 Apr 2009 10:22:19 -0700
Message-ID: <20090407172219.GB23823@atomide.com>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost> <200904060323.21127.david-b@pacbell.net> <alpine.DEB.2.00.0904060433000.22223@utopia.booyaka.com> <200904060348.34996.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbZDGRW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 13:22:26 -0400
Content-Disposition: inline
In-Reply-To: <200904060348.34996.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Paul Walmsley <paul@pwsan.com>, Russ Dill <russ.dill@gmail.com>, Artem Bityutskiy <dedekind@yandex.ru>, David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090406 03:48]:
> On Monday 06 April 2009, Paul Walmsley wrote:
> > > Puzzle: =A0get a dma_copypage() to work faster than copy_page().
> > > Or a dma_clear_page() faster than clear_page(). =A0Not easy...
> >=20
> > Doing it via the DMA engine may save power, since MPU can sleep.
>=20
> But the CPU overhead of calling the DMA engine can exceed
> that of the memcpy()/memset() ... ;)
>=20
> Another concern is cache impact.  In some cases, having the
> dirty data in dcache is a big win.  With DMA, the cache will
> have been purged.
>=20
> It'd be nice to see DMA versions of this stuff winning;
> all I'm saying is that such wins are hard to achieve.

If the DMA transfer can loop over the small FIFO by and transfer
larger chunks of data, the setup overhead is small. Currently
at least tusb and ASoC loop the DMA over the FIFO.

This way you can let the hardware trigger huge reads or
writes from the small FIFO. To loop over the FIFO, set
dst_fi or src_fi to a _negative_ number.

Maybe onenand could use this too? If you can tell onenand to
read or write multiple FIFOs, and there is a hardware DMA
request line, the DMA request line can tell onenand to reload
the FIFO.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
