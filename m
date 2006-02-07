From: Imre Deak <imre.deak@nokia.com>
Subject: RE: OMAPFB_FILLRECT and friends
Date: Tue, 07 Feb 2006 09:18:51 +0200
Message-ID: <1139296731.5498.13.camel@mammoth.research.nokia.com>
References: <EA12F909C0431D458B9D18A176BEE4A5042DCC28@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5042DCC28@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2006-02-06 at 07:36 -0600, ext Woodruff, Richard wrote:
> > $ git checkout -b <branch> <commit id>
> > 
> > > Was this stuff once there and later removed (it
> > > doesn't seem to be in tip of tree) and if so, why?
> > 
> > Yes, I removed it because later performance testing showed no
> > improvement whatsoever when using DMA for SDRAM - SDRAM transfers
> > compared to using MPU bursts.
> > 
> > Being a dead code I didn't see any reason leaving it in the driver.
> 
> Generally unless the MPU overhead is high, using DMA usually drops the
> CPU load even if the performance is equivalent. 

Yes, that's the only benefit I would have expected.

>  Ideally test runs
> capturing raw throughput, cpu load, and power usage would happen along
> with such tweaks. 
>  The results may vary across CPUs as internals are not
> all equal even though the register set may be close.

I've made the measurements on OMAP1610/1710 platforms. What I wanted to
see is that using the DMA will indeed offload the MPU. In reality the
MPU was practically stalled, I assume because of SDRAM or system
bandwidth limitation and the fact the we have a cache flush between
context switches.

This I tested running X which used the DMA versions of the copy and fill
operations.

--Imre

> 
> Regards,
> Richard W.
