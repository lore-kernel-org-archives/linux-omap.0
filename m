From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: KEYPAD: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:34:46 -0800 (PST)
Message-ID: <20060324133446.33979.qmail@web32908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-151204970-1143207286=:33471"
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

--0-151204970-1143207286=:33471
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
--0-151204970-1143207286=:33471
Content-Type: text/plain; name="0001-OMAP-KEYPAD-sem2mutex-conversion.txt"
Content-Description: 1496485884-0001-OMAP-KEYPAD-sem2mutex-conversion.txt
Content-Disposition: inline;
	filename="0001-OMAP-KEYPAD-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: KEYPAD: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/input/keyboard/omap-keypad.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

a5bac55a8195a93ec930d8ee733672a75ef9a5e6
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index e6057fa..ff1acb5 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -32,6 +32,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/mutex.h>
 #include <asm/arch/irqs.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/hardware.h>
@@ -48,7 +49,7 @@ static void omap_kp_tasklet(unsigned lon
 static void omap_kp_timer(unsigned long);
 
 static unsigned char keypad_state[8];
-static DECLARE_MUTEX(kp_enable_mutex);
+static DEFINE_MUTEX(kp_enable_mutex);
 static int kp_enable = 1;
 static int kp_cur_group = -1;
 
@@ -250,7 +251,7 @@ static ssize_t omap_kp_enable_store(stru
 	if ((state != 1) && (state != 0))
 		return -EINVAL;
 
-	down(&kp_enable_mutex);
+	mutex_lock(&kp_enable_mutex);
 	if (state != kp_enable) {
 		if (state)
 			enable_irq(INT_KEYBOARD);
@@ -258,7 +259,7 @@ static ssize_t omap_kp_enable_store(stru
 			disable_irq(INT_KEYBOARD);
 		kp_enable = state;
 	}
-	up(&kp_enable_mutex);
+	mutex_unlock(&kp_enable_mutex);
 
 	return strnlen(buf, count);
 }
-- 
1.1.6

--0-151204970-1143207286=:33471
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-151204970-1143207286=:33471--
