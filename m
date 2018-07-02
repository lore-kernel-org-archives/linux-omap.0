From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: move late devices back to init_machine
Date: Tue,  3 Jul 2018 00:28:28 +0200
Message-ID: <20180702222828.27779-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Initialization of several Amstrad Delta devices was once moved to
late_initcall by commit f7519d8c8290 ("ARM: OMAP1: ams-delta: register
latch dependent devices later").  The purpose of that move was to allow
smooth conversion of Amstrad Delta latches to GPIO.

After successful conversion only ams_delta_serio driver was moved back
to device_initcall by commit 8d09a1bb3147 ("input: serio: ams-delta:
toggle keyboard power over GPIO").  Registration of ams-delta-nand and
lcd_ams_delta devices was kept in late_initcall in order to avoid
corrupt data reported by the serio driver on boot.  Registration of
cx20442-codec device was kept there for it to be probed after a
regulator on which it depended was ready.

The issue of "keybrd_dataout" GPIO pin not initilized to GPIO_OUT_LOW
before other latch2 pins causing the corruption have been apparently
fixed by commit 5322c19b117a ("ARM: OMAP1: ams-delta: Hog
"keybrd_dataout" GPIO pin").  In turn, the issue of missing regulator
has been fixed by commit 50c678772a0b ("ASoC: cx20442: Don't ignore
regulator_get() errors.").

Simplify the board init code by moving registration of those devices
back to init_machine.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Created and testet on top of recent commits 3e14de3bfb3a ("ARM: OMAP1:
ams-delta: refactor late_init()") and 5322c19b117a ("ARM: OMAP1:
ams-delta: Hog "keybrd_dataout" GPIO pin") found in branch
omap-for-v4.19/omap1 of linux-omap tree as well as on commit
50c678772a0b ("ASoC: cx20442: Don't ignore regulator_get() errors.")
already found in linux-next tree.

 arch/arm/mach-omap1/board-ams-delta.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 22f9be297c2a..dd28d2614d7f 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -596,9 +596,6 @@ static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_camera_device,
 	&ams_delta_audio_device,
 	&ams_delta_serio_device,
-};
-
-static struct platform_device *late_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
 	&cx20442_codec_device,
@@ -607,9 +604,6 @@ static struct platform_device *late_devices[] __initdata = {
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
 	&ams_delta_audio_gpio_table,
 	&keybrd_pwr_gpio_table,
-};
-
-static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
 	&ams_delta_lcd_gpio_table,
 	&ams_delta_nand_gpio_table,
 };
@@ -713,6 +707,8 @@ static void __init ams_delta_init(void)
 	ams_delta_audio_gpio_table.dev_id =
 			dev_name(&ams_delta_audio_device.dev);
 	keybrd_pwr_gpio_table.dev_id = dev_name(&keybrd_pwr_device.dev);
+	ams_delta_nand_gpio_table.dev_id = dev_name(&ams_delta_nand_device.dev);
+	ams_delta_lcd_gpio_table.dev_id = dev_name(&ams_delta_lcd_device.dev);
 
 	/*
 	 * Once GPIO lookup tables are populated with dev_names, register them.
@@ -836,20 +832,6 @@ static int __init ams_delta_gpio_init(void)
 }
 device_initcall_sync(ams_delta_gpio_init);
 
-static void __init ams_delta_late_devices(void)
-{
-	platform_add_devices(late_devices, ARRAY_SIZE(late_devices));
-
-	/*
-	 * As soon as devices have been registered, assign their dev_names
-	 * to respective GPIO lookup tables before they are added.
-	 */
-	ams_delta_lcd_gpio_table.dev_id = dev_name(&ams_delta_lcd_device.dev);
-	ams_delta_nand_gpio_table.dev_id = dev_name(&ams_delta_nand_device.dev);
-
-	gpiod_add_lookup_tables(late_gpio_tables, ARRAY_SIZE(late_gpio_tables));
-}
-
 static int __init modem_nreset_init(void)
 {
 	int err;
@@ -894,8 +876,6 @@ static int __init late_init(void)
 {
 	int err;
 
-	ams_delta_late_devices();
-
 	err = modem_nreset_init();
 	if (err)
 		return err;
-- 
2.16.4
