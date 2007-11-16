From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Fix compiler error when I2C_OMAP is not set
Date: Fri, 16 Nov 2007 09:36:49 +0900
Message-ID: <20071116003649.GA27407@party>
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
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Fix compiler error when I2C_OMAP is not set

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 089ddc7..1797927 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -36,8 +36,12 @@ struct sys_timer;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
+#ifdef CONFIG_I2C_OMAP
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
 				 unsigned len);
+#else
+#define omap_register_i2c_bus(...)	do { } while (0)
+#endif
 
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
