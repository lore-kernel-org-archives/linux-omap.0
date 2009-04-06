From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Mon, 6 Apr 2009 04:34:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904060433000.22223@utopia.booyaka.com>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost> <200904060259.00439.david-b@pacbell.net> <alpine.DEB.2.00.0904060402140.22223@utopia.booyaka.com> <200904060323.21127.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33633 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbZDFKeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 06:34:14 -0400
In-Reply-To: <200904060323.21127.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russ Dill <russ.dill@gmail.com>, Artem Bityutskiy <dedekind@yandex.ru>, David Hagood <david.hagood@gmail.com>, linux-omap@vger.kernel.org

On Mon, 6 Apr 2009, David Brownell wrote:

> I'd think the first thing to check is two linux-omap PIO flavors:
> with vs without the prefetch/postwrite engine.  Benchmarking DMA
> would be a separate issue.  Ditto comparing kernels with/without
> write posting.

Makes sense to me.  FIFO-less GPMC PIO should be full of fail.

> Puzzle:  get a dma_copypage() to work faster than copy_page().
> Or a dma_clear_page() faster than clear_page().  Not easy...

Doing it via the DMA engine may save power, since MPU can sleep.


- Paul
