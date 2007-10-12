From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Make dyntick work again
Date: Fri, 12 Oct 2007 13:06:12 -0700
Message-ID: <20071012200612.GE7979@atomide.com>
References: <20071011203240.GL503@atomide.com>
	<002c01c80c74$9f0f5160$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <002c01c80c74$9f0f5160$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Kyungmin Park <kmpark@infradead.org> [071011 19:07]:
> Hi,
> 
> Umm, there's a problem, I can't boot with timer32k.
> It halts at here.

<snip>

> It's also can't boot 2.6.22, umm I will track this one.

Hmm, works on n800 which is 2420. Maybe it's some 2430 related issue?
 
> Anyway, I used the mpu timer and here's the dyntick result. (mpu also support the oneshot in the code)
> Is it the right results?
> 
> / # grep time /proc/interrupts ; sleep 10; grep time /proc/interrupts
>  37:        714        INTC  gp timer
>  37:        787        INTC  gp timer
> / # grep time /proc/interrupts ; sleep 10; grep time /proc/interrupts
>  37:        880        INTC  gp timer
>  37:        959        INTC  gp timer

Yes, (959 - 880) / 10 = 7 ticks per second. We should be able to get
down to ~2 ticks per second with an idle system already, so sounds
like there are some kernel timers running.

Time to try powertop on omap!

Tony
