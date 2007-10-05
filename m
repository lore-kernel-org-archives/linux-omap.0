From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH] OMAP: Asynchronous clock disable
Date: Fri, 05 Oct 2007 16:25:59 +0300
Message-ID: <1191590759.7611.13.camel@localhost.localdomain>
References: <20071005125028.GA32101@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071005125028.GA32101@angel.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, 2007-10-05 at 15:50 +0300, ext Jarkko Lavinen wrote:
> Hi
> 
> In N800 mmc driver we enable and disable mmc clock in a continous
> cycle with small delays.
> 
> I wonder if asynchronou clock disable has been suggested before?
> 
> I would like to be able to disable clocks asynchronously with a
> small delay so that when doing repetitive clk enable/disable
> cycle, the clock would just stay up and only shut down when
> the continuos stream of requests is over.

This could be applied also to other cases:
-PLL locking/relocking (however this is quite fast)
-external oscillator enabling/disabling; this can introduce significant
latency, so the oscillator would beleft running and OMAP could still go
to clock stop, rather than the current implementation which prevents
retention

> What I would like to do is:

<snip>

> For clearing up pending clock disables I use clk_flush_disable(clk)
> clears out any pending disable immediately.
> 
>      clk_enable(clk);
>      clk_disable_async(clk, HZ);
>      ... later
>      clk_flush_disable(clk)

This is ok but anyway i don't see it as being badly needed since in a
practical use case it would be probably used after a long sequence:

do {
	clk_enable(clk);
	do_something_requiring_clk();
	clk_disable_async(clk, HZ);
} while (work_left());
clk_flush_disable(clk);


so i expect the improvement to be minimal to the case where the timer is
left to expire (i assume the timer won't be too long, otherwise the
clock would have been released for good every time)

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
