From: Tony Lindgren <tony@atomide.com>
Subject: Re: is dynamic tick working?
Date: Sun, 14 May 2006 03:49:18 -0700
Message-ID: <20060514104911.GB4715@atomide.com>
References: <200605121905.13405.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200605121905.13405.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [060512 19:05]:
> On an OSK, using today's GIT tree, I turned on dynamic tick using
> sysfs and thought the IRQ rate (32 KHz timer) was odd.  So I did
> 
>   grep tim /proc/int*; sleep 60; grep tim /proc/int*
> 
> and saw 104551 IRQs, which is 1742 per second.  Too many!!  When
> I turned dyntick off (on/off via sysfs) the same measurement
> gave a more reasonable 7701 IRQs, making 128 per second.
> 
> In short, enabling dyntick got me 14x as many IRQs, instead of
> shrinking the number of IRQs.  Known bug?

Is this with touchscreen enabled? I saw something similar last week
where SPI was generating interrupts continuously. I think Imre has a
patch for that already available.

With dyntick the timer interrupt handler is being called also from
other interrupt handlers to update time. So doing something like:

$ cat /proc/interrupts; sleep 10; cat /proc/interrupts

might give you a clue which device interrupt is stuck.

In general dyntick should work, and you should see about 4-6HZ idle
tick rate.

Regards,

Tony
