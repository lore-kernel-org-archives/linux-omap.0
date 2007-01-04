From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Workqueue changes for retu-rtc
Date: Thu, 04 Jan 2007 17:38:37 +0100
Message-ID: <459D2D8D.1060705@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090308030804050709020200"
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
--------------090308030804050709020200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Workqueue changes for retu-rtc.c

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------090308030804050709020200
Content-Type: text/plain;
 name="retu_rtc_fixes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="retu_rtc_fixes.txt"

Index: linux-osk/drivers/cbus/retu-rtc.c
===================================================================
--- linux-osk.orig/drivers/cbus/retu-rtc.c
+++ linux-osk/drivers/cbus/retu-rtc.c
@@ -40,6 +40,7 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 
 #include "cbus.h"
 #include "retu.h"
@@ -312,13 +313,13 @@ static void retu_rtca_disable(void)
 	retu_write_reg(RETU_REG_RTCHMAR, (24 << 8) | 60);
 }
 
-static void retu_rtca_expired(void *data)
+static void retu_rtca_expired(struct work_struct *unused)
 {
 	retu_rtca_disable();
 	sysfs_notify(&retu_rtc_driver.kobj, NULL, "alarm_expired");
 }
 
-DECLARE_WORK(retu_rtca_work, retu_rtca_expired, NULL);
+DECLARE_WORK(retu_rtca_work, retu_rtca_expired);
 
 /*
  * RTCHMR RTCHMAR RTCCAL must be accessed within 0.9 s since the seconds


--------------090308030804050709020200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090308030804050709020200--
