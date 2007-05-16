From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/5] omap2: use CTRL_BASE in place of OMAP24XX_CTRL_BASE
Date: Wed, 16 May 2007 16:58:55 -0600
Message-ID: <20070516231342.514533769@pwsan.com>
References: <20070516225850.075133914@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0005-omap2-use-CTRL_BASE-in-place-of-OMAP24XX_CTRL_BASE.patch
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

Change users of OMAP24XX_CTRL_BASE to use CTRL_BASE.  Remove the
OMAP24XX_CTRL_BASE define.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm-regs.h      |    2 +-
 arch/arm/plat-omap/mux.c             |    6 +++---
 include/asm-arm/arch-omap/omap24xx.h |    2 --
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-regs.h b/arch/arm/mach-omap2/prcm-regs.h
index 3c0688c..a6842cb 100644
--- a/arch/arm/mach-omap2/prcm-regs.h
+++ b/arch/arm/mach-omap2/prcm-regs.h
@@ -350,7 +350,7 @@
 #endif
 
 /* IO CONFIG */
-#define CONTROL_REG32(offset)		__REG32(OMAP24XX_CTRL_BASE + (offset))
+#define CONTROL_REG32(offset)		__REG32(CTRL_BASE + (offset))
 #define CONTROL_PADCONF_SPI1_NCS2	CONTROL_REG32(0x104)
 #define CONTROL_PADCONF_SYS_XTALOUT	CONTROL_REG32(0x134)
 #define CONTROL_PADCONF_UART1_RX	CONTROL_REG32(0x0C8)
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 8b987b4..b40083f 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -85,7 +85,7 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 			reg |= OMAP24XX_PULL_UP;
 #if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
 		{
-			u8 orig = omap_readb(OMAP24XX_CTRL_BASE + cfg->mux_reg);
+			u8 orig = omap_readb(CTRL_BASE + cfg->mux_reg);
 			u8 debug = 0;
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
@@ -95,11 +95,11 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 			if (debug || warn)
 				printk("MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
 						cfg->name,
-						OMAP24XX_CTRL_BASE + cfg->mux_reg,
+						CTRL_BASE + cfg->mux_reg,
 						orig, reg);
 		}
 #endif
-		omap_writeb(reg, OMAP24XX_CTRL_BASE + cfg->mux_reg);
+		omap_writeb(reg, CTRL_BASE + cfg->mux_reg);
 
 		return 0;
 	}
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index fd9d48b..9c8c959 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -72,8 +72,6 @@
 #error "Unknown architecture"
 #endif
 
-/* Temporary defines to be cleaned up in following patches */
-#define OMAP24XX_CTRL_BASE	CTRL_BASE
 
 #endif /* __ASM_ARCH_OMAP24XX_H */
 
-- 
1.5.1.3

-- 
