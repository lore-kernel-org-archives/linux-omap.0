From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/30] ARM: omap: fix build with CONFIG_I2C_OMAP disabled
Date: Sun,  2 Oct 2011 16:45:36 +0200
Message-ID: <1317566760-25681-7-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

We must not reference omap_i2c_reset if the file defining it
does not get built.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/plat-omap/include/plat/i2c.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 7c22b9e..ae72013 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -28,6 +28,8 @@
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
 				 unsigned len);
+struct omap_hwmod;
+int omap_i2c_reset(struct omap_hwmod *oh);
 #else
 static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
@@ -35,6 +37,7 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 {
 	return 0;
 }
+#define omap_i2c_reset NULL
 #endif
 
 /**
@@ -53,7 +56,4 @@ struct omap_i2c_dev_attr {
 void __init omap1_i2c_mux_pins(int bus_id);
 void __init omap2_i2c_mux_pins(int bus_id);
 
-struct omap_hwmod;
-int omap_i2c_reset(struct omap_hwmod *oh);
-
 #endif /* __ASM__ARCH_OMAP_I2C_H */
-- 
1.7.5.4
