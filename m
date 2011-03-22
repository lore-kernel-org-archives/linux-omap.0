From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Tue, 22 Mar 2011 23:26:19 +0900
Message-ID: <20110322142619.1109.89105.sendpatchset@t400s>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: srk@ti.com, khilman@ti.com, chinyeow.sim.xt@renesas.com, linux-sh@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The tca6416 driver makes use of the I2C bus for chatting
with the actual hardware device. Without this patch both
the I2C bus driver and the tca6416 driver are initialized
at the subsys_initcall() level. This may lead to problems
with the tca6416 driver being initialized before the I2C
bus driver.

By using module_init() in the tca6416 driver we make sure
the I2C bus driver always is initialized before the keypad
driver.

With this patch applied the boot order becomes:
 - arch_initcall: the ARM architecture ->init_machine()
 - arch_initcall: i2c_register_board_info()
 - arch_initcall: I2C bus device registration
 - subsys_initcall: I2C bus driver probe()
 - module_init: tca6416 driver probe()

Affects the following in-tree platforms:
 - arch/arm/mach-davinci/board-da850-evm.c
 - arch/arm/mach-omap2/board-am3517evm.c
 - arch/arm/mach-shmobile/board-mackerel.c

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/tca6416-keypad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/input/keyboard/tca6416-keypad.c
+++ work/drivers/input/keyboard/tca6416-keypad.c	2011-03-22 22:44:26.000000000 +0900
@@ -369,7 +369,7 @@ static int __init tca6416_keypad_init(vo
 	return i2c_add_driver(&tca6416_keypad_driver);
 }
 
-subsys_initcall(tca6416_keypad_init);
+module_init(tca6416_keypad_init);
 
 static void __exit tca6416_keypad_exit(void)
 {
