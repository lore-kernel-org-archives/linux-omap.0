From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/32] Convert ARM to generic irq subsystem
Date: Tue, 2 May 2006 04:59:15 -0700
Message-ID: <20060502115914.GF24728@atomide.com>
References: <20060407095850.690110000@localhost.localdomain>
	<20060426230543.GA28908@flint.arm.linux.org.uk>
	<44529239.2060409@mvista.com>
	<1146263927.1322.640.camel@localhost.localdomain>
	<4452A282.4050909@mvista.com>
	<1146305308.1322.657.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1146305308.1322.657.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-omap-open-source@linux.omap.com, LAK <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [060429 03:08]:
> On Fri, 2006-04-28 at 16:17 -0700, Kevin Hilman wrote:
> > ok, I tried with -rc3 and I still dont see any GPIO interrupts.
> > 
> > After looking closer at the IRQ_TYPE_* flags, I noticed that they didn't match 
> > the SA_TRIGGER_* flags for _FALLING or _RISING.  The following patch swaps the 
> > two and make OMAP happy.  It's now booting, and things seem sane.  Will do some 
> > more intensive testing
> > 
> > Kevin
> 
> Sigh. I knew I'd screw that one up.
> 
> Applied and released -rc3-armirq2.

Patches seem to work for me too on various omap boards. Also dyntick
works.

Should this part in kernel/irq/handle.c be CONFIG_ARM for now?

@@ -84,6 +229,15 @@ fastcall int handle_IRQ_event(unsigned i
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
+#if defined(CONFIG_NO_IDLE_HZ)
+	if (!(action->flags & SA_TIMER) && system_timer->dyn_tick !=
NULL) {
+		write_seqlock(&xtime_lock);
+		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)
+			system_timer->dyn_tick->handler(irq, 0, regs);
+		write_sequnlock(&xtime_lock);
+	}
+#endif
+
 	do {
 		ret = action->handler(irq, action->dev_id, regs);
 		if (ret == IRQ_HANDLED)

Regards,

Tony
