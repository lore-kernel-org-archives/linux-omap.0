From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] ARM: OMAP: fix default sys_ck.rate for boot-time
	DPLLdetection
Date: Mon, 22 Oct 2007 09:52:23 -0700
Message-ID: <471CD547.6090206@mvista.com>
References: <20071019211415.183990583@mvista.com>
	<1193037864.29349.261.camel@localhost.localdomain>
	<3B6D69C3A9EBCA4BA5DA60D9130274290249C536@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290249C536@dlee13.ent.ti.com>
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

Woodruff, Richard wrote:
> The TI code does this with init_osc_sys_clk_rates() function.  The
> preset bit in structure likely isn't needed.
> 
> The APLLS field which is setup by the bootloader is used to know osc and
> sys clk's rates.
> 
> A little while back Paul had patched some of this and the initial go did
> result in a bad value for this.  After this was pointed out a subsequent
> patch was pushed to fix this.  Perhaps yet another patch broke this or
> perhaps the version you are using was missing this update.

I was working from the head of OMAP git, and it was broken there.

It looks like the git tree has the equivalent funtion to the one you
mentioned from the TI tree (see omap2_osc_clk_recalc), but it doesn't
work for sys_ck.  The osc_ck is correctly being set, but it's not
propagating to sys_ck because it uses propagate_rate() which doesn't
work since none of the clocks are registered yet.

The simple fix I tried was to move the osc_clk_recalc() after all the
clk_registers, but then it no longer boots (didn't investigate too deeply.)

The easier fix is to simply add omap2_sys_clk_recalc() as in the
following patch (which also reverts my previous patch.)  If that seems
reasonable, I'll submit it.

Kevin

Index: dev/arch/arm/mach-omap2/clock24xx.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/clock24xx.c
+++ dev/arch/arm/mach-omap2/clock24xx.c
@@ -475,6 +475,7 @@ int __init omap2_clk_init(void)
 	clk_init(&omap2_clk_functions);

 	omap2_osc_clk_recalc(&osc_ck);
+	omap2_sys_clk_recalc(&sys_ck);

 	for (clkp = onchip_24xx_clks;
 	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
Index: dev/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- dev.orig/arch/arm/mach-omap2/clock24xx.h
+++ dev/arch/arm/mach-omap2/clock24xx.h
@@ -581,7 +581,6 @@ static struct clk osc_ck = {		/* (*12, *
 /* With out modem likely 12MHz, with modem likely 13MHz */
 static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
-	.rate           = 13000000,
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | RATE_PROPAGATES,
