From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HDQ: was Re: DSS2/PM on 3.2 broken?
Date: Fri, 27 Jan 2012 23:02:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201271813260.13783@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <20120113222045.37f9b4ec@notabene.brown> <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com> <20120114100915.01c96727@notabene.brown> <20120118082410.48262777@notabene.brown> <alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
 <20120124213705.49f042bf@notabene.brown> <alpine.DEB.2.00.1201260647570.11174@utopia.booyaka.com> <20120128093530.0a0a370a@notabene.brown> <alpine.DEB.2.00.1201271541110.13783@utopia.booyaka.com> <20120128114012.1bd76ca5@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34628 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2A1GC4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Jan 2012 01:02:56 -0500
In-Reply-To: <20120128114012.1bd76ca5@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Sat, 28 Jan 2012, NeilBrown wrote:

> On Fri, 27 Jan 2012 15:58:40 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> > Hmm, okay.  Could you please remove the register read from the HDQ probe 
> > and see if that makes a difference?
> 
> So with 'kzalloc' in place of 'kmalloc' where hdq_data is allocated, the qos
> patch does make my problem go away.  It feels a bit heavy-handed though.

Thanks for the test.  It's not clear to me how this driver could really 
work well if the MPU powerdomain is able to go to a low power state 
between the two phases of the transaction.  There's no wakeup source, so 
the interrupt won't be handled until another device wakes the system up.  
Of course, if you have a lot of wakeups coming from other devices, or if 
something is forcing the MPU powerdomain to stay ON or INACTIVE, this may 
not really matter.

So you might want that patch, at least on 3.3.  But from your following 
text, it sounds like there is another problem.

> > The OMAP PRCM hardware should keep the CORE* clkdms active when the 
> > hdq_fck is enabled.  So it's possible there could be a PRCM silicon bug 
> > that doesn't take hdq_fck into account when determining whether the CORE_* 
> > clkdms are inactive.

...

> clkdm_allow_idle(struct clockdomain *clkdm) tells the hardware to allow that
> clkdm to go idle, and it does so with no reference to whether any clk in the
> clkdm is current enabled.

Since the HDQ module doesn't support the idle protocol, the target clock 
FSM in the CM is what should determine whether the module is considered 
idle or not.  And as long as the bit in the CM_FCLKEN register 
corresponding to HDQ_FCLK is set, the FSM should consider the module as 
active, and the clockdomain should not be allowed to go inactive.

I write "should."  Given that big caution at the bottom of section 20.4.5 
"System Power Management and Wakeup", this appears to have not been 
correctly implemented.

> It also mentions the AUTO_HDQ bit of PRCM.CM_AUTOIDLE1_CORE.  This had me
> confused for a while, but I think it only affects the iclk.  

That's correct.

> I don't think the iclk is the problem.  It is the fclk that is 
> disappearing because the clkdm that feeds it is being turned off.

Disabling AUTO_HDQ is probably a reasonable workaround.  It would prevent 
the CORE_L4 clockdomain from going inactive, and that happens to be where 
the functional clock originates from, also.

We have a partial facility to handle this type of bug in the existing 
code.  Could you please try the patch enclosed at the bottom of this 
E-mail and see if it helps?

> My idea of a fix would be a secondary reference count on each clkdm.
> When a clk that doesn't have an associated SIDLE setting is activated we
> increase this reference count (and decrease it when the clk is deactivated).
> 
> While the count is non-zero we deny_idle for that clkdm.
> 
> Or something like that.

I think we can work around this case with the OCPIF_SWSUP_IDLE flag, since 
the functional clock and interface clock are in the same clockdomain.

> Thanks for listening :-)

Thanks for working through this bug and helping test :-)

> (*) Another note about UARTs.
>   In 3.2 (haven't checked 3.3) the driver not only sets SMARTIDLE but also
>   stops the clocks when things are idle.
>   So when RX goes low and the UART wakes us up it doesn't get a clock
>   straight away but we have to wait for code to enable the clock.
>   In my experiments, this is fast enough to stay in-sync for speeds up to
>   38400 (I think).  Above there we miss the first bit and get corrupt
>   characters.
>   I think that if the UART is expecting data it should not disable the clock
>   but should use SMARTIDLE to let it turn off, and then turn back on again
>   quickly.... but maybe 3.3 gets that right.

With the most recent UART patch set that was posted against 3.3-rc1, as 
long as the CORE powerdomain isn't in a low-power state, the UART can 
enter idle with clocks cut and still wake up quickly enough to handle 
incoming data at 115200 8n1 on the 35xx BeagleBoard.  That all happens in 
hardware; no kernel involvement is needed.  I don't see the corrupt 
characters that you do, but there may be a 35xx vs. 37xx difference here.  
(You're using an OMAP37xx?)


- Paul

>From 16b9f4ee44f96846fad5a9cb0e55bcd25b77ed59 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 27 Jan 2012 22:46:34 -0700
Subject: [PATCH] Try software-supervised control of HDQ_ICLK

 Do not automatically enable interface clock autoidle on
 HDQ_ICLK. Require the hwmod layer to use software gating on
 HDQ_ICLK. This is because the CM FSM that handles HDQ_FCLK
 appears to not be working as expected.  This patch is
 experimental, untested, and for bug-testing purposes only.

---
 arch/arm/mach-omap2/clock3xxx_data.c       |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 arch/arm/plat-omap/clock.c                 |    4 +++-
 arch/arm/plat-omap/include/plat/clock.h    |    1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 98cb408..96ba9f9 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1883,6 +1883,7 @@ static struct clk hdq_ick = {
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
 	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
+	.flags		= SWSUP_ICLK_IDLE, 
 };
 
 static struct clk mcspi4_ick = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index dd155c4..37af75a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -239,7 +239,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__hdq1w = {
 	.clk		= "hdq_ick",
 	.addr		= omap2_hdq1w_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-	.flags		= OMAP_FIREWALL_L4
+	.flags		= OMAP_FIREWALL_L4 | OCPIF_SWSUP_IDLE,
 };
 
 /* L4 CORE -> UART1 interface */
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 567e4b5..3fce16a 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -348,7 +348,9 @@ int omap_clk_enable_autoidle_all(void)
 	spin_lock_irqsave(&clockfw_lock, flags);
 
 	list_for_each_entry(c, &clocks, node)
-		if (c->ops->allow_idle)
+		if (c->flags & SWSUP_ICLK_IDLE && c->ops->deny_idle)
+			c->ops->deny_idle(c);
+		else if (c->ops->allow_idle)
 			c->ops->allow_idle(c);
 
 	spin_unlock_irqrestore(&clockfw_lock, flags);
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 240a7b9..f4f6e7b 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -191,6 +191,7 @@ struct dpll_data {
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
+#define SWSUP_ICLK_IDLE		(1 << 6)
 
 /**
  * struct clk - OMAP struct clk
-- 
1.7.8.3

