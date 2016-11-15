From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Run make savedefconfig to save some
 space
Date: Tue, 15 Nov 2016 11:02:56 -0800
Message-ID: <20161115190256.31938-1-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This shrinks down omap2plus_defconfig a bit and makes it easier for
people to generate minimal patches against it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -1,7 +1,6 @@
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -40,7 +39,6 @@ CONFIG_ARCH_MULTI_V6=y
 CONFIG_POWER_AVS_OMAP=y
 CONFIG_POWER_AVS_OMAP_CLASS3=y
 CONFIG_OMAP_RESET_CLOCKS=y
-CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_ARCH_OMAP2=y
 CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
@@ -50,7 +48,6 @@ CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
-CONFIG_ARM_ERRATA_430973=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMA=y
@@ -62,7 +59,6 @@ CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
@@ -241,14 +237,14 @@ CONFIG_GPIO_PALMAS=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_W1=m
 CONFIG_HDQ_MASTER_OMAP=m
+CONFIG_POWER_AVS=y
+CONFIG_POWER_RESET=y
 CONFIG_BATTERY_BQ27XXX=m
 CONFIG_CHARGER_ISP1704=m
 CONFIG_CHARGER_TWL4030=m
 CONFIG_CHARGER_BQ2415X=m
 CONFIG_CHARGER_BQ24190=m
 CONFIG_CHARGER_BQ24735=m
-CONFIG_POWER_RESET=y
-CONFIG_POWER_AVS=y
 CONFIG_HWMON=m
 CONFIG_SENSORS_GPIO_FAN=m
 CONFIG_SENSORS_LM75=m
-- 
2.10.2
