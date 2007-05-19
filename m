From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Convert some SA interrupt flags to IRQF
Date: Sat, 19 May 2007 16:40:22 +0200
Message-ID: <464F0C56.7040808@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070807060408080208000104"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070807060408080208000104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Convert some SA* interrupt flags to IRQF*

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------070807060408080208000104
Content-Type: text/plain;
 name="convert_sa_to_irqf_interrupt_flag.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="convert_sa_to_irqf_interrupt_flag.txt"

Index: linux-osk/drivers/input/keyboard/tsc2301_kp.c
===================================================================
--- linux-osk.orig/drivers/input/keyboard/tsc2301_kp.c
+++ linux-osk/drivers/input/keyboard/tsc2301_kp.c
@@ -515,7 +515,7 @@ int __devinit tsc2301_kp_init(struct tsc
 
 	set_irq_type(kp->irq, IRQT_FALLING);
 
-	r = request_irq(kp->irq, tsc2301_kp_irq_handler, SA_SAMPLE_RANDOM,
+	r = request_irq(kp->irq, tsc2301_kp_irq_handler, IRQF_SAMPLE_RANDOM,
 			"tsc2301-kp", tsc);
 	if (r < 0) {
 		dev_err(&tsc->spi->dev, "unable to get kbirq IRQ");
Index: linux-osk/drivers/input/touchscreen/tsc2301_ts.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/tsc2301_ts.c
+++ linux-osk/drivers/input/touchscreen/tsc2301_ts.c
@@ -621,7 +621,7 @@ int __devinit tsc2301_ts_init(struct tsc
 
 	ts->irq_enabled = 1;
 	r = request_irq(ts->irq, tsc2301_ts_irq_handler,
-			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
+			IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING,
 			"tsc2301-ts", tsc);
 	if (r < 0) {
 		dev_err(&tsc->spi->dev, "unable to get DAV IRQ");
Index: linux-osk/drivers/mtd/onenand/omap2.c
===================================================================
--- linux-osk.orig/drivers/mtd/onenand/omap2.c
+++ linux-osk/drivers/mtd/onenand/omap2.c
@@ -352,7 +352,7 @@ static int __devinit omap2_onenand_probe
 	omap_set_gpio_direction(info->gpio_irq, 1);
 
 	if ((r = request_irq(OMAP_GPIO_IRQ(info->gpio_irq),
-			     omap2_onenand_interrupt, SA_TRIGGER_RISING,
+			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
 			     pdev->dev.driver->name, info)) < 0)
 		goto err_release_gpio;
 


--------------070807060408080208000104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070807060408080208000104--
