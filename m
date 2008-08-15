From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [1/2]
Date: Fri, 15 Aug 2008 11:12:16 +0300
Message-ID: <20080815111216.5dcf2a0d.jarkko.nikula@nokia.com>
References: <7B4574D56E4ADF438756313E9A172A870D5F0E58@dlee01.ent.ti.com>
	<20080813135721.GC27446@atomide.com>
	<20080814091329.bcb2755e.jarkko.nikula@nokia.com>
	<7B4574D56E4ADF438756313E9A172A870D6651CF@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18031 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYHOIMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 04:12:31 -0400
In-Reply-To: <7B4574D56E4ADF438756313E9A172A870D6651CF@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hunter, Jon" <jon-hunter@ti.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 14 Aug 2008 10:09:52 -0500
"ext Hunter, Jon" <jon-hunter@ti.com> wrote:

> Hi Tony, Jarkko,
> 
> > > Let's rather get rid of the direct mcbsp register tinkering from
> > > drivers and use following instead:
> > >
> > Workaround for omap_mcbsp3_aic23_clock_init not adding new McBSP API
> > would be to put those registers into "struct omap_mcbsp_reg_cfg" and
> > call omap_mcbsp_config.
> 
> 
> You know I am curious which omap board this function was added for? Going back and reviewing the OMAP5912 OSK schematics the 12MHz clock for the aic23 is provided from the OMAP5912 MCLK and not the McBSP3. So my feeling is that short term this should definitely be moved from the aic23 driver to a board specific file because I am not sure that this is even necessary for OMAP5912.
> 
I have a fear that the Nokia 770 is the reason here... :-)

Can you try patch below is it working on OSK?


Jarkko

---

>From a6d17c3d7cbc16fb0cf5df6617cff64c9f764345 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Fri, 15 Aug 2008 08:55:38 +0300
Subject: [PATCH] i2c: Remove McBSP3 clock initialization from tlv320aic23.c

McBSP3 clock initialization doesn't below here and even doesn't compile
anymore. Remove code since OMAP5912 OSK doesn't need it. However AIC23
in Nokia 770 uses master clock from McBSP3 but it's better to handle this in
board-nokia770.c or develope ALSA SoC support for it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/i2c/chips/tlv320aic23.c |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/chips/tlv320aic23.c b/drivers/i2c/chips/tlv320aic23.c
index 10671e8..ffa0ed2 100644
--- a/drivers/i2c/chips/tlv320aic23.c
+++ b/drivers/i2c/chips/tlv320aic23.c
@@ -96,38 +96,6 @@ int aic23_write_value(u8 reg, u16 value)
 	return 0;
 }
 
-/*
- * Configures the McBSP3 which is used to send clock to the AIC23 codec.
- * The input clock rate from DSP is 12MHz.
- * The DSP clock must be on before this is called.
- */
-static int omap_mcbsp3_aic23_clock_init(void)
-{
-	u16 w;
-
-	/* enable 12MHz clock to mcbsp 1 & 3 */
-	__raw_writew(__raw_readw(DSP_IDLECT2) | (1<<1), DSP_IDLECT2);
-	__raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1<<1, DSP_RSTCT2);
-
-	/* disable sample rate generator */
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR1, 0x0000);
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, 0x0000);
-
-	/* pin control register */
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, PCR0,(CLKXM | CLKXP | CLKRP));
-
-	/* configure srg to send 12MHz pulse from dsp peripheral clock */
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR1, 0x0000);
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR2, CLKSM);
-
-	/* enable sample rate generator */
-	w = OMAP_MCBSP_READ(OMAP1610_MCBSP3_BASE, SPCR2);
-	OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, (w | FREE | GRST));
-	printk("Clock enabled to MCBSP1 & 3 \n");
-
-	return 0;
-}
-
 static int aic23_detect_client(struct i2c_adapter *adapter, int address,
 				     int kind)
 {
@@ -167,8 +135,6 @@ static int aic23_detect_client(struct i2c_adapter *adapter, int address,
 		selftest = -ENODEV;
 		return selftest;
 	}
-	/* FIXME: Do in board-specific file */
-	omap_mcbsp3_aic23_clock_init();
 
 	if (!aic23_info_l.power_down)
 		aic23_power_up();
-- 
1.5.6.3

