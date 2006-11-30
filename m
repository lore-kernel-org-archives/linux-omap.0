From: tony@atomide.com
Subject: Re: [patch 2.6.19-rc6-omap1] MPUIO wake updates
Date: Thu, 30 Nov 2006 15:14:17 -0800
Message-ID: <20061130231417.GI9605@atomide.com>
References: <20061128073226.0816C1E1937@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061128073226.0816C1E1937@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061127 23:40]:
> GPIO and MPUIO wake updates:
> 
>  - Hook MPUIOs into the irq wakeup framework too.  This uses a platform
>    device to update irq enables during system sleep states, instead of
>    a sys_device, since the latter is no longer needed for such things.
> 
>  - Also forward enable/disable irq wake requests to the relevant GPIO
>    controller, so the top level IRQ dispatcher can (eventually) handle
>    these wakeup events automatically if more than one GPIO pin needs to
>    be a wakeup event source.
> 
>  - Minor tweak to the 24xx non-wakeup gpio stuff: no need to check such
>    read-only data under the spinlock.
> 
> This assumes (maybe wrongly?) that only 16xx can do GPIO wakeup; without
> a 15xx I can't test such stuff.
> 
> Also this expects the top level IRQ dispatcher to properly handle requests
> to enable/disable irq wake, which is currently known to be wrong:  omap1
> saves the flags but ignores them, omap2 doesn't even save it.  (Wakeup
> events are, wrongly, hardwired in the relevant mach-omapX/pm.c file ...)
> So MPUIO irqs won't yet trigger system wakeup.

Pushing today.

Tony
