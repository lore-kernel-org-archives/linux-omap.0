From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Mon, 6 Apr 2009 04:08:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904060402140.22223@utopia.booyaka.com>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost> <49D9B21A.2000002@yandex.ru> <f9d2a5e10904060113g37c3dd7fk5be6d3a12ab169c4@mail.gmail.com> <200904060259.00439.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57549 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbZDFKIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 06:08:14 -0400
In-Reply-To: <200904060259.00439.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russ Dill <russ.dill@gmail.com>, Artem Bityutskiy <dedekind@yandex.ru>, David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

Hi David

On Mon, 6 Apr 2009, David Brownell wrote:

> On Monday 06 April 2009, Russ Dill wrote:
> > Also, it appears from looking an the openzoom git, there are some
> > patches to add DMA support in, but I'm not sure what effect they have.
> 
> We had asked for some benchmark data -- anything! -- to get a
> handle on that, and the prefetch/etc engine; nothing forthcoming,
> so far.

We'd also have to make sure that the comparison is between the linux-omap 
kernel and the OMAPZoo kernel, rather than o-z PIO vs. o-z DMA.  The 
OMAPZoom kernel doesn't post any device register writes.  That should 
cause any driver using PIO to drag, compared to the l-o kernel.


- Paul
