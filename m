From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/9] ARM: OMAP2+: Cleanup omap_i2c_dev_attr usage
Date: Mon, 12 Feb 2018 19:32:38 -0600
Message-ID: <20180213013243.8378-5-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The omap_i2c_dev_attr data was used to supply instance-specific
data for legacy non-DT devices. The I2C legacy device support has
been cleaned up in commit 65fa3e719f36 ("ARM: OMAP2+: Remove legacy
i2c.c platform init code") and this data is therefore no longer
needed. So, cleanup the structure and all the associated data in
various hwmod data files.

The i2c-omap.h header is still needed because of the need for
various OMAP_I2C_IP_VERSION_x macros.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/i2c.h                            | 13 -------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c           |  9 ---------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c           |  8 --------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c   |  7 -------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c           | 20 --------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c           |  8 --------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c           | 10 ----------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c            | 10 ----------
 8 files changed, 85 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.h b/arch/arm/mach-omap2/i2c.h
index 42b6f2e7d190..f76ff790b435 100644
--- a/arch/arm/mach-omap2/i2c.h
+++ b/arch/arm/mach-omap2/i2c.h
@@ -24,19 +24,6 @@
 #ifndef __MACH_OMAP2_I2C_H
 #define __MACH_OMAP2_I2C_H
 
-/**
- * i2c_dev_attr - OMAP I2C controller device attributes for omap_hwmod
- * @fifo_depth: total controller FIFO size (in bytes)
- * @flags: differences in hardware support capability
- *
- * @fifo_depth represents what exists on the hardware, not what is
- * actually configured at runtime by the device driver.
- */
-struct omap_i2c_dev_attr {
-	u8	fifo_depth;
-	u32	flags;
-};
-
 int omap_i2c_reset(struct omap_hwmod *oh);
 
 #endif	/* __MACH_OMAP2_I2C_H */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 0afb014b211f..1fdfd4568899 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -97,13 +97,6 @@ static struct omap_hwmod_class i2c_class = {
 	.reset		= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags		= OMAP_I2C_FLAG_NO_FIFO |
-			  OMAP_I2C_FLAG_SIMPLE_CLOCK |
-			  OMAP_I2C_FLAG_16BIT_DATA_REG |
-			  OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
 /* I2C1 */
 static struct omap_hwmod omap2420_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -116,7 +109,6 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 	/*
 	 * From mach-omap2/pm24xx.c: "Putting MPU into the WFI state
 	 * while a transfer is active seems to cause the I2C block to
@@ -137,7 +129,6 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 	.flags		= HWMOD_16BIT_REG,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 1f696bec9962..9b5a18b35ff6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -75,12 +75,6 @@ static struct omap_hwmod_class i2c_class = {
 	.reset		= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2 |
-			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
-};
-
 /* I2C1 */
 static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -102,7 +96,6 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* I2C2 */
@@ -118,7 +111,6 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* gpio5 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index b710b6d984cc..641b94f8ddb4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -645,10 +645,6 @@ static struct omap_hwmod_class i2c_class = {
 	.reset		= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 struct omap_hwmod am33xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -661,7 +657,6 @@ struct omap_hwmod am33xx_i2c1_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c1 */
@@ -676,7 +671,6 @@ struct omap_hwmod am33xx_i2c2_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -691,7 +685,6 @@ struct omap_hwmod am33xx_i2c3_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c7ff7560f47a..1bb33d8bd2ac 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -682,11 +682,6 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 };
 
 /* I2C1 */
-static struct omap_i2c_dev_attr i2c1_dev_attr = {
-	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
@@ -699,15 +694,9 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c1_dev_attr,
 };
 
 /* I2C2 */
-static struct omap_i2c_dev_attr i2c2_dev_attr = {
-	.fifo_depth	= 8, /* bytes */
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
@@ -720,17 +709,9 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c2_dev_attr,
 };
 
 /* I2C3 */
-static struct omap_i2c_dev_attr i2c3_dev_attr = {
-	.fifo_depth	= 64, /* bytes */
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
-};
-
-
-
 static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
@@ -743,7 +724,6 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 		},
 	},
 	.class		= &i2c_class,
-	.dev_attr	= &i2c3_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3afb7333b800..cb39901d611b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1381,10 +1381,6 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.reset	= &omap_i2c_reset,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -1399,7 +1395,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c2 */
@@ -1416,7 +1411,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -1433,7 +1427,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c4 */
@@ -1450,7 +1443,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 593b4bc92d99..250524fed202 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -824,11 +824,6 @@ static struct omap_hwmod_class omap54xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
-/* i2c dev_attr */
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 static struct omap_hwmod omap54xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -843,7 +838,6 @@ static struct omap_hwmod omap54xx_i2c1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c2 */
@@ -860,7 +854,6 @@ static struct omap_hwmod omap54xx_i2c2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -877,7 +870,6 @@ static struct omap_hwmod omap54xx_i2c3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c4 */
@@ -894,7 +886,6 @@ static struct omap_hwmod omap54xx_i2c4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c5 */
@@ -911,7 +902,6 @@ static struct omap_hwmod omap54xx_i2c5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 523e89498fd3..a78f9285cbe8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1090,11 +1090,6 @@ static struct omap_hwmod_class dra7xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
-/* i2c dev_attr */
-static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
-};
-
 /* i2c1 */
 static struct omap_hwmod dra7xx_i2c1_hwmod = {
 	.name		= "i2c1",
@@ -1109,7 +1104,6 @@ static struct omap_hwmod dra7xx_i2c1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c2 */
@@ -1126,7 +1120,6 @@ static struct omap_hwmod dra7xx_i2c2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c3 */
@@ -1143,7 +1136,6 @@ static struct omap_hwmod dra7xx_i2c3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c4 */
@@ -1160,7 +1152,6 @@ static struct omap_hwmod dra7xx_i2c4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /* i2c5 */
@@ -1177,7 +1168,6 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &i2c_dev_attr,
 };
 
 /*
-- 
2.15.1
