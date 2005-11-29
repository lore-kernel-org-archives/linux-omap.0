From: Tony Lindgren <tony@atomide.com>
Subject: Re: Worst Case ISR latency around 15ms??
Date: Mon, 28 Nov 2005 18:04:20 -0800
Message-ID: <20051129020420.GE8319@atomide.com>
References: <c43be92d0511242230v4c81fe25w58c66aa4c3fba9e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <c43be92d0511242230v4c81fe25w58c66aa4c3fba9e7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ajaya Babu Anne <anneajaya@gmail.com>
Cc: "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Ajaya Babu Anne <anneajaya@gmail.com> [051124 22:30]:
> Hi All,
> 
> I am seeing worst case IRQ latency in Linux up to 15 milli seconds, I am
> using 2.6.13 kernel and using JFFS2 file system on OSK board. I am wondering
> any patch available which ensures interrupt latency with in 1/2 milli
> seconds or no way in to ensure interrupt latency in the kernel?
> 
> I measured interrupt latency as fallows.
> 
> I've level sensitive interrupt which is connected to IRQ14 ( GPIO15 ), As
> soon as my isr get triggered I mask Level sensitive interrupt so it goes low
> , I am measuring the pulse width, I see most of the time it is around
> 20-44micro seconds, However I see some times it goes up to 15 miili seconds.
> 
> Any comments. Why is this so late?

Maybe you are missing interrupts with it?

You may want to play with the while loop in gpio.c bank interrupt handler
and see if it helps. I'm currently thinking that the while loop may be only
needed there for 1510.

Tony
