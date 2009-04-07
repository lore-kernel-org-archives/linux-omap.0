From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Benchmarking: POP flash vs. MMC?
Date: Tue, 7 Apr 2009 07:09:44 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037BC8739E@dlee02.ent.ti.com>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>
 <49D9B21A.2000002@yandex.ru>
 <f9d2a5e10904060113g37c3dd7fk5be6d3a12ab169c4@mail.gmail.com>
 <200904060259.00439.david-b@pacbell.net>
 <alpine.DEB.2.00.0904060402140.22223@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZDGMKA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 08:10:00 -0400
In-Reply-To: <alpine.DEB.2.00.0904060402140.22223@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, David Brownell <david-b@pacbell.net>
Cc: Russ Dill <russ.dill@gmail.com>, Artem Bityutskiy <dedekind@yandex.ru>, David Hagood <david.hagood@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> We'd also have to make sure that the comparison is between the linux-omap
> kernel and the OMAPZoo kernel, rather than o-z PIO vs. o-z DMA.  The
> OMAPZoom kernel doesn't post any device register writes.  That should
> cause any driver using PIO to drag, compared to the l-o kernel.

There effetely are a few levels of posting. The patch stops _ARM_ PIO to peripheral control registers from hanging out in the interconnect. Other levels still are there. The big winner of interconnect from ARM side is DDR operations which is still gets posted at all levels.  The size of buffering in interconnect is like a couple cache lines so it will fill up pretty fast.  DMA and other initiators are not impacted as they don't use arm-mmu attributes.

Really, if you think about it "big" block writes may not be impacted either as you will back up at the slower device's speed. Cache is a familiar example. If you write out 100M quickly you will get to a point where you are bottlenecked on main memory speed very quickly (every write is a miss or cast out at some point). The fact you have a cache in the way doesn't matter.

It can make some difference if you're intermixing some small PIOs with other work. In general benchmarks I've yet to see the hit on system against all the bigger noises. Probably I can construct a case where ~10% is lost.

I recall some tests which have dma + prefetch working on nand.  I'll see if I can dig them up.

I've was at several meetings a year back where different memory vendors come in and showed with some tweak they can get 2x l-o on flash. Then if you also take their device optimized file system you will get like 5x. Hopefully at least the in tree 2x is gone now that it's a year later.

Regards,
Richard W.

