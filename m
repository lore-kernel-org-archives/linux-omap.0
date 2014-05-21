From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] mfd: twl4030-power: Fix some defines for SW_EVENTS
Date: Tue, 20 May 2014 19:33:16 -0700
Message-ID: <20140521023316.GA17417@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-3-git-send-email-tony@atomide.com>
 <20140520150358.GX24991@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49643 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaEUCdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 22:33:21 -0400
Content-Disposition: inline
In-Reply-To: <20140520150358.GX24991@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Lee Jones <lee.jones@linaro.org> [140520 08:04]:
> > We have these bits partially defined in two different
> > places, so let's fix them up and add defines for the
> > missing bits. These bits are the same for P1_SW_EVENTS,
> > P2_SW_EVENTS and P3_SW_EVENTS.
> > 
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/mfd/twl4030-power.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> > index 1b30d8a..c0e4fc3 100644
> > --- a/drivers/mfd/twl4030-power.c
> > +++ b/drivers/mfd/twl4030-power.c
> > @@ -35,7 +35,14 @@
> >  static u8 twl4030_start_script_address = 0x2b;
> >  
> >  #define PWR_P1_SW_EVENTS	0x10
> 
> BIT(4)?

Seems actually unused to so removed.
 
> > +#define PWR_STOPON_PRWON	(1 << 6)
> > +#define PWR_STOPON_SYSEN	(1 << 5)
> > +#define PWR_ENABLE_WARMRESET	(1 << 4)
> > +#define PWR_LVL_WAKEUP		(1 << 3)
> > +#define PWR_DEVACT		(1 << 2)
> > +#define PWR_DEVSLP		(1 << 1)
> >  #define PWR_DEVOFF		(1 << 0)
> > +
> >  #define SEQ_OFFSYNC		(1 << 0)
> 
> Please use the BIT() macro for these.
> 
> [...]
> 
> Once fixed, apply my Acked-by on re-submission.

OK updated patch below with your ack added.

Regards,

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 20 May 2014 11:17:53 -0700
Subject: [PATCH] mfd: twl4030-power: Fix some defines for SW_EVENTS

We have these bits partially defined in two different
places, so let's fix them up and add defines for the
missing bits. These bits are the same for P1_SW_EVENTS,
P2_SW_EVENTS and P3_SW_EVENTS.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -34,8 +34,15 @@
 
 static u8 twl4030_start_script_address = 0x2b;
 
-#define PWR_P1_SW_EVENTS	0x10
-#define PWR_DEVOFF		(1 << 0)
+/* Register bits for P1, P2 and P3_SW_EVENTS */
+#define PWR_STOPON_PRWON	BIT(6)
+#define PWR_STOPON_SYSEN	BIT(5)
+#define PWR_ENABLE_WARMRESET	BIT(4)
+#define PWR_LVL_WAKEUP		BIT(3)
+#define PWR_DEVACT		BIT(2)
+#define PWR_DEVSLP		BIT(1)
+#define PWR_DEVOFF		BIT(0)
+
 #define SEQ_OFFSYNC		(1 << 0)
 
 #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
@@ -52,10 +59,6 @@ static u8 twl4030_start_script_address = 0x2b;
 #define R_CFG_P2_TRANSITION	PHY_TO_OFF_PM_MASTER(0x37)
 #define R_CFG_P3_TRANSITION	PHY_TO_OFF_PM_MASTER(0x38)
 
-#define LVL_WAKEUP	0x08
-
-#define ENABLE_WARMRESET (1<<4)
-
 #define END_OF_SCRIPT		0x3f
 
 #define R_SEQ_ADD_A2S		PHY_TO_OFF_PM_MASTER(0x55)
@@ -196,7 +199,7 @@ static int twl4030_config_wakeup3_sequence(u8 address)
 	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &data, R_P3_SW_EVENTS);
 	if (err)
 		goto out;
-	data |= LVL_WAKEUP;
+	data |= PWR_LVL_WAKEUP;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data, R_P3_SW_EVENTS);
 out:
 	if (err)
@@ -219,7 +222,7 @@ static int twl4030_config_wakeup12_sequence(u8 address)
 	if (err)
 		goto out;
 
-	data |= LVL_WAKEUP;
+	data |= PWR_LVL_WAKEUP;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data, R_P1_SW_EVENTS);
 	if (err)
 		goto out;
@@ -228,7 +231,7 @@ static int twl4030_config_wakeup12_sequence(u8 address)
 	if (err)
 		goto out;
 
-	data |= LVL_WAKEUP;
+	data |= PWR_LVL_WAKEUP;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, data, R_P2_SW_EVENTS);
 	if (err)
 		goto out;
@@ -281,7 +284,7 @@ static int twl4030_config_warmreset_sequence(u8 address)
 	if (err)
 		goto out;
 
-	rd_data |= ENABLE_WARMRESET;
+	rd_data |= PWR_ENABLE_WARMRESET;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, rd_data, R_P1_SW_EVENTS);
 	if (err)
 		goto out;
@@ -290,7 +293,7 @@ static int twl4030_config_warmreset_sequence(u8 address)
 	if (err)
 		goto out;
 
-	rd_data |= ENABLE_WARMRESET;
+	rd_data |= PWR_ENABLE_WARMRESET;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, rd_data, R_P2_SW_EVENTS);
 	if (err)
 		goto out;
@@ -299,7 +302,7 @@ static int twl4030_config_warmreset_sequence(u8 address)
 	if (err)
 		goto out;
 
-	rd_data |= ENABLE_WARMRESET;
+	rd_data |= PWR_ENABLE_WARMRESET;
 	err = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, rd_data, R_P3_SW_EVENTS);
 out:
 	if (err)
