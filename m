From: David Brownell <david-b@pacbell.net>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Mon, 6 Apr 2009 03:48:34 -0700
Message-ID: <200904060348.34996.david-b@pacbell.net>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost> <200904060323.21127.david-b@pacbell.net> <alpine.DEB.2.00.0904060433000.22223@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n25.bullet.mail.mud.yahoo.com ([68.142.206.220]:42045 "HELO
	n25.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754419AbZDFKsj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 06:48:39 -0400
In-Reply-To: <alpine.DEB.2.00.0904060433000.22223@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russ Dill <russ.dill@gmail.com>, Artem Bityutskiy <dedekind@yandex.ru>, David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

On Monday 06 April 2009, Paul Walmsley wrote:
> > Puzzle: =A0get a dma_copypage() to work faster than copy_page().
> > Or a dma_clear_page() faster than clear_page(). =A0Not easy...
>=20
> Doing it via the DMA engine may save power, since MPU can sleep.

But the CPU overhead of calling the DMA engine can exceed
that of the memcpy()/memset() ... ;)

Another concern is cache impact.  In some cases, having the
dirty data in dcache is a big win.  With DMA, the cache will
have been purged.

It'd be nice to see DMA versions of this stuff winning;
all I'm saying is that such wins are hard to achieve.

- Dave



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
