From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: retu-rtc: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:39:46 -0800 (PST)
Message-ID: <20060324133946.47252.qmail@web32903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1021589137-1143207586=:45761"
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

--0-1021589137-1143207586=:45761
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 
 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1021589137-1143207586=:45761
Content-Type: text/plain; name="0004-OMAP-retu-rtc-sem2mutex-conversion.txt"
Content-Description: 3544559991-0004-OMAP-retu-rtc-sem2mutex-conversion.txt
Content-Disposition: inline;
	filename="0004-OMAP-retu-rtc-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: retu-rtc: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/cbus/retu-rtc.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

008b3a3490221a17b138fd01241cc1772a712c0b
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 6471e7e..cb69804 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -39,12 +39,12 @@
 #include <linux/module.h>
 #include <linux/completion.h>
 #include <linux/platform_device.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include "cbus.h"
 #include "retu.h"
 
-static struct semaphore retu_rtc_sem;
+static struct mutex retu_rtc_mutex;
 static u16 retu_rtc_alarm_expired;
 static u16 retu_rtc_reset_occurred;
 
@@ -63,7 +63,7 @@ static ssize_t retu_rtc_time_show(struct
 {
 	u16 dsr, hmr, dsr2;
 
-	down(&retu_rtc_sem);
+	mutex_lock(&retu_rtc_mutex);
 
 	do {
 		u16 dummy;
@@ -82,7 +82,7 @@ static ssize_t retu_rtc_time_show(struct
 		dsr2	= retu_read_reg(RETU_REG_RTCDSR);
 	} while ((dsr != dsr2));
 
-	up(&retu_rtc_sem);
+	mutex_unlock(&retu_rtc_mutex);
 
 	/*
 	 * Format a 32-bit date-string for userspace
@@ -104,7 +104,7 @@ static ssize_t retu_rtc_time_show(struct
 static ssize_t retu_rtc_time_store(struct device *dev, struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	down(&retu_rtc_sem);
+	mutex_lock(&retu_rtc_mutex);
 	/*
 	 * Writing anything to the day counter forces it to 0
 	 * The seconds counter would be cleared by resetting the minutes counter,
@@ -117,7 +117,7 @@ static ssize_t retu_rtc_time_store(struc
 	retu_write_reg(RETU_REG_RTCDSR,
 		       retu_read_reg(RETU_REG_RTCDSR) & (1 << 6));
 
-	up(&retu_rtc_sem);
+	mutex_unlock(&retu_rtc_mutex);
 
 	return count;
 }
@@ -167,12 +167,12 @@ static ssize_t retu_rtc_reset_store(stru
 
 	if(sscanf(buf, "%u", &choice) != 1)
 		return count;
-	down(&retu_rtc_sem);
+	mutex_lock(&retu_rtc_mutex);
 	if (choice == 0)
 		retu_rtc_reset_occurred = 0;
 	else if (choice == 1)
 		retu_rtc_do_reset();
-	up(&retu_rtc_sem);
+	mutex_unlock(&retu_rtc_mutex);
 	return count;
 }
 
@@ -185,7 +185,7 @@ static ssize_t retu_rtc_alarm_show(struc
 	u16 chmar;
 	ssize_t retval;
 
-	down(&retu_rtc_sem);
+	mutex_lock(&retu_rtc_mutex);
 	/*
 	 * Format a 16-bit date-string for userspace
 	 *
@@ -195,7 +195,7 @@ static ssize_t retu_rtc_alarm_show(struc
 	chmar = retu_read_reg(RETU_REG_RTCHMAR);
 	/* No shifting needed, only masking unrelated bits */
 	retval = sprintf(buf, "0x%04x\n", chmar & 0x1f3f);
-	up(&retu_rtc_sem);
+	mutex_unlock(&retu_rtc_mutex);
 
 	return retval;
 }
@@ -208,7 +208,7 @@ static ssize_t retu_rtc_alarm_store(stru
 	unsigned hours;
 	unsigned minutes;
 
-	down(&retu_rtc_sem);
+	mutex_lock(&retu_rtc_mutex);
 
 	if(sscanf(buf, "%x", &alrm) != 1)
 		return count;
@@ -233,7 +233,7 @@ static ssize_t retu_rtc_alarm_store(stru
 			/* enable the interrupt */
 			retu_enable_irq(RETU_INT_RTCA);
 	}
-	up(&retu_rtc_sem);
+	mutex_unlock(&retu_rtc_mutex);
 
 	return count;
 }
@@ -268,9 +268,9 @@ static ssize_t retu_rtc_cal_show(struct 
 {
 	u16 rtccalr1;
 
-	down(&retu_rtc_sem);
+	mutex_lock(&retu_rtc_mutex);
 	rtccalr1 = retu_read_reg(RETU_REG_RTCCALR);
-	up(&retu_rtc_sem);
+	mutex_unlock(&retu_rtc_mutex);
 
 	/*
 	 * Shows the status of the Calibration Register.
@@ -291,10 +291,10 @@ static ssize_t retu_rtc_cal_store(struct
 	if (sscanf(buf, "%x", &calibration_value) != 1)
 		return count;
 
-	down(&retu_rtc_sem);
+	mutex_lock(&retu_rtc_mutex);
 	retu_rtc_barrier();
 	retu_write_reg(RETU_REG_RTCCALR, calibration_value & 0x00ff);
-	up(&retu_rtc_sem);
+	mutex_unlock(&retu_rtc_mutex);
 
 	return count;
 }
@@ -370,7 +370,7 @@ static int __devinit retu_rtc_probe(stru
 	if ((r = retu_rtc_init_irq()) != 0)
 		return r;
 
-	init_MUTEX(&retu_rtc_sem);
+	mutex_init(&retu_rtc_mutex);
 
 	/* If the calibration register is zero, we've probably lost
 	 * power */
-- 
1.1.6

--0-1021589137-1143207586=:45761
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1021589137-1143207586=:45761--
