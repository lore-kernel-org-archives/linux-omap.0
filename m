From: Todd Poynor <tpoynor@mvista.com>
Subject: LDM wakeup flags for OMAP keypad
Date: Mon, 12 Dec 2005 17:04:42 -0800
Message-ID: <20051213010442.GA23526@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36273541723908176=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@osdl.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--===============36273541723908176==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's a try at converting an embedded platform device, the OMAP keypad,
to the new driver model wakeup enable flags mechanism.  The calls to a
machine-family-specific extern are less than lovely, I realize, so have
at with better suggestions.


diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index b275af5..1c2b7fb 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -182,6 +182,13 @@ void omap_pm_idle(void)
 	local_irq_enable();
 }
 
+static int keypad_wakeup;
+
+void omap_pm_wakeup_enable_keypad(void)
+{
+	keypad_wakeup = 1;
+}
+
 /*
  * Configuration of the wakeup event is board specific. For the
  * moment we put it into this helper function. Later it may move
@@ -213,13 +220,14 @@ static void omap_pm_wakeup_setup(void)
 	if (cpu_is_omap730()) {
 		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
 		omap_writel(~(OMAP_IRQ_BIT(INT_730_WAKE_UP_REQ) |
-				OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD)),
+			        (keypad_wakeup ? 
+			         OMAP_IRQ_BIT(INT_730_MPUIO_KEYPAD) : 0)),
 				OMAP_IH2_1_MIR);
 	} else if (cpu_is_omap1510()) {
-		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
+		level2_wake |= keypad_wakeup ? OMAP_IRQ_BIT(INT_KEYBOARD) : 0;
 		omap_writel(~level2_wake,  OMAP_IH2_MIR);
 	} else if (cpu_is_omap16xx()) {
-		level2_wake |= OMAP_IRQ_BIT(INT_KEYBOARD);
+		level2_wake |= keypad_wakeup ? OMAP_IRQ_BIT(INT_KEYBOARD) : 0;
 		omap_writel(~level2_wake, OMAP_IH2_0_MIR);
 
 		/* INT_1610_WAKE_UP_REQ is needed for GPIO wakeup... */
@@ -598,6 +606,7 @@ static int omap_pm_prepare(suspend_state
 	{
 	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
+		keypad_wakeup = 0;
 		break;
 
 	case PM_SUSPEND_DISK:
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 11626e6..1f3d7b9 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -134,6 +134,7 @@ static void omap_init_kp(void)
 	}
 
 	(void) platform_device_register(&omap_kp_device);
+	device_init_wakeup(&omap_kp_device.dev, 1);
 
 }
 #else
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 7e851e2..3bd46b4 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -272,9 +272,12 @@ static void omap_kp_tasklet(unsigned lon
 }
 
 #ifdef CONFIG_PM
+extern void omap_pm_wakeup_enable_keypad(void);
+
 static int omap_kp_suspend(struct platform_device *dev, pm_message_t state)
 {
-	/* Nothing yet */
+	if (device_may_wakeup(&dev->dev))
+		omap_pm_wakeup_enable_keypad();
 
 	return 0;
 }

--===============36273541723908176==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36273541723908176==--
