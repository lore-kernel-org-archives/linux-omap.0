From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Update for moved options
Date: Mon,  4 Feb 2019 12:33:36 -0800
Message-ID: <20190204203336.7031-2-tony@atomide.com>
References: <20190204203336.7031-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190204203336.7031-1-tony@atomide.com>
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

These options have just moved around, let's update with make
savedefconfig to make patching the file easier.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 76 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -25,16 +25,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_POWER_AVS_OMAP=y
 CONFIG_POWER_AVS_OMAP_CLASS3=y
@@ -48,15 +38,8 @@ CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_PCI_DRA7XX_EP=y
-CONFIG_PCI_ENDPOINT=y
-CONFIG_PCI_ENDPOINT_CONFIGFS=y
-CONFIG_PCI_EPF_TEST=m
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -74,8 +57,27 @@ CONFIG_CPUFREQ_DT=m
 CONFIG_ARM_TI_CPUFREQ=y
 CONFIG_CPU_IDLE=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_BINFMT_MISC=y
 CONFIG_PM_DEBUG=y
+CONFIG_ARM_CRYPTO=y
+CONFIG_CRYPTO_SHA1_ARM_NEON=m
+CONFIG_CRYPTO_SHA256_ARM=m
+CONFIG_CRYPTO_SHA512_ARM=m
+CONFIG_CRYPTO_AES_ARM=m
+CONFIG_CRYPTO_AES_ARM_BS=m
+CONFIG_CRYPTO_GHASH_ARM_CE=m
+CONFIG_CRYPTO_CHACHA20_NEON=m
+CONFIG_OPROFILE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=y
+CONFIG_CMA=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -118,6 +120,12 @@ CONFIG_AF_RXRPC=m
 CONFIG_RXKAD=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DRA7XX_EP=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
@@ -132,13 +140,13 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_M25P80=m
+CONFIG_MTD_ONENAND=y
+CONFIG_MTD_ONENAND_VERIFY_WRITE=y
+CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
-CONFIG_MTD_ONENAND=y
-CONFIG_MTD_ONENAND_VERIFY_WRITE=y
-CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
@@ -380,10 +388,10 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_NOKIA_RX51=m
-CONFIG_SND_SOC_OMAP_HDMI=m
-CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_SOC_OMAP3_PANDORA=m
 CONFIG_SND_SOC_OMAP3_TWL4030=m
+CONFIG_SND_SOC_OMAP_ABE_TWL6040=m
+CONFIG_SND_SOC_OMAP_HDMI=m
 CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SOC_TLV320AIC23_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
@@ -525,23 +533,8 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_INFO_SPLIT=y
-CONFIG_DEBUG_INFO_DWARF4=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_SCHEDSTATS=y
-# CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
-CONFIG_ARM_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM_NEON=m
-CONFIG_CRYPTO_SHA256_ARM=m
-CONFIG_CRYPTO_SHA512_ARM=m
-CONFIG_CRYPTO_AES_ARM=m
-CONFIG_CRYPTO_AES_ARM_BS=m
-CONFIG_CRYPTO_GHASH_ARM_CE=m
-CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRC_CCITT=y
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
@@ -550,3 +543,10 @@ CONFIG_LIBCRC32C=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_SPLIT=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SCHEDSTATS=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
-- 
2.20.1
