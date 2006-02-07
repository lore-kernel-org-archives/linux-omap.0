From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAPFB_FILLRECT and friends
Date: Tue, 7 Feb 2006 10:34:34 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A504365541@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <paul.mundt@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi Paul,

> On Tue, Feb 07, 2006 at 07:57:44AM -0600, Woodruff, Richard wrote:
> > > I've made the measurements on OMAP1610/1710 platforms. What I
wanted
> > > to see is that using the DMA will indeed offload the MPU. In
reality
> > > the MPU was practically stalled, I assume because of SDRAM or
system
> > > bandwidth limitation and the fact the we have a cache flush
between
> > > context switches.
> >
> > 2420 and 2430 have much greater bandwidth though the L3
interconnects to
> > the DDR (16/17xx < 2420 < 2430 in this regard).  And v6 doesn't
flush
> > caches nearly as much so many of these effects are gone.
> >
> That's irrelevant in the DMA case, since there's no snooping logic and
we
> have the write-back or invalidate depending on direction anyways. It's
> certainly not as frequent as every context switch, but it's still
going
> to have an impact on performance.

What is the mapping of the buffers in question?  It seems the mmap done
in fbmem.c will mark things as non-cached and at best for ARM write
combining.

DMA maintenance may or may not include cache flushing.  Depending on
what attributes the buffer is allocated with.  In the case of video it
is not cached in the general case.  Or are you referring to another
mechanism?

Having the ARM PIO to strongly ordered memory on a v6 will completely
stop the pipelines and uses a lot of logic to move data where it
probably can be done more efficiently with a tiny by logic comparison
DMA engine.  Having the ARM in a WFI is far better than having it do PIO
from a power perspective.

> If the MPU ends up stalling anyways, then offloading to DMA is
pointless,
> since the offload doesn't really buy you anything, not to mention the
> higher cost of setting up the DMA in the first place.

I think I'm missing something here.  Why is the MPU stalling here, isn't
there other work for it to do?  Why should it be dependency locked on
some graphics operation?  While the DMA is on going the CPU should be
off doing other work and get an async notification by the completion of
the event.  If there is nothing else for it to do, then fine it can be
stuck in idle.  Having the ability to other work is what matters.

When I think of stalling, I guess I look the micro architecture pipeline
level and then right up to the macro idle loop.  The micro level doesn't
seem to apply here but the loop does.

> Unless it's a clear win from a performance point of view, it's not
> obvious that having the added complexity of the code in the driver is
a
> worthwhile tradeoff. The numbers provided by Imre don't indicate that
DMA
> is a significant win, if you have some that show otherwise, it'd be
> interesting to see your test cases, and effect they have on MPU
stalling.

Measurements we take are used for internal comparisons and regression.
Releasing them requires several administrative actions which imply
overhead and at minimum re-running tests.  It is very likely that
customers can request such data triggering work, but it is something we
are not set up to release at present.

I agree that if you are talking about a couple of bytes the overhead for
a DMA may be more that it is worth.  But if you are talking about a
large block copy then it would seem DMA would be better.

Regards,
Richard W.
