From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: [PATCH] OMAP: Apollon Plus board support
Date: Mon, 2 Jul 2007 16:40:28 +0900
Message-ID: <002d01c7bc7c$4570b790$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
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

[PATCH] Apollon Plus board support

Now only enable LEDs and SWs.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 60bfa75..f463f6c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -75,6 +75,15 @@ config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
 
+config MACH_OMAP_APOLLON_PLUS
+	bool "OMAP 2420 Apollon Plus board"
+	select MACH_OMAP_APOLLON
+	help
+	  It contains more LEDs, SWs, and so on
+
+	  Note that it is only tested with version 1.1 and more
+	  We have to test the version 1.0
+
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
diff --git a/arch/arm/mach-omap2/board-apollon-keys.c
b/arch/arm/mach-omap2/board-apollon-keys.c
index 8cd2e52..6b2e551 100644
--- a/arch/arm/mach-omap2/board-apollon-keys.c
+++ b/arch/arm/mach-omap2/board-apollon-keys.c
@@ -21,6 +21,9 @@
 #define SW_ENTER_GPIO16		16
 #define SW_UP_GPIO17		17
 #define SW_DOWN_GPIO58		58
+#define SW_LEFT_GPIO95		95
+#define SW_RIGHT_GPIO96		96
+#define SW_ESC_GPIO97		97
 
 static struct gpio_keys_button apollon_gpio_keys_buttons[] = {
 	[0] = {
@@ -38,6 +41,23 @@ static struct gpio_keys_button apollon_gpio_keys_buttons[] =
{
 		.gpio		= SW_DOWN_GPIO58,
 		.desc		= "down sw",
 	},
+#ifdef CONFIG_MACH_OMAP_APOLLON_PLUS
+	[3] = {
+		.code		= KEY_LEFT,
+		.gpio		= SW_LEFT_GPIO95,
+		.desc		= "left sw",
+	},
+	[4] = {
+		.code		= KEY_RIGHT,
+		.gpio		= SW_RIGHT_GPIO96,
+		.desc		= "right sw",
+	},
+	[5] = {
+		.code		= KEY_ESC,
+		.gpio		= SW_ESC_GPIO97,
+		.desc		= "esc sw",
+	},
+#endif
 };
 
 static struct gpio_keys_platform_data apollon_gpio_keys = {
@@ -67,6 +87,20 @@ static void __init apollon_sw_init(void)
 	omap_cfg_reg(AA8_242X_GPIO58);
 	omap_request_gpio(SW_DOWN_GPIO58);
 	omap_set_gpio_direction(SW_DOWN_GPIO58, 1);
+#ifdef CONFIG_MACH_OMAP_APOLLON_PLUS
+	/* Left SW - P18 */
+	omap_cfg_reg(P18_24XX_GPIO95);
+	omap_request_gpio(SW_LEFT_GPIO95);
+	omap_set_gpio_direction(SW_LEFT_GPIO95, 1);
+	/* Right SW - M18 */
+	omap_cfg_reg(M18_24XX_GPIO96);
+	omap_request_gpio(SW_RIGHT_GPIO96);
+	omap_set_gpio_direction(SW_RIGHT_GPIO96, 1);
+	/* Esc SW - L14 */
+	omap_cfg_reg(L14_24XX_GPIO97);
+	omap_request_gpio(SW_ESC_GPIO97);
+	omap_set_gpio_direction(SW_ESC_GPIO97, 1);
+#endif
 }
 
 static int __init omap_apollon_keys_init(void)
diff --git a/arch/arm/mach-omap2/board-apollon.c
b/arch/arm/mach-omap2/board-apollon.c
index 16428f6..65d67f0 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -44,6 +44,8 @@
 #define LED0_GPIO13		13
 #define LED1_GPIO14		14
 #define LED2_GPIO15		15
+#define LED3_GPIO92		92
+#define LED4_GPIO93		93
 
 #define APOLLON_FLASH_CS	0
 #define APOLLON_ETH_CS		1
@@ -157,6 +159,20 @@ static struct omap_led_config apollon_led_config[] = {
 		},
 		.gpio	= LED2_GPIO15,
 	},
+#ifdef CONFIG_MACH_OMAP_APOLLON_PLUS
+	{
+		.cdev	= {
+			.name	= "apollon:led3",
+		},
+		.gpio	= LED3_GPIO92,
+	},
+	{
+		.cdev	= {
+			.name	= "apollon:led4",
+		},
+		.gpio	= LED4_GPIO93,
+	},
+#endif
 };
 
 static struct omap_led_platform_data apollon_led_data = {
@@ -295,6 +311,18 @@ static void __init apollon_led_init(void)
 	omap_request_gpio(LED2_GPIO15);
 	omap_set_gpio_direction(LED2_GPIO15, 0);
 	omap_set_gpio_dataout(LED2_GPIO15, 0);
+#ifdef CONFIG_MACH_OMAP_APOLLON_PLUS
+	/* LED3 - M15 */ 
+	omap_cfg_reg(M15_24XX_GPIO92);
+	omap_request_gpio(LED3_GPIO92);
+	omap_set_gpio_direction(LED3_GPIO92, 0);
+	omap_set_gpio_dataout(LED3_GPIO92, 0);
+	/* LED4 - P20 */
+	omap_cfg_reg(P20_24XX_GPIO93);
+	omap_request_gpio(LED4_GPIO93);
+	omap_set_gpio_direction(LED4_GPIO93, 0);
+	omap_set_gpio_dataout(LED4_GPIO93, 0);
+#endif
 }
 
 static void __init apollon_usb_init(void)
