From: "Sameer" <x0081444@ti.com>
Subject: [PATCH: Resending] - onenand - OMAP3 support - Kconfig update
Date: Tue, 27 Nov 2007 16:51:24 +0530
Message-ID: <008b01c830e7$a650a220$ec8818ac@ent.ti.com>
References: <00c601c82aa7$faf8e620$ec8818ac@ent.ti.com>
	<010001c82b47$71eae130$ec8818ac@ent.ti.com>
	<014f01c82cc4$82ad3260$ec8818ac@ent.ti.com>
	<20071123212831.GJ559@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20071123212831.GJ559@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com, 'Tony Lindgren' <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,
Please ignore the previous patch.
The following patch provides the onenand support for OMAP3.
The patch enables the onenand in def_config file, enable onenand Kconfig for OMAP3 and redeclaring the omap2_sleep_block(),
omap2_allow_sleep() according to CONFIG_PM defination in pm.h according to Tony's recommendation.

 

Regards,
-Sameer

Signed-off-by: Nishant Kamat <nskamat@ti.com>
Signed-off-by: Sameer <sameersu@ti.com>
---
---
 arch/arm/configs/omap_3430sdp_defconfig |    3 +++
 drivers/mtd/onenand/Kconfig             |    6 +++---
 include/asm-arm/arch-omap/pm.h          |    8 +++++++-
 3 files changed, 13 insertions(+), 4 deletions(-)

Index: linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-git.orig/arch/arm/configs/omap_3430sdp_defconfig
+++ linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig
@@ -461,7 +461,10 @@ CONFIG_MTD_OMAP_NOR=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 # CONFIG_MTD_ONENAND_GENERIC is not set
+CONFIG_MTD_ONENAND_OMAP2=y
 # CONFIG_MTD_ONENAND_OTP is not set
+# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
+# CONFIG_MTD_ONENAND_SIM is not set

 #
 # UBI - Unsorted block images
Index: linux-omap-git/drivers/mtd/onenand/Kconfig
===================================================================
--- linux-omap-git.orig/drivers/mtd/onenand/Kconfig
+++ linux-omap-git/drivers/mtd/onenand/Kconfig
@@ -28,10 +28,10 @@ config MTD_ONENAND_GENERIC
          Support for OneNAND flash via platform device driver.

 config MTD_ONENAND_OMAP2
-       tristate "OneNAND on OMAP2 support"
-       depends on MTD_ONENAND && ARCH_OMAP2
+       tristate "OneNAND on OMAP2/OMAP3 support"
+       depends on MTD_ONENAND && (ARCH_OMAP2 || ARCH_OMAP3)
        help
-         Support for a OneNAND flash device connected to an OMAP2 CPU
+         Support for a OneNAND flash device connected to an OMAP2/OMAP3 CPU
          via the GPMC memory controller.

 config MTD_ONENAND_OTP
Index: linux-omap-git/include/asm-arm/arch-omap/pm.h
===================================================================
--- linux-omap-git.orig/include/asm-arm/arch-omap/pm.h
+++ linux-omap-git/include/asm-arm/arch-omap/pm.h
@@ -107,7 +107,8 @@
 #if     !defined(CONFIG_ARCH_OMAP730) && \
        !defined(CONFIG_ARCH_OMAP15XX) && \
        !defined(CONFIG_ARCH_OMAP16XX) && \
-       !defined(CONFIG_ARCH_OMAP24XX)
+       !defined(CONFIG_ARCH_OMAP24XX) && \
+       !defined(CONFIG_ARCH_OMAP34XX)
 #error "Power management for this processor not implemented yet"
 #endif

@@ -134,8 +135,13 @@ void clk_deny_idle(struct clk *clk);

 extern void omap_pm_idle(void);
 extern void omap_pm_suspend(void);
+#ifdef CONFIG_PM
 extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
+#else
+#define omap2_block_sleep()    /* NULL */
+#define omap2_allow_sleep()    /* NULL */
+#endif
 extern void omap730_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1611_cpu_suspend(unsigned short, unsigned short);
