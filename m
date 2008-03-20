From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmtimer posting
Date: Thu, 20 Mar 2008 14:19:01 +0200
Message-ID: <20080320121900.GG14978@atomide.com>
References: <87abkv9917.fsf@paris.hilman.org> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA382@dlee13.ent.ti.com> <20080319141504.GB14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA4F9@dlee13.ent.ti.com> <20080319155835.GE14860@atomide.com> <3B6D69C3A9EBCA4BA5DA60D91302742903CCA8F8@dlee13.ent.ti.com> <20080320115749.GF14978@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61332 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYCTMTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 08:19:39 -0400
Content-Disposition: inline
In-Reply-To: <20080320115749.GF14978@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080320 13:58]:
> * Woodruff, Richard <r-woodruff2@ti.com> [080320 00:14]:
> > 
> > One note is some more optimization could happen later on with
> > reordering.  The current usage in gptimer has dmtimer_set_load()
> > followed by a dm_timer_start().  This causes a read/write/read/write of
> > the CTRL register.  Those writes could be collapsed into each other.
> > With a load_start().  Others maybe elsewhere.
> 
> OK. We might also want to optimize the timer reload function. I'll post
> a separate patch on that to experiment with.

Here's an experimental patch that attempts to optimize the timer
reloading for gp_timer0. I don't know if this improves the latency
or performance, but might be worth testing.

I guess there's no way to update the timer without having to write
TCLR to (re)start it?

If the patch helps, then we can clean it up a bit more.

Tony

--zx4FCpZtqtKETZ7O
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gptimer0-reload.patch"

commit 25146a33220bb264f06dd61e407435d16c371288
Author: Tony Lindgren <tony@atomide.com>
Date:   Thu Mar 20 13:47:23 2008 +0200

    ARM: OMAP: Optimize timer reload by bypassing omap_gp_timer_set_next_event()
    
    This patch optimizes the timer reprogramming that happens during every
    timer interrupt.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 78d05f2..7805fa2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -65,6 +65,58 @@ static int omap2_gp_timer_set_next_event(unsigned long cycles,
 	return 0;
 }
 
+#define OMAP2420_GP_TIMER0_BASE		0x48028000
+#define OMAP2430_GP_TIMER0_BASE		0x49018000
+#define OMAP34XX_GP_TIMER0_BASE		0x48318000
+#define GP_TIMER_TCLR			0x24
+#define GP_TIMER_TCRR			0x28
+#define GP_TIMER_TWPS			0x34
+#define		TWPS_MASK		0x3	/* Check for TCLR and TCRR */
+
+/*
+ * Reloads gp_timer0 value. Assumes that gp_timer0 has be set into posted mode
+ * during init. Bypassess the gp_timer functions to optimize timer reloading
+ * during timer interrupts.
+ */
+#define GP_TIMER0_RELOAD(cycles, base)						\
+{										\
+	while ((__raw_readl(IO_ADDRESS((base) + GP_TIMER_TWPS)) & TWPS_MASK))	\
+		cpu_relax();							\
+	__raw_writel(0xffffffff - (cycles),					\
+			IO_ADDRESS((base) + GP_TIMER_TCRR));			\
+	__raw_writel(0x3, IO_ADDRESS((base) + GP_TIMER_TCLR));			\
+}
+
+#ifdef CONFIG_ARCH_OMAP24XX
+static int omap2420_gp_timer0_reload(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	GP_TIMER0_RELOAD(cycles, OMAP2420_GP_TIMER0_BASE);
+	return 0;
+}
+
+static int omap2430_gp_timer0_reload(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	GP_TIMER0_RELOAD(cycles, OMAP2430_GP_TIMER0_BASE);
+	return 0;
+}
+#else
+#define omap2420_gp_timer0_reload	NULL
+#define omap2430_gp_timer0_reload	NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+static int omap34xx_gp_timer0_reload(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	GP_TIMER0_RELOAD(cycles, OMAP34XX_GP_TIMER0_BASE);
+	return 0;
+}
+#else
+#define omap34xx_gp_timer0_reload	NULL
+#endif
+
 static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 				    struct clock_event_device *evt)
 {
@@ -93,7 +145,7 @@ static struct clock_event_device clockevent_gpt = {
 	.name		= "gp timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.shift		= 32,
-	.set_next_event	= omap2_gp_timer_set_next_event,
+	.set_next_event	= omap2_gp_timer_set_next_event, /* Init can rewrite */
 	.set_mode	= omap2_gp_timer_set_mode,
 };
 
@@ -111,6 +163,15 @@ static void __init omap2_gp_clockevent_init(void)
 #endif
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
+	if (cpu_is_omap2420())
+		clockevent_gpt.set_next_event = omap2420_gp_timer0_reload;
+	else if (cpu_is_omap2430())
+		clockevent_gpt.set_next_event = omap2430_gp_timer0_reload;
+	else if (cpu_is_omap34xx())
+		clockevent_gpt.set_next_event = omap34xx_gp_timer0_reload;
+	else
+		clockevent_gpt.set_next_event = omap2_gp_timer_set_next_event;
+
 	omap2_gp_timer_irq.dev_id = (void *)gptimer;
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
 	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);

--zx4FCpZtqtKETZ7O--
