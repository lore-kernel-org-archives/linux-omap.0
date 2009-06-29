From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: RE: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to support off-mode
Date: Mon, 29 Jun 2009 16:51:51 +0800
Message-ID: <F12CE1A68F023D498A2691C7B5393115035F09BD@ZMY16EXM66.ds.mot.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com><1245965646-20070-2-git-send-email-khilman@deeprootsystems.com><1245965646-20070-3-git-send-email-khilman@deeprootsystems.com><1245965646-20070-4-git-send-email-khilman@deeprootsystems.com><1245965646-20070-5-git-send-email-khilman@deeprootsystems.com><4A44AD44.4070107@nokia.com> <87bpobjcx6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:7564 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZF2IwP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 04:52:15 -0400
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate5.mot.com (8.14.3/8.14.3) with ESMTP id n5T8qHMD002704
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 01:52:17 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id n5T8qHIJ011514
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 03:52:17 -0500 (CDT)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id n5T8qFIh011494
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 03:52:16 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87bpobjcx6.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

I think we also need extra patch for fixing stability issue.

Sometimes after back from retention/off mode, OMAP3430 I2C controller
stops working even all register settings are restored.

OMAP3430 TRM says: "During active mode (I2Ci.I2C_CON[15] I2C_EN bit is
set to 1), make no changes to the I2Ci.I2C_SCLL and I2Ci.I2C_SCLH
registers. 
Changes may result in unpredictable behavior."


diff --git a/drivers/i2c/busses/i2c-omap.c
b/drivers/i2c/busses/i2c-omap.c index 5ce055c..b084209 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -238,12 +238,14 @@ static void omap_i2c_unidle(struct omap_i2c_dev
*dev)
 		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
 	if (cpu_is_omap34xx()) {
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG,
dev->pscstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG,
dev->scllstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG,
dev->sclhstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
dev->bufstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
dev->syscstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
OMAP_I2C_CON_EN);
 	}
 	dev->idle = 0;
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);

-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
Sent: Friday, June 26, 2009 10:19 PM
To: Aaro Koskinen
Cc: linux-omap@vger.kernel.org; Rajendra Nayak; Hogander Jouni
(Nokia-D/Tampere); Jagadeesh Bhaskar Pakaravoor
Subject: Re: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to
support off-mode

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Kevin Hilman wrote:
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> Because of OMAP off-mode, powerdomain can go off when I2C is idle.
>> Save enough state, and do a re-init for each transfer.
>>
>> Additional save/restore state added by Jagadeesh Bhaskar Pakaravoor
>> (SYSC_REG) and Aaro Koskinen (wakeup sources.)
>>
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
>> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> This patch introduces a compiler warning:
>
>   CC      drivers/i2c/busses/i2c-omap.o
> drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_init':
> drivers/i2c/busses/i2c-omap.c:303: warning: unused variable 'v'
>
> So the declaration of "v" should be also removed here:
>

Thanks, updated patch in my queue an below for reference.

Kevin

>From 6880534c0a42beea0e500a566f910875342c313b Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 26 Sep 2008 17:48:07 +0530
Subject: [PATCH] I2C: OMAP3: PM: (re)init for every transfer to support
off-mode

Because of OMAP off-mode, powerdomain can go off when I2C is idle.
Save enough state, and do a re-init for each transfer.

Additional save/restore state added by Jagadeesh Bhaskar Pakaravoor
(SYSC_REG) and Aaro Koskinen (wakeup sources.)

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/i2c/busses/i2c-omap.c |   62
+++++++++++++++++++++++++---------------
 1 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c
b/drivers/i2c/busses/i2c-omap.c index ece0125..6b28e8a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -178,6 +178,12 @@ struct omap_i2c_dev {
 	unsigned		b_hw:1;		/* bad h/w fixes */
 	unsigned		idle:1;
 	u16			iestate;	/* Saved interrupt
register */
+	u16			pscstate;
+	u16			scllstate;
+	u16			sclhstate;
+	u16			bufstate;
+	u16			syscstate;
+	u16			westate;
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev, @@
-230,9 +236,16 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 
 	clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
+	if (cpu_is_omap34xx()) {
+		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG,
dev->pscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG,
dev->scllstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG,
dev->sclhstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
dev->bufstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
dev->syscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+	}
 	dev->idle = 0;
-	if (dev->iestate)
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
 }
 
 static void omap_i2c_idle(struct omap_i2c_dev *dev) @@ -258,7 +271,7 @@
static void omap_i2c_idle(struct omap_i2c_dev *dev)
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)  {
-	u16 psc = 0, scll = 0, sclh = 0;
+	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
 	unsigned long timeout;
@@ -287,24 +300,22 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 					   SYSC_AUTOIDLE_MASK);
 
 		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
-			u32 v;
-
-			v = SYSC_AUTOIDLE_MASK;
-			v |= SYSC_ENAWAKEUP_MASK;
-			v |= (SYSC_IDLEMODE_SMART <<
+			dev->syscstate = SYSC_AUTOIDLE_MASK;
+			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
+			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
 			      __ffs(SYSC_SIDLEMODE_MASK));
-			v |= (SYSC_CLOCKACTIVITY_FCLK <<
+			dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
 			      __ffs(SYSC_CLOCKACTIVITY_MASK));
 
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);
+			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
+							dev->syscstate);
 			/*
 			 * Enabling all wakup sources to stop I2C
freezing on
 			 * WFI instruction.
 			 * REVISIT: Some wkup sources might not be
needed.
 			 */
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-
OMAP_I2C_WE_ALL);
-
+			dev->westate = OMAP_I2C_WE_ALL;
+			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
dev->westate);
 		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0); @@ -373,23 +384,28
@@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
 	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
 
-	if (dev->fifo_size)
-		/* Note: setup required fifo size - 1 */
-		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
-					(dev->fifo_size - 1) << 8 | /*
RTRSH */
-					OMAP_I2C_BUF_RXFIF_CLR |
-					(dev->fifo_size - 1) | /* XTRSH
*/
-					OMAP_I2C_BUF_TXFIF_CLR);
+	if (dev->fifo_size) {
+		/* Note: setup required fifo size - 1. RTRSH and XTRSH
*/
+		buf = (dev->fifo_size - 1) << 8 | OMAP_I2C_BUF_RXFIF_CLR
|
+			(dev->fifo_size - 1) | OMAP_I2C_BUF_TXFIF_CLR;
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
+	}
 
 	/* Take the I2C module out of reset: */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
 	/* Enable interrupts */
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG,
-			(OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
+	dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
 			OMAP_I2C_IE_ARDY | OMAP_I2C_IE_NACK |
 			OMAP_I2C_IE_AL)  | ((dev->fifo_size) ?
-				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) :
0));
+				(OMAP_I2C_IE_RDR | OMAP_I2C_IE_XDR) :
0);
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+	if (cpu_is_omap34xx()) {
+		dev->pscstate = psc;
+		dev->scllstate = scll;
+		dev->sclhstate = sclh;
+		dev->bufstate = buf;
+	}
 	return 0;
 }
 
--
1.6.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org More majordomo info
at  http://vger.kernel.org/majordomo-info.html
