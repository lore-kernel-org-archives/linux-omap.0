From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: OMAPFB_FILLRECT and friends
Date: Tue, 7 Feb 2006 16:57:44 +0200
Message-ID: <20060207145744.GA5196@nokia.com>
References: <EA12F909C0431D458B9D18A176BEE4A504365210@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A504365210@dlee02.ent.ti.com>
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

Hi Richard,

On Tue, Feb 07, 2006 at 07:57:44AM -0600, Woodruff, Richard wrote:
> > I've made the measurements on OMAP1610/1710 platforms. What I wanted
> > to see is that using the DMA will indeed offload the MPU. In reality
> > the MPU was practically stalled, I assume because of SDRAM or system
> > bandwidth limitation and the fact the we have a cache flush between
> > context switches.
> 
> 2420 and 2430 have much greater bandwidth though the L3 interconnects to
> the DDR (16/17xx < 2420 < 2430 in this regard).  And v6 doesn't flush
> caches nearly as much so many of these effects are gone.
> 
That's irrelevant in the DMA case, since there's no snooping logic and we
have the write-back or invalidate depending on direction anyways. It's
certainly not as frequent as every context switch, but it's still going
to have an impact on performance.

If the MPU ends up stalling anyways, then offloading to DMA is pointless,
since the offload doesn't really buy you anything, not to mention the
higher cost of setting up the DMA in the first place.

Unless it's a clear win from a performance point of view, it's not
obvious that having the added complexity of the code in the driver is a
worthwhile tradeoff. The numbers provided by Imre don't indicate that DMA
is a significant win, if you have some that show otherwise, it'd be
interesting to see your test cases, and effect they have on MPU stalling.
