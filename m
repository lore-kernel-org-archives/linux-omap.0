From: Brian Swetland <swetland@google.com>
Subject: [PATCH] fix omap keypad
Date: Sat, 3 Dec 2005 02:27:34 -0800
Message-ID: <20051203102734.GA12279@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


- register an "omap-keypad" device so that the keypad
  driver actually gets probed

- initialize kp_tasklet.data so that we don't crash the
  first time the keypad tasklet runs


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="omap-keypad.patch"

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 1bb1058..4aeb032 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -99,6 +99,11 @@ static inline void omap_init_i2c(void) {
 
 /*-------------------------------------------------------------------------*/
 #if	defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
+static struct platform_device omap_kp_device = {
+        .name           = "omap-keypad",
+        .id             = -1,
+};
+
 static void omap_init_kp(void)
 {
 	if (machine_is_omap_h2() || machine_is_omap_h3()) {
@@ -127,6 +132,8 @@ static void omap_init_kp(void)
 		omap_cfg_reg(F4_730_KBC3);
 		omap_cfg_reg(E3_730_KBC4);
 	}
+
+	(void) platform_device_register(&omap_kp_device);
 }
 #else
 static inline void omap_init_kp(void) {}
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 15351bb..7e851e2 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -331,6 +331,7 @@ static int __init omap_kp_probe(struct p
 
 	/* get the irq and init timer*/
 	tasklet_enable(&kp_tasklet);
+	kp_tasklet.data = (unsigned long) omap_kp;
 	if (request_irq(keypad_irq, omap_kp_interrupt, 0,
 			"omap-keypad", 0) < 0)
 		return -EINVAL;

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--bp/iNruPH9dso1Pn--
