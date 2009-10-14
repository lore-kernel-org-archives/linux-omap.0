From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Memory performance / Cache problem
Date: Wed, 14 Oct 2009 12:46:40 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B236123@dlee02.ent.ti.com>
References: <20091012083806.323990@gmx.net>
 <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com>
 <20091014144839.115530@gmx.net>
 <200910142037.15063.siarhei.siamashka@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47803 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbZJNRrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 13:47:23 -0400
In-Reply-To: <200910142037.15063.siarhei.siamashka@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>, "ext epsi@gmx.de" <epsi@gmx.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>


> From: Siarhei Siamashka [mailto:siarhei.siamashka@nokia.com]
> Sent: Wednesday, October 14, 2009 12:37 PM
> To: ext epsi@gmx.de

> What you see is just a (fake) performance boost because you have a single
> physical page shared between all the virtual pages in the source buffer. So
> you get no cache misses on read operations and everything seems fast.
>
> This is unlikely to happen on real use, and it does not reflect real memory
> performance. So the benchmark is inadequate.

Yep, benchmark is only useful so far.  If you control factors it can be useful but it's far from 1-1, to extrapolate it to something meaningful at system level.

You can actually get even 'better' numbers if you take the DDR part geometry into mind and SDRC (sdram-controller) scheduler.  Our silicon validation people report out of this world numbers for very specific test cases.  These are component tests for the memory controller to make sure it behaves.  If you alternate between open banks you can do really fast operations.

A good amount of that test is not practical to count on at HLOS level.  It can help explain some anomalies and help in designing a fair test.

Regards,
Richard W.

