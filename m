From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] mfd: twl4030: trivial code-style fixes
Date: Wed,  1 Feb 2012 03:02:48 +0200
Message-ID: <1328058168-28744-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:61582 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754272Ab2BABD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 20:03:29 -0500
Received: by lbom4 with SMTP id m4so91154lbo.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 17:03:27 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Jiri Kosina <trivial@kernel.org>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/mfd/twl4030-irq.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index b69bb51..b31f920 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -59,7 +59,6 @@
 #define REG_PIH_ISR_P2			0x02
 #define REG_PIH_SIR			0x03	/* for testing */
 
-
 /* Linux could (eventually) use either IRQ line */
 static int irq_line;
 
@@ -111,7 +110,8 @@ static int nr_sih_modules;
 #define TWL4030_MODULE_INT_PWR		TWL4030_MODULE_INT
 
 
-/* Order in this table matches order in PIH_ISR.  That is,
+/*
+ * Order in this table matches order in PIH_ISR.  That is,
  * BIT(n) in PIH_ISR is sih_modules[n].
  */
 /* sih_modules_twl4030 is used both in twl4030 and twl5030 */
@@ -309,6 +309,7 @@ static irqreturn_t handle_twl4030_pih(int irq, void *devid)
 
 	return IRQ_HANDLED;
 }
+
 /*----------------------------------------------------------------------*/
 
 /*
@@ -337,7 +338,6 @@ static int twl4030_init_sih_modules(unsigned line)
 	memset(buf, 0xff, sizeof buf);
 	sih = sih_modules;
 	for (i = 0; i < nr_sih_modules; i++, sih++) {
-
 		/* skip USB -- it's funky */
 		if (!sih->bytes_ixr)
 			continue;
@@ -352,7 +352,8 @@ static int twl4030_init_sih_modules(unsigned line)
 			pr_err("twl4030: err %d initializing %s %s\n",
 					status, sih->name, "IMR");
 
-		/* Maybe disable "exclusive" mode; buffer second pending irq;
+		/*
+		 * Maybe disable "exclusive" mode; buffer second pending irq;
 		 * set Clear-On-Read (COR) bit.
 		 *
 		 * NOTE that sometimes COR polarity is documented as being
@@ -382,7 +383,8 @@ static int twl4030_init_sih_modules(unsigned line)
 		if (sih->irq_lines <= line)
 			continue;
 
-		/* Clear pending interrupt status.  Either the read was
+		/*
+		 * Clear pending interrupt status.  Either the read was
 		 * enough, or we need to write those bits.  Repeat, in
 		 * case an IRQ is pending (PENDDIS=0) ... that's not
 		 * uncommon with PWR_INT.PWRON.
@@ -398,7 +400,8 @@ static int twl4030_init_sih_modules(unsigned line)
 				status = twl_i2c_write(sih->module, buf,
 					sih->mask[line].isr_offset,
 					sih->bytes_ixr);
-			/* else COR=1 means read sufficed.
+			/*
+			 * else COR=1 means read sufficed.
 			 * (for most SIH modules...)
 			 */
 		}
@@ -410,7 +413,8 @@ static int twl4030_init_sih_modules(unsigned line)
 static inline void activate_irq(int irq)
 {
 #ifdef CONFIG_ARM
-	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
+	/*
+	 * ARM requires an extra step to clear IRQ_NOREQUEST, which it
 	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
 	 */
 	set_irq_flags(irq, IRQF_VALID);
@@ -622,9 +626,7 @@ static irqreturn_t handle_twl4030_sih(int irq, void *data)
 
 static unsigned twl4030_irq_next;
 
-/* returns the first IRQ used by this SIH bank,
- * or negative errno
- */
+/* returns the first IRQ used by this SIH bank, or negative errno */
 int twl4030_sih_setup(int module)
 {
 	int			sih_mod;
@@ -688,7 +690,6 @@ int twl4030_sih_setup(int module)
 
 /* FIXME need a call to reverse twl4030_sih_setup() ... */
 
-
 /*----------------------------------------------------------------------*/
 
 /* FIXME pass in which interrupt line we'll use ... */
@@ -711,7 +712,8 @@ int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end)
 
 	twl4030_irq_base = irq_base;
 
-	/* install an irq handler for each of the SIH modules;
+	/*
+	 * install an irq handler for each of the SIH modules;
 	 * clone dummy irq_chip since PIH can't *do* anything
 	 */
 	twl4030_irq_chip = dummy_irq_chip;
-- 
1.7.9

