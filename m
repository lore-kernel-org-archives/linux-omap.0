From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] I2C: Fix twl4030 timeouts on omap3430
Date: Tue, 1 Apr 2008 17:04:59 +0300
Message-ID: <20080401140458.GU26502@atomide.com>
References: <20080328084139.GJ24896@atomide.com> <20080331104332.GH26502@atomide.com> <20080331143011.GO26502@atomide.com> <20080401124354.GS26502@atomide.com> <20080401130027.GD5185@codecarver.research.nokia.com> <20080401133824.GT26502@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57600 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbYDAOFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Apr 2008 10:05:10 -0400
Content-Disposition: inline
In-Reply-To: <20080401133824.GT26502@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080401 16:39]:
> * Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080401 16:01]:
> > On Tue, Apr 01, 2008 at 03:43:56PM +0300, ext Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [080331 17:30]:
> > > > * Tony Lindgren <tony@atomide.com> [080331 13:43]:
> > > > > * Tony Lindgren <tony@atomide.com> [080328 10:41]:
> > > > > > Hi all,
> > > > > > 
> > > > > > This helps with the annoying I2C timeouts. Does anybody have an idea
> > > > > > why the twl4030 chip does not like doing multiple transfers in a row?
> > > > > > 
> > > > > > To me the only difference seems to be that clocks are idled between
> > > > > > writing the twl4030 register and reading the register value.
> > > > > 
> > > > > I'll push this today with a REVISIT comment added.
> > > > 
> > > > Looks like this kills twl4030 interrupts, so I've reverted it.
> > > 
> > > After looking into this problem a bit more, looks like twl4030 reads
> > > to anything in "POWER ID" (modules 0x10 and higher) will hang twl4030
> > > eventually and I2C controller gets stuck in mode where STP never clears.
> > > 
> > > Repeated reads to "USB ID", "AUD ID" or "AUX ID" will not hang twl4030.
> > > 
> > 
> > I remember seeing something similar when doing the powerbutton code. 
> > Klaus Pedersen found out that leaving CFG_BOOT to its reset value solved
> > the problem. Unfortunately this breaks MADC and USB afaics, so it's not
> > a real solution. CFG_BOOT is programmed in power_companion_init().
> 
> Great, this helped a lot! Looks like power_companion_init() tries to get
> osc_ck without checking for clkg_get() return value, and osc_ck does not
> exist in clock34xx.h. So R_CFG_BOOT gets set to default 26MHz value :)
> 
> Will post a patch when available.

Thanks again, here's a patch, I've pushed it also.

Tony

--IJpNTDwzlM2Ie8A6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="i2c-twl4030-clock.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 1 Apr 2008 16:58:02 +0300
Subject: [PATCH] I2C: Fix twl4030 clock init

Without this patch twl4030 clock can get programmed to incorrect rate
which can eventually hang twl4030 reads. Also minor formatting fixes.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -672,11 +672,20 @@ static int power_companion_init(void)
 	u32 rate, ctrl = HFCLK_FREQ_26_MHZ;
 	int e = 0;
 
-	osc = clk_get(NULL,"osc_ck");
+	if (cpu_is_omap2430())
+		osc = clk_get(NULL, "osc_ck");
+	else
+		osc = clk_get(NULL, "osc_sys_ck");
+	if (IS_ERR(osc)) {
+		printk(KERN_ERR "Skipping twl3040 internal clock init and "
+				"using bootloader value (unknown osc rate)\n");
+		return 0;
+	}
+
 	rate = clk_get_rate(osc);
 	clk_put(osc);
 
-	switch(rate) {
+	switch (rate) {
 		case 19200000 : ctrl = HFCLK_FREQ_19p2_MHZ; break;
 		case 26000000 : ctrl = HFCLK_FREQ_26_MHZ; break;
 		case 38400000 : ctrl = HFCLK_FREQ_38p4_MHZ; break;
@@ -684,7 +693,7 @@ static int power_companion_init(void)
 
 	ctrl |= HIGH_PERF_SQ;
 	e |= unprotect_pm_master();
-			/* effect->MADC+USB ck en */
+	/* effect->MADC+USB ck en */
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
 

--IJpNTDwzlM2Ie8A6--
