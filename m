From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: [PATCH RFC] arch/arm/plat-omap/devices.c
Date: Tue, 18 Sep 2007 17:33:29 -0300
Message-ID: <ae36f8040709181333q2b8e3e6ena5d864b14178c582@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

--- linux-omap-2.6/arch/arm/plat-omap/devices.c 2007-08-28 01:01:
50.502065325 -0300
+++ linux-omap-2.6.23-instramed/arch/arm/plat-omap/devices.c    2007-09-18
15:05:44.748685528 -0300
@@ -25,6 +25,26 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/menelaus.h>

+/*------------------------------------------------------------------------=
-*/
+/**
+ * 18/09/2007 - 14:35 - 03:00GMT
+ * lvcargnini@ieee.org
+ * Luis Vitorio modifications for devices.c
+ * added this to fix some bugs founded for mmc and possible speed-up
+ * enhancements removing unecessary code, for some plataforms
+ * why test if cpu_is_2420 on the fly ????
+ */
+
+#if defined(CONFIG_ARCH_OMAP16XX)
+#include <asm/arch/omap16xx.h>
+#elif defined(CONFIG_ARCH_OMAP24XX)
+#include <asm/arch/omap24xx.h>
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#include <asm/arch/omap34xx.h>
+#endif
+
+/*------------------------------------------------------------------------=
-*/
+
 #if    defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)

 #include "../plat-omap/dsp/dsp_common.h"
@@ -127,29 +147,32 @@ static struct platform_device omap_i2c_d
 /* See also arch/arm/mach-omap2/devices.c for second I2C on 24xx */
 static void omap_init_i2c(void)
 {
-       if (cpu_is_omap242x()) {
+/**
+ * Vitorio 18/09/2007 - 14:35 - 03:00GMT
+ */
+#if defined(CONFIG_ARCH_OMAP24XX)
                i2c_resources1[0].start =3D OMAP2_I2C_BASE1;
                i2c_resources1[0].end =3D OMAP2_I2C_BASE1 + OMAP_I2C_SIZE;
                i2c_resources1[1].start =3D OMAP2_I2C_INT1;
-       } else {
-               i2c_resources1[0].start =3D OMAP1_I2C_BASE;
-               i2c_resources1[0].end =3D OMAP1_I2C_BASE + OMAP_I2C_SIZE;
-               i2c_resources1[1].start =3D OMAP1_I2C_INT;
-       }
-
-       /* FIXME define and use a boot tag, in case of boards that
+               /* FIXME define and use a boot tag, in case of boards that
         * either don't wire up I2C, or chips that mux it differently...
         * it can include clocking and address info, maybe more.
         */
-       if (cpu_class_is_omap2()) {
-               if (machine_is_omap_h4()) {
+        if (machine_is_omap_h4()) {
                        omap_cfg_reg(M19_24XX_I2C1_SCL);
                        omap_cfg_reg(L15_24XX_I2C1_SDA);
                }
-       } else {
-               omap_cfg_reg(I2C_SCL);
+#else
+               i2c_resources1[0].start =3D OMAP1_I2C_BASE;
+               i2c_resources1[0].end =3D OMAP1_I2C_BASE + OMAP_I2C_SIZE;
+               i2c_resources1[1].start =3D OMAP1_I2C_INT;
+               /* FIXME define and use a boot tag, in case of boards that
+                * either don't wire up I2C, or chips that mux it
differently...
+                * it can include clocking and address info, maybe more.
+                */
+               omap_cfg_reg(I2C_SCL);
                omap_cfg_reg(I2C_SDA);
-       }
+#endif

        (void) platform_device_register(&omap_i2c_device1);
 }
@@ -306,14 +329,17 @@ static void __init omap_init_mmc(void)
        /* block 1 is always available and has just one pinout option */
        mmc =3D &mmc_conf->mmc[0];
        if (mmc->enabled) {
-               if (cpu_is_omap24xx()) {
+/**
+ * Vitorio 18/09/2007 - 14:35 - 03:00GMT
+ */
+#if defined(CONFIG_ARCH_OMAP24XX)
                        omap_cfg_reg(H18_24XX_MMC_CMD);
                        omap_cfg_reg(H15_24XX_MMC_CLKI);
                        omap_cfg_reg(G19_24XX_MMC_CLKO);
                        omap_cfg_reg(F20_24XX_MMC_DAT0);
                        omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
                        omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
-               } else {
+#else
                        omap_cfg_reg(MMC_CMD);
                        omap_cfg_reg(MMC_CLK);
                        omap_cfg_reg(MMC_DAT0);
@@ -322,33 +348,40 @@ static void __init omap_init_mmc(void)
                                omap_cfg_reg(P19_1710_MMC_CMDDIR);
                                omap_cfg_reg(P20_1710_MMC_DATDIR0);
                        }
-               }
+#endif
+
                if (mmc->wire4) {
-                       if (cpu_is_omap24xx()) {
+/**
+ * Vitorio 18/09/2007 - 14:35 - 03:00GMT
+ */
+#if defined(CONFIG_ARCH_OMAP24XX)
                                omap_cfg_reg(H14_24XX_MMC_DAT1);
                                omap_cfg_reg(E19_24XX_MMC_DAT2);
                                omap_cfg_reg(D19_24XX_MMC_DAT3);
                                omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
                                omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
                                omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
-                       } else {
+#else
                                omap_cfg_reg(MMC_DAT1);
                                /* NOTE:  DAT2 can be on W10 (here) or M15
*/
                                if (!mmc->nomux)
                                        omap_cfg_reg(MMC_DAT2);
                                omap_cfg_reg(MMC_DAT3);
-                       }
+#endif
                }
                if (mmc->internal_clock) {
                        /*
                         * Use internal loop-back in MMC/SDIO
                         * Module Input Clock selection
                         */
-                       if (cpu_is_omap24xx()) {
+       /**
+ * Vitorio 18/09/2007 - 14:35 - 03:00GMT
+ */
+#if defined(CONFIG_ARCH_OMAP24XX)
                                u32 v =3D omap_readl(OMAP2_CONTROL_DEVCONF)=
;
                                v |=3D (1 << 24);
                                omap_writel(v, OMAP2_CONTROL_DEVCONF);
-                       }
+#endif
                }
                mmc1_conf =3D *mmc;
                (void) platform_device_register(&mmc_omap_device1);


--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
