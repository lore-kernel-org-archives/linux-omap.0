From: David Brownell <david-b@pacbell.net>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Mon, 6 Apr 2009 03:23:20 -0700
Message-ID: <200904060323.21127.david-b@pacbell.net>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost> <200904060259.00439.david-b@pacbell.net> <alpine.DEB.2.00.0904060402140.22223@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:20337 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754373AbZDFKXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 06:23:24 -0400
In-Reply-To: <alpine.DEB.2.00.0904060402140.22223@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russ Dill <russ.dill@gmail.com>, Artem Bityutskiy <dedekind@yandex.ru>, David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

On Monday 06 April 2009, Paul Walmsley wrote:
> Hi David
> 
> On Mon, 6 Apr 2009, David Brownell wrote:
> 
> > On Monday 06 April 2009, Russ Dill wrote:
> > > Also, it appears from looking an the openzoom git, there are some
> > > patches to add DMA support in, but I'm not sure what effect they have.
> > 
> > We had asked for some benchmark data -- anything! -- to get a
> > handle on that, and the prefetch/etc engine; nothing forthcoming,
> > so far.
> 
> We'd also have to make sure that the comparison is between the linux-omap 
> kernel and the OMAPZoo kernel, rather than o-z PIO vs. o-z DMA.  The 
> OMAPZoom kernel doesn't post any device register writes.  That should 
> cause any driver using PIO to drag, compared to the l-o kernel.

I'd think the first thing to check is two linux-omap PIO flavors:
with vs without the prefetch/postwrite engine.  Benchmarking DMA
would be a separate issue.  Ditto comparing kernels with/without
write posting.

I've benchmarked small DMA transfers and it's rather hard to get
them faster than io{read,write}32_rep().  Overhead of DMA mapping
and just DMA setup/teardown/complete is annoyingly high.  While
bus overheads aren't large.

Puzzle:  get a dma_copypage() to work faster than copy_page().
Or a dma_clear_page() faster than clear_page().  Not easy...

- Dave
