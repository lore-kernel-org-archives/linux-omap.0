From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 07:48:09 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com>
References: <1232360583.6481.92.camel@tubuntu>
 <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com>
 <20090119134329.GA18301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57390 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbZASNsi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 08:48:38 -0500
In-Reply-To: <20090119134329.GA18301@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> On Mon, Jan 19, 2009 at 07:34:47AM -0600, Woodruff, Richard wrote:
> > > Running with latest linux-omap kernel on OMAP3 SDP board, I have problem
> > > with iounmap(). It looks like iounmap() does not properly free large
> > > areas. Below is a test which fails for me in 6-7 loops.
> > >
> > > OMAP spesific ioremap code doesn't do much, so I think it's somewhere in
> > > generic ARM code. I looked at the ioremap code and for larger areas the
> > > code uses area sections, and I believe the bug is somewhere there.
> > >
> > > Does this work on other processors?
> >
> > If you wait around a bit using some kind of schedule() + jiffy wait after
> > free will it work longer?
> >
> > Every now and then I've seen some deferred resource releases cause
> > failures of such loops.  Usually they are more obvious like if your
> > really malloc/free'ing direct memory, but there are indirect allocations
> > which might add up.
> >
> > Anyway, it's a behavioral question to help isolate.
>
> There is no deferred resource releasing here, so such a test is a waste
> of time.

None?  Aren't at least TLB table structures allocated to cover memory but some other tables?

Or are those all synchronous allocate and release?  I was under some impression that kmalloc's to get some of these came from slabs which don't reap right away.

Defiantly we have had issues in video memory before in these kinds of test loops.

Are you simplifying or am I just off.

Thanks,
Richard W.
