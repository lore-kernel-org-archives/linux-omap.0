From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: Re: Memory performance / Cache problem
Date: Wed, 14 Oct 2009 20:37:14 +0300
Message-ID: <200910142037.15063.siarhei.siamashka@nokia.com>
References: <20091012083806.323990@gmx.net> <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com> <20091014144839.115530@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53241 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZJNRiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 13:38:51 -0400
In-Reply-To: <20091014144839.115530@gmx.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext epsi@gmx.de" <epsi@gmx.de>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "premi@ti.com" <premi@ti.com>

On Wednesday 14 October 2009 17:48:39 ext epsi@gmx.de wrote:
> Mem clock is both times 166MHz. I don't know whether are differences in
> cycle access and timing, but memclock is fine.
>
> Following Siarhei hints of initialize the buffers (around 1.2 MByte each)
> I get different results in 22kernel for use of
> malloc alone
> memcpy =   473.764, loop4 =   448.430, loop1 =   102.770, rand =    29.641
> calloc alone
> memcpy =   405.947, loop4 =   361.550, loop1 =    95.441, rand =    21.853
> malloc+memset:
> memcpy =   239.294, loop4 =   188.617, loop1 =    80.871, rand =     4.726
>
> In 31kernel all 3 measures are about the same (unfortunatly low) level of
> malloc+memset in 22.
>
> First of all: What performance can be expected?
> Does 22 make failures if it is so much faster?
> Can the later kernels get a boost in memory handling?

What you see is just a (fake) performance boost because you have a single
physical page shared between all the virtual pages in the source buffer. So
you get no cache misses on read operations and everything seems fast.

This is unlikely to happen on real use, and it does not reflect real memory
performance. So the benchmark is inadequate.

You can get some basic information here:
http://en.wikipedia.org/wiki/Copy-on-write

Regarding the difference in behavior between .22 and recent kernels. It may be
some regression in copy-on-write implementation, or just some change done on
purpose. That is assuming that the userspace stuff was identical in both
tests.

-- 
Best regards,
Siarhei Siamashka
