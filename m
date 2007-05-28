From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] ARM: OMAP: Define use internal clock field in
	MMCconfiguration
Date: Mon, 28 May 2007 17:39:23 +0900
Message-ID: <020401c7a103$b44baa60$e1ac580a@swcenter.sec.samsung.co.kr>
References: <01ff01c7a0c3$bccee110$e1ac580a@swcenter.sec.samsung.co.kr>
	<5d5443650705280124i522a005fyd8287c9c5eb2e9ac@mail.gmail.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <5d5443650705280124i522a005fyd8287c9c5eb2e9ac@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Trilok Soni' <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thank you for review.
It's old typo. :)
Here's updated patch. 

Thank you,
Kyungmin Park


With the recent omap24xx register cleanup, the CONTROL_DEVCONF is only defined
at arch/arm/mach-omap2/pm.c.
So define 24XX_CONTROL_DEVCONF and use internal clock field in MMC
configuration.
I think it's the proper place to set mmc clock instead of  board-specific one.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
diff --git a/arch/arm/mach-omap2/board-apollon.c
b/arch/arm/mach-omap2/board-apollon.c
index 1276f1f..16428f6 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -251,6 +251,8 @@ static struct omap_mmc_config apollon_mmc_config __initdata
= {
 	.mmc [0] = {
 		.enabled 	= 1,
 		.wire4		= 1,
+	/* Use internal loop-back in MMC/SDIO Module Input Clock selection */
+		.internal_clock	= 1,
 		.wp_pin		= -1,
 		.power_pin	= -1,
 	/* Note: If you want to detect card feature, please assign 37 */
@@ -311,9 +313,6 @@ static void __init omap_apollon_init(void)
 	apollon_flash_init();
 	apollon_usb_init();
 
-	/* Use Interal loop-back in MMC/SDIO Module Input Clock selection */
-	CONTROL_DEVCONF |= (1 << 24);
-
 	/*
  	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
diff --git a/arch/arm/mach-omap2/prcm_common.h
b/arch/arm/mach-omap2/prcm_common.h
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index f8a341b..ba55f4f 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -339,6 +339,17 @@ static void __init omap_init_mmc(void)
 				omap_cfg_reg(MMC_DAT3);
 			}
 		}
+		if (mmc->internal_clock) {
+			/*
+			 * Use internal loop-back in MMC/SDIO
+			 * Module Input Clock selection
+			 */
+			if (cpu_is_omap24xx()) {
+				u32 v = omap_readl(OMAP24XX_CONTROL_DEVCONF);
+				v |= (1 << 24);
+				omap_writel(v, OMAP24XX_CONTROL_DEVCONF);
+			}
+		}
 		mmc1_conf = *mmc;
 		(void) platform_device_register(&mmc_omap_device1);
 	}
diff --git a/include/asm-arm/arch-omap/board.h
b/include/asm-arm/arch-omap/board.h
index dccd62b..acc168f 100644
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -48,6 +48,8 @@ struct omap_mmc_conf {
 	unsigned cover:1;
 	/* 4 wire signaling is optional, and is only used for SD/SDIO */
 	unsigned wire4:1;
+	/* use the internal clock */
+	unsigned internal_clock:1;
 	s16 power_pin;
 	s16 switch_pin;
 	s16 wp_pin;
diff --git a/include/asm-arm/arch-omap/omap24xx.h
b/include/asm-arm/arch-omap/omap24xx.h
index 19b93ef..d78de98 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -16,6 +16,7 @@
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
 #define IRQ_SIR_IRQ		0x0040
 
+#define OMAP24XX_CONTROL_DEVCONF	(L4_24XX_BASE + 0x274)
 #define OMAP24XX_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
 
 #define OMAP2420_CTRL_BASE	L4_24XX_BASE
