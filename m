From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: Readd Amstrad Delta LEDs platform setup.
Date: Tue, 8 Aug 2006 22:28:41 +0100
Message-ID: <20060808212841.GD27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The platform init details for the Amstrad Delta LEDs appear to have
been lost in the most recent sync with mainline. This readds it in
exactly the same manner as it existed previously.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 664c3e2..8437d06 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -91,6 +91,15 @@ static struct omap_board_config_kernel a
 	{ OMAP_TAG_USB,		&ams_delta_usb_config },
 };
 
+static struct platform_device ams_delta_led_device = {
+	.name	= "ams-delta-led",
+	.id	= -1
+};
+
+static struct platform_device *ams_delta_devices[] __initdata = {
+	&ams_delta_led_device,
+};
+
 static void __init ams_delta_init(void)
 {
 	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
@@ -101,6 +110,8 @@ static void __init ams_delta_init(void)
 
 	/* Clear latch2 (NAND, LCD, modem enable) */
 	ams_delta_latch2_write(~0, 0);
+
+	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 }
 
 static void __init ams_delta_map_io(void)
-----

J.

-- 
noodles is consumed in yangon every day
