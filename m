From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 21/23] twl4030-core: portability updates
Date: Mon, 29 Sep 2008 17:31:46 -0700
Message-ID: <200809291731.46901.david-b@pacbell.net>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <1222707783-18936-21-git-send-email-me@felipebalbi.com> <1222707783-18936-22-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:40841 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752307AbYI3Abt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 20:31:49 -0400
In-Reply-To: <1222707783-18936-22-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Similar fix needs merging into patch 21 too.

--- beagle.orig/drivers/i2c/chips/twl4030-core.c	2008-09-29 17:21:37.000000000 -0700
+++ beagle/drivers/i2c/chips/twl4030-core.c	2008-09-29 17:21:25.000000000 -0700
@@ -75,6 +75,19 @@
 #define twl_has_usb()	false
 #endif
 
+static inline void activate_irq(int irq)
+{
+#ifdef CONFIG_ARM
+	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
+	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
+	 */
+	set_irq_flags(irq, IRQF_VALID);
+#else
+	/* same effect on other architectures */
+	set_irq_noprobe(irq);
+#endif
+}
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -1052,9 +1065,9 @@ static void twl_init_irq(int irq_num, un
 
 	/* install an irq handler for each of the PIH modules */
 	for (i = irq_base; i < irq_end; i++) {
-		set_irq_noprobe(i);
 		set_irq_chip_and_handler(i, &twl4030_irq_chip,
 				do_twl4030_module_irq);
+		activate_irq(i);
 	}
 
 	/* install an irq handler to demultiplex the TWL4030 interrupt */
