From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] omap: i2c: Fix muxing for command line enabled bus
Date: Thu, 25 Feb 2010 15:03:01 -0800
Message-ID: <20100225230301.26233.25402.stgit@baageli.muru.com>
References: <20100225230116.26233.65157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65014 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934444Ab0BYXCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 18:02:02 -0500
In-Reply-To: <20100225230116.26233.65157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

The commit b63128e81214cc2db2995d690438055c26d213a5 broke the pin muxing
for I2C busses that are enabled from the kernel command line.

Fix this by defining the board registration function omap_register_i2c_bus
in common platform code as it was before but keep the muxing in architecture
dependent files.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/i2c.c             |    6 +-----
 arch/arm/mach-omap2/i2c.c             |    6 +-----
 arch/arm/plat-omap/i2c.c              |   10 ++++++++--
 arch/arm/plat-omap/include/plat/i2c.h |    5 ++---
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 1bf4735..5446c99 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -23,9 +23,7 @@
 #include <plat/mux.h>
 #include <plat/cpu.h>
 
-int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
-			  struct i2c_board_info const *info,
-			  unsigned len)
+void __init omap1_i2c_mux_pins(int bus_id)
 {
 	if (cpu_is_omap7xx()) {
 		omap_cfg_reg(I2C_7XX_SDA);
@@ -34,6 +32,4 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 		omap_cfg_reg(I2C_SDA);
 		omap_cfg_reg(I2C_SCL);
 	}
-
-	return omap_plat_register_i2c_bus(bus_id, clkrate, info, len);
 }
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index 789ca8c..7951ae1 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -25,9 +25,7 @@
 
 #include "mux.h"
 
-int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
-			  struct i2c_board_info const *info,
-			  unsigned len)
+void __init omap2_i2c_mux_pins(int bus_id)
 {
 	if (cpu_is_omap24xx()) {
 		const int omap24xx_pins[][2] = {
@@ -51,6 +49,4 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 		sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
 		omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
 	}
-
-	return omap_plat_register_i2c_bus(bus_id, clkrate, info, len);
 }
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 96d2781..624e262 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -28,6 +28,7 @@
 #include <linux/i2c.h>
 #include <mach/irqs.h>
 #include <plat/mux.h>
+#include <plat/i2c.h>
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
@@ -117,6 +118,11 @@ static int __init omap_i2c_add_bus(int bus_id)
 		res[1].start = irq;
 	}
 
+	if (cpu_class_is_omap1())
+		omap1_i2c_mux_pins(bus_id);
+	if (cpu_class_is_omap2())
+		omap2_i2c_mux_pins(bus_id);
+
 	return platform_device_register(pdev);
 }
 
@@ -169,7 +175,7 @@ out:
 subsys_initcall(omap_register_i2c_bus_cmdline);
 
 /**
- * omap_plat_register_i2c_bus - register I2C bus with device descriptors
+ * omap_register_i2c_bus - register I2C bus with device descriptors
  * @bus_id: bus id counting from number 1
  * @clkrate: clock rate of the bus in kHz
  * @info: pointer into I2C device descriptor table or NULL
@@ -177,7 +183,7 @@ subsys_initcall(omap_register_i2c_bus_cmdline);
  *
  * Returns 0 on success or an error code.
  */
-int __init omap_plat_register_i2c_bus(int bus_id, u32 clkrate,
+int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
 {
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 585d9ca..87f6bf2 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -34,6 +34,5 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 }
 #endif
 
-int omap_plat_register_i2c_bus(int bus_id, u32 clkrate,
-				 struct i2c_board_info const *info,
-				 unsigned len);
+void __init omap1_i2c_mux_pins(int bus_id);
+void __init omap2_i2c_mux_pins(int bus_id);

