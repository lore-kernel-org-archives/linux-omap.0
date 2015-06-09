From: Rob Herring <robh@kernel.org>
Subject: [PATCH 09/15] mfd: kill off set_irq_flags usage
Date: Tue,  9 Jun 2015 13:26:35 -0500
Message-ID: <1433874401-27161-10-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35316 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbbFISeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2015 14:34:07 -0400
In-Reply-To: <1433874401-27161-1-git-send-email-robh@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, arm@kernel.org, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Milo Kim <milo.kim@ti.com>, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Tony Lindgren <tony@atomide.com>, patches@opensource.wolfsonmicro.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-omap@vger.kernel.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Milo Kim <milo.kim@ti.com>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Andy Gross <agross@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@opensource.wolfsonmicro.com
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/88pm860x-core.c |  4 ----
 drivers/mfd/ab8500-core.c   |  4 ----
 drivers/mfd/arizona-irq.c   |  7 -------
 drivers/mfd/asic3.c         |  4 ++--
 drivers/mfd/db8500-prcmu.c  |  1 -
 drivers/mfd/ezx-pcap.c      |  6 +-----
 drivers/mfd/htc-egpio.c     |  4 ++--
 drivers/mfd/htc-i2cpld.c    |  6 +-----
 drivers/mfd/lp8788-irq.c    |  5 -----
 drivers/mfd/max8925-core.c  |  5 +----
 drivers/mfd/max8997-irq.c   |  5 +----
 drivers/mfd/max8998-irq.c   |  5 +----
 drivers/mfd/mt6397-core.c   |  4 ----
 drivers/mfd/pm8921-core.c   |  5 +----
 drivers/mfd/rc5t583-irq.c   |  4 +---
 drivers/mfd/stmpe.c         |  7 -------
 drivers/mfd/t7l66xb.c       |  6 ------
 drivers/mfd/tc3589x.c       |  7 -------
 drivers/mfd/tc6393xb.c      |  4 ++--
 drivers/mfd/tps6586x.c      |  7 -------
 drivers/mfd/tps65912-irq.c  |  8 +-------
 drivers/mfd/twl4030-irq.c   | 11 +----------
 drivers/mfd/twl6030-irq.c   | 13 -------------
 drivers/mfd/ucb1x00-core.c  |  2 +-
 drivers/mfd/wm831x-irq.c    |  7 -------
 drivers/mfd/wm8350-irq.c    |  8 +-------
 drivers/mfd/wm8994-irq.c    |  7 -------
 27 files changed, 17 insertions(+), 139 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index d2a85cd..17984d65 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -558,11 +558,7 @@ static int pm860x_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	irq_set_chip_data(virq, d->host_data);
 	irq_set_chip_and_handler(virq, &pm860x_irq_chip, handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 	return 0;
 }
 
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index c80a292..24a159b 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -565,11 +565,7 @@ static int ab8500_irq_map(struct irq_domain *d, unsigned int virq,
 	irq_set_chip_and_handler(virq, &ab8500_irq_chip,
 				handle_simple_irq);
 	irq_set_nested_thread(virq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
diff --git a/drivers/mfd/arizona-irq.c b/drivers/mfd/arizona-irq.c
index d063b94..d32673d 100644
--- a/drivers/mfd/arizona-irq.c
+++ b/drivers/mfd/arizona-irq.c
@@ -174,14 +174,7 @@ static int arizona_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_data(virq, data);
 	irq_set_chip_and_handler(virq, &arizona_irq_chip, handle_simple_irq);
 	irq_set_nested_thread(virq, 1);
-
-	/* ARM needs us to explicitly flag the IRQ as valid
-	 * and will set them noprobe when we do so. */
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 977bd3a..54a133c 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -411,7 +411,7 @@ static int __init asic3_irq_probe(struct platform_device *pdev)
 
 		irq_set_chip_data(irq, asic);
 		irq_set_handler(irq, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	asic3_write_register(asic, ASIC3_OFFSET(INTR, INT_MASK),
@@ -432,7 +432,7 @@ static void asic3_irq_remove(struct platform_device *pdev)
 	irq_base = asic->irq_base;
 
 	for (irq = irq_base; irq < irq_base + ASIC3_NR_IRQS; irq++) {
-		set_irq_flags(irq, 0);
+		irq_set_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		irq_set_chip_and_handler(irq, NULL, NULL);
 		irq_set_chip_data(irq, NULL);
 	}
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index cc1a404..f533717 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2654,7 +2654,6 @@ static int db8500_irq_map(struct irq_domain *d, unsigned int virq,
 {
 	irq_set_chip_and_handler(virq, &prcmu_irq_chip,
 				handle_simple_irq);
-	set_irq_flags(virq, IRQF_VALID);
 
 	return 0;
 }
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 5991fad..19e55dd 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -463,11 +463,7 @@ static int ezx_pcap_probe(struct spi_device *spi)
 	for (i = pcap->irq_base; i < (pcap->irq_base + PCAP_NIRQS); i++) {
 		irq_set_chip_and_handler(i, &pcap_irq_chip, handle_simple_irq);
 		irq_set_chip_data(i, pcap);
-#ifdef CONFIG_ARM
-		set_irq_flags(i, IRQF_VALID);
-#else
-		irq_set_noprobe(i);
-#endif
+		irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	/* mask/ack all PCAP interrupts */
diff --git a/drivers/mfd/htc-egpio.c b/drivers/mfd/htc-egpio.c
index 49f39fe..c9d5e3f 100644
--- a/drivers/mfd/htc-egpio.c
+++ b/drivers/mfd/htc-egpio.c
@@ -350,7 +350,7 @@ static int __init egpio_probe(struct platform_device *pdev)
 			irq_set_chip_and_handler(irq, &egpio_muxed_chip,
 						 handle_simple_irq);
 			irq_set_chip_data(irq, ei);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 		irq_set_irq_type(ei->chained_irq, IRQ_TYPE_EDGE_RISING);
 		irq_set_handler_data(ei->chained_irq, ei);
@@ -376,7 +376,7 @@ static int __exit egpio_remove(struct platform_device *pdev)
 		irq_end = ei->irq_start + ei->nirqs;
 		for (irq = ei->irq_start; irq < irq_end; irq++) {
 			irq_set_chip_and_handler(irq, NULL, NULL);
-			set_irq_flags(irq, 0);
+			irq_set_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 		irq_set_chained_handler(ei->chained_irq, NULL);
 		device_init_wakeup(&pdev->dev, 0);
diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index ebb9cf1..0467c08 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -330,11 +330,7 @@ static int htcpld_setup_chip_irq(
 		irq_set_chip_and_handler(irq, &htcpld_muxed_chip,
 					 handle_simple_irq);
 		irq_set_chip_data(irq, chip);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-#else
-		irq_set_probe(irq);
-#endif
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	return ret;
diff --git a/drivers/mfd/lp8788-irq.c b/drivers/mfd/lp8788-irq.c
index 23982db..6476b4f 100644
--- a/drivers/mfd/lp8788-irq.c
+++ b/drivers/mfd/lp8788-irq.c
@@ -141,12 +141,7 @@ static int lp8788_irq_map(struct irq_domain *d, unsigned int virq,
 	irq_set_chip_data(virq, irqd);
 	irq_set_chip_and_handler(virq, chip, handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 97a787a..d755ef8 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -650,11 +650,8 @@ static int max8925_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	irq_set_chip_data(virq, d->host_data);
 	irq_set_chip_and_handler(virq, &max8925_irq_chip, handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
+
 	return 0;
 }
 
diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
index 43fa614..ce025b2f 100644
--- a/drivers/mfd/max8997-irq.c
+++ b/drivers/mfd/max8997-irq.c
@@ -295,11 +295,8 @@ static int max8997_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, max8997);
 	irq_set_chip_and_handler(irq, &max8997_irq_chip, handle_edge_irq);
 	irq_set_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
+
 	return 0;
 }
 
diff --git a/drivers/mfd/max8998-irq.c b/drivers/mfd/max8998-irq.c
index c469477..8a37cf1 100644
--- a/drivers/mfd/max8998-irq.c
+++ b/drivers/mfd/max8998-irq.c
@@ -206,11 +206,8 @@ static int max8998_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, max8998);
 	irq_set_chip_and_handler(irq, &max8998_irq_chip, handle_edge_irq);
 	irq_set_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
+
 	return 0;
 }
 
diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 09bc780..c076e48 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -121,11 +121,7 @@ static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, mt6397);
 	irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
 	irq_set_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
 
 	return 0;
 }
diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index 5a92646..8ef8d71 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -251,11 +251,8 @@ static int pm8xxx_irq_domain_map(struct irq_domain *d, unsigned int irq,
 
 	irq_set_chip_and_handler(irq, &pm8xxx_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, chip);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
+
 	return 0;
 }
 
diff --git a/drivers/mfd/rc5t583-irq.c b/drivers/mfd/rc5t583-irq.c
index bb85020..3f8812d 100644
--- a/drivers/mfd/rc5t583-irq.c
+++ b/drivers/mfd/rc5t583-irq.c
@@ -386,9 +386,7 @@ int rc5t583_irq_init(struct rc5t583 *rc5t583, int irq, int irq_base)
 		irq_set_chip_and_handler(__irq, &rc5t583_irq_chip,
 					 handle_simple_irq);
 		irq_set_nested_thread(__irq, 1);
-#ifdef CONFIG_ARM
-		set_irq_flags(__irq, IRQF_VALID);
-#endif
+		irq_clear_status_flags(__irq, IRQ_NOREQUEST);
 	}
 
 	ret = request_threaded_irq(irq, NULL, rc5t583_irq, IRQF_ONESHOT,
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 2d7fae9..ef3edd7 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -971,20 +971,13 @@ static int stmpe_irq_map(struct irq_domain *d, unsigned int virq,
 	irq_set_chip_data(virq, stmpe);
 	irq_set_chip_and_handler(virq, chip, handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
 
 static void stmpe_irq_unmap(struct irq_domain *d, unsigned int virq)
 {
-#ifdef CONFIG_ARM
-		set_irq_flags(virq, 0);
-#endif
 		irq_set_chip_and_handler(virq, NULL, NULL);
 		irq_set_chip_data(virq, NULL);
 }
diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index c09fb5d..01af111 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -246,9 +246,6 @@ static void t7l66xb_attach_irq(struct platform_device *dev)
 	for (irq = irq_base; irq < irq_base + T7L66XB_NR_IRQS; irq++) {
 		irq_set_chip_and_handler(irq, &t7l66xb_chip, handle_level_irq);
 		irq_set_chip_data(irq, t7l66xb);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-#endif
 	}
 
 	irq_set_irq_type(t7l66xb->irq, IRQ_TYPE_EDGE_FALLING);
@@ -267,9 +264,6 @@ static void t7l66xb_detach_irq(struct platform_device *dev)
 	irq_set_handler_data(t7l66xb->irq, NULL);
 
 	for (irq = irq_base; irq < irq_base + T7L66XB_NR_IRQS; irq++) {
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, 0);
-#endif
 		irq_set_chip(irq, NULL);
 		irq_set_chip_data(irq, NULL);
 	}
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index cf35639..e7d14e5 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -215,20 +215,13 @@ static int tc3589x_irq_map(struct irq_domain *d, unsigned int virq,
 	irq_set_chip_and_handler(virq, &dummy_irq_chip,
 				handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
 
 static void tc3589x_irq_unmap(struct irq_domain *d, unsigned int virq)
 {
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, 0);
-#endif
 	irq_set_chip_and_handler(virq, NULL, NULL);
 	irq_set_chip_data(virq, NULL);
 }
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 63458b3..c108472 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -586,7 +586,7 @@ static void tc6393xb_attach_irq(struct platform_device *dev)
 	for (irq = irq_base; irq < irq_base + TC6393XB_NR_IRQS; irq++) {
 		irq_set_chip_and_handler(irq, &tc6393xb_chip, handle_edge_irq);
 		irq_set_chip_data(irq, tc6393xb);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	irq_set_irq_type(tc6393xb->irq, IRQ_TYPE_EDGE_FALLING);
@@ -605,7 +605,7 @@ static void tc6393xb_detach_irq(struct platform_device *dev)
 	irq_base = tc6393xb->irq_base;
 
 	for (irq = irq_base; irq < irq_base + TC6393XB_NR_IRQS; irq++) {
-		set_irq_flags(irq, 0);
+		irq_set_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		irq_set_chip(irq, NULL);
 		irq_set_chip_data(irq, NULL);
 	}
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 8e1dbc4..a4f0251 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -299,14 +299,7 @@ static int tps6586x_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_data(virq, tps6586x);
 	irq_set_chip_and_handler(virq, &tps6586x_irq_chip, handle_simple_irq);
 	irq_set_nested_thread(virq, 1);
-
-	/* ARM needs us to explicitly flag the IRQ as valid
-	 * and will set them noprobe when we do so. */
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
diff --git a/drivers/mfd/tps65912-irq.c b/drivers/mfd/tps65912-irq.c
index fbecec7..db2c29cb 100644
--- a/drivers/mfd/tps65912-irq.c
+++ b/drivers/mfd/tps65912-irq.c
@@ -197,13 +197,7 @@ int tps65912_irq_init(struct tps65912 *tps65912, int irq,
 		irq_set_chip_and_handler(cur_irq, &tps65912_irq_chip,
 					 handle_edge_irq);
 		irq_set_nested_thread(cur_irq, 1);
-		/* ARM needs us to explicitly flag the IRQ as valid
-		 * and will set them noprobe when we do so. */
-#ifdef CONFIG_ARM
-		set_irq_flags(cur_irq, IRQF_VALID);
-#else
-		irq_set_noprobe(cur_irq);
-#endif
+		irq_clear_status_flags(cur_irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	ret = request_threaded_irq(irq, NULL, tps65912_irq, flags,
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 1b772ef..7c36fc0 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -419,16 +419,7 @@ static int twl4030_init_sih_modules(unsigned line)
 
 static inline void activate_irq(int irq)
 {
-#ifdef CONFIG_ARM
-	/*
-	 * ARM requires an extra step to clear IRQ_NOREQUEST, which it
-	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
-	 */
-	set_irq_flags(irq, IRQF_VALID);
-#else
-	/* same effect on other architectures */
-	irq_set_noprobe(irq);
-#endif
+	irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 }
 
 /*----------------------------------------------------------------------*/
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 2807e1a..f7ea098 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -352,26 +352,13 @@ static int twl6030_irq_map(struct irq_domain *d, unsigned int virq,
 	irq_set_chip_and_handler(virq,  &pdata->irq_chip, handle_simple_irq);
 	irq_set_nested_thread(virq, true);
 	irq_set_parent(virq, pdata->twl_irq);
-
-#ifdef CONFIG_ARM
-	/*
-	 * ARM requires an extra step to clear IRQ_NOREQUEST, which it
-	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
-	 */
-	set_irq_flags(virq, IRQF_VALID);
-#else
-	/* same effect on other architectures */
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
 
 static void twl6030_irq_unmap(struct irq_domain *d, unsigned int virq)
 {
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, 0);
-#endif
 	irq_set_chip_and_handler(virq, NULL, NULL);
 	irq_set_chip_data(virq, NULL);
 }
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 58ea9fd..c706ead 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -562,7 +562,7 @@ static int ucb1x00_probe(struct mcp *mcp)
 
 		irq_set_chip_and_handler(irq, &ucb1x00_irqchip, handle_edge_irq);
 		irq_set_chip_data(irq, ucb);
-		set_irq_flags(irq, IRQF_VALID | IRQ_NOREQUEST);
+		irq_clear_status_flags(irq, IRQ_NOREQUEST);
 	}
 
 	irq_set_irq_type(ucb->irq, IRQ_TYPE_EDGE_RISING);
diff --git a/drivers/mfd/wm831x-irq.c b/drivers/mfd/wm831x-irq.c
index 64e512e..0edf213 100644
--- a/drivers/mfd/wm831x-irq.c
+++ b/drivers/mfd/wm831x-irq.c
@@ -552,14 +552,7 @@ static int wm831x_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_data(virq, h->host_data);
 	irq_set_chip_and_handler(virq, &wm831x_irq_chip, handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-
-	/* ARM needs us to explicitly flag the IRQ as valid
-	 * and will set them noprobe when we do so. */
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
diff --git a/drivers/mfd/wm8350-irq.c b/drivers/mfd/wm8350-irq.c
index 813ff50..27054f3 100644
--- a/drivers/mfd/wm8350-irq.c
+++ b/drivers/mfd/wm8350-irq.c
@@ -526,13 +526,7 @@ int wm8350_irq_init(struct wm8350 *wm8350, int irq,
 					 handle_edge_irq);
 		irq_set_nested_thread(cur_irq, 1);
 
-		/* ARM needs us to explicitly flag the IRQ as valid
-		 * and will set them noprobe when we do so. */
-#ifdef CONFIG_ARM
-		set_irq_flags(cur_irq, IRQF_VALID);
-#else
-		irq_set_noprobe(cur_irq);
-#endif
+		irq_clear_status_flags(cur_irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	ret = request_threaded_irq(irq, NULL, wm8350_irq, flags,
diff --git a/drivers/mfd/wm8994-irq.c b/drivers/mfd/wm8994-irq.c
index a14407e..6dbf108 100644
--- a/drivers/mfd/wm8994-irq.c
+++ b/drivers/mfd/wm8994-irq.c
@@ -172,14 +172,7 @@ static int wm8994_edge_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_data(virq, wm8994);
 	irq_set_chip_and_handler(virq, &wm8994_edge_irq_chip, handle_edge_irq);
 	irq_set_nested_thread(virq, 1);
-
-	/* ARM needs us to explicitly flag the IRQ as valid
-	 * and will set them noprobe when we do so. */
-#ifdef CONFIG_ARM
-	set_irq_flags(virq, IRQF_VALID);
-#else
 	irq_set_noprobe(virq);
-#endif
 
 	return 0;
 }
-- 
2.1.0

