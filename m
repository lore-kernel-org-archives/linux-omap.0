From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Convert devdata to drvdata in rtc-omap.c
Date: Sat, 19 May 2007 16:45:15 +0200
Message-ID: <464F0D7B.5040600@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090402000709030207080603"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090402000709030207080603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Convert devdata to drvdata in rtc-omap.c to make this compile again.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------090402000709030207080603
Content-Type: text/plain;
 name="fix_devdata_rtc_omap.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_devdata_rtc_omap.txt"

Index: linux-osk/drivers/rtc/rtc-omap.c
===================================================================
--- linux-osk.orig/drivers/rtc/rtc-omap.c
+++ linux-osk/drivers/rtc/rtc-omap.c
@@ -371,7 +371,7 @@ static int __devinit omap_rtc_probe(stru
 		goto fail;
 	}
 	platform_set_drvdata(pdev, rtc);
-	dev_set_devdata(&rtc->dev, mem);
+	dev_set_drvdata(&rtc->dev, mem);
 
 	/* clear pending irqs, and set 1/second periodic,
 	 * which we'll use instead of update irqs
@@ -453,7 +453,7 @@ static int __devexit omap_rtc_remove(str
 	free_irq(omap_rtc_timer, rtc);
 	free_irq(omap_rtc_alarm, rtc);
 
-	release_resource(dev_get_devdata(&rtc->dev));
+	release_resource(dev_get_drvdata(&rtc->dev));
 	rtc_device_unregister(rtc);
 	return 0;
 }

--------------090402000709030207080603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090402000709030207080603--
