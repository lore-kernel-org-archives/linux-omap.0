From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/10] ARM: omap2plus_defconfig: Update for moved options
Date: Thu,  1 Mar 2018 14:16:55 -0800
Message-ID: <20180301221704.104530-2-tony@atomide.com>
References: <20180301221704.104530-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180301221704.104530-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Just move the options around to make applying patches against
omap2plus_defconfig easier after making make savedefconfig.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -71,9 +71,10 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPUFREQ_DT=m
-CONFIG_ARM_TI_CPUFREQ=y
 # CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
+CONFIG_ARM_TI_CPUFREQ=y
 CONFIG_CPU_IDLE=y
+CONFIG_KERNEL_MODE_NEON=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM_DEBUG=y
 CONFIG_NET=y
@@ -314,14 +315,14 @@ CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65218=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
+CONFIG_RC_CORE=m
+CONFIG_RC_DEVICES=y
+CONFIG_IR_RX51=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_CAMERA_SUPPORT=y
-CONFIG_RC_CORE=m
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_LIRC=m
-CONFIG_RC_DEVICES=y
-CONFIG_IR_RX51=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_OMAP3=m
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
@@ -520,15 +521,6 @@ CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
-CONFIG_CRC_CCITT=y
-CONFIG_CRC_T10DIF=y
-CONFIG_CRC_ITU_T=y
-CONFIG_CRC7=y
-CONFIG_LIBCRC32C=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-CONFIG_KERNEL_MODE_NEON=y
 CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
@@ -536,5 +528,13 @@ CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_CRC_CCITT=y
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC7=y
+CONFIG_LIBCRC32C=y
+CONFIG_FONTS=y
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
-- 
2.16.2
