From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] : Fix annoying 'too much work for irq72' serial port
	watermark error.
Date: Thu, 23 Mar 2006 11:46:28 -0800
Message-ID: <20060323194604.GH22325@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A504E6159F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A504E6159F@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [060323 11:30]:
> Perhaps this version is better.  It avoids a possible double entry to
> transmit_chars() and removes the need for an #ifdef OMAPxyz.

OK, let's test this on various boards.

> > I was just trying out a different PRCM set on 2420/2430 and the
> annoying
> > serial 'too much work' interrupt started up again even with an SCR=8.
> > I've attached a patch which fixes the problem.  At fastest PRCM sets
> > timing some issues have popped up which have been masked before.
> > 
> > Note: This patch is a consolidated on with the other patches I had
> > previously sent which have not been applied, as this is what I tested
> > with.  The timer version in this patch is good, and I validated
> outputs
> > using the emulator at function entry/exits.  Some of the earlier
> > versions had overflow issues with nano-seconds.
> > 
> > This patch now allows the OMAP_SCR to go back to 0, though it works
> > either way.  This issue was this:  A THR interrupt can be generated
> > which has status in the IIR, but without status in the LSR.  This is
> > because the TX watermark interrupt happens when the FIFO and SR are
> NOT
> > empty.  The previous logic assumed at least the FIFO was empty before
> > calling the TX routine.  For a watermark this is not the case.  The
> fix
> > I added to this code checks the SSR (supplementary status register) to
> > see if there is room in the FIFO.  Given we know how it was loaded
> there
> > will be room if this shows it is not empty.

Thanks, I'll take a look at the timer code soonish.

Tony
