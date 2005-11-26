From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] omap-rtc: Use platform_get_irq
Date: Sat, 26 Nov 2005 03:27:34 -0800 (PST)
Message-ID: <20051126112734.79390.qmail@web32902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-650525687-1133004454=:78645"
Content-Transfer-Encoding: 8bit
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

--0-650525687-1133004454=:78645
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch uses platform_get_irq for alarm and timer interrupts.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
--0-650525687-1133004454=:78645
Content-Type: text/plain; name="rtcplatirq.patch"
Content-Description: 1734803923-rtcplatirq.patch
Content-Disposition: inline; filename="rtcplatirq.patch"

diff --git a/drivers/char/omap-rtc.c b/drivers/char/omap-rtc.c
index 814b614..63ad322 100644
--- a/drivers/char/omap-rtc.c
+++ b/drivers/char/omap-rtc.c
@@ -71,6 +71,9 @@
 
 extern spinlock_t rtc_lock;
 
+static int omap_rtc_alarm = NO_IRQ;
+static int omap_rtc_timer = NO_IRQ;
+
 
 /* OMAP RTC register access macros: */
 
@@ -441,6 +444,20 @@ static int __init omap_rtc_probe(struct 
 	struct platform_device	*pdev = to_platform_device(dev);
 	struct resource		*res, *mem;
 
+	/* find the IRQs */
+
+	omap_rtc_timer = platform_get_irq(pdev, 0);
+	if (omap_rtc_timer <= 0) {
+		dev_err(&pdev->dev, "no irq for rtc timer\n");
+		return -ENOENT;
+	}
+
+	omap_rtc_alarm = platform_get_irq(pdev, 1);
+	if (omap_rtc_alarm <= 0) {
+		dev_err(&pdev->dev, "no irq for alarm\n");
+		return -ENOENT;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
 		mem = request_mem_region(res->start,
@@ -469,18 +486,18 @@ static int __init omap_rtc_probe(struct 
 		CMOS_WRITE(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
 	}
 
-	if (request_irq(INT_RTC_TIMER, rtc_interrupt, SA_INTERRUPT,
+	if (request_irq(omap_rtc_timer, rtc_interrupt, SA_INTERRUPT,
 			pdev->name, NULL)) {
 		pr_debug("%s: RTC timer interrupt IRQ%d is not free.\n",
-			pdev->name, INT_RTC_TIMER);
+			pdev->name, omap_rtc_timer);
 		goto fail;
 	}
 
-	if (request_irq(INT_RTC_ALARM, rtc_interrupt, SA_INTERRUPT,
+	if (request_irq(omap_rtc_alarm, rtc_interrupt, SA_INTERRUPT,
 			pdev->name, NULL)) {
 		pr_debug("%s: RTC alarm interrupt IRQ%d is not free.\n",
-			pdev->name, INT_RTC_ALARM);
-		free_irq(INT_RTC_TIMER, NULL);
+			pdev->name, omap_rtc_alarm);
+		free_irq(omap_rtc_timer, NULL);
 		goto fail;
 	}
 
@@ -504,8 +521,8 @@ fail:
 
 static int __exit omap_rtc_remove(struct device *dev)
 {
-	free_irq (INT_RTC_TIMER, NULL);
-	free_irq (INT_RTC_ALARM, NULL);
+	free_irq (omap_rtc_timer, NULL);
+	free_irq (omap_rtc_alarm, NULL);
 
 	remove_proc_entry ("driver/rtc", NULL);
 	misc_deregister(&rtc_dev);

--0-650525687-1133004454=:78645
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--0-650525687-1133004454=:78645--
