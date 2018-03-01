From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] ARM: omap2plus_defconfig: Drop unneeded options
Date: Thu,  1 Mar 2018 14:17:00 -0800
Message-ID: <20180301221704.104530-7-tony@atomide.com>
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

These are no longer needed because:

- PCI_DRA7XX_HOST selects PCI_DRA7XX

- USB_NET_QMI_WWAN selects USB_WDM

- USB_PHY selects EXTCON

- IIO_CONFIGFS selects CONFIGFS_FS

- TIMER_STATS option no longer exists

- CRYPTO_SHA1_ARM_NEON selects CRYPTO_SHA1_ARM

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -50,7 +50,6 @@ CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-CONFIG_PCI_DRA7XX=y
 CONFIG_PCI_DRA7XX_EP=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
@@ -394,7 +393,6 @@ CONFIG_USB_MON=m
 CONFIG_USB_XHCI_HCD=m
 CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_OHCI_HCD=m
-CONFIG_USB_WDM=m
 CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=m
 CONFIG_USB_MUSB_HDRC=m
@@ -471,7 +469,6 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_OMAP=y
 CONFIG_TI_EDMA=y
 CONFIG_OMAP_IOMMU=y
-CONFIG_EXTCON=m
 CONFIG_EXTCON_PALMAS=m
 CONFIG_EXTCON_USB_GPIO=m
 CONFIG_TI_EMIF=m
@@ -503,7 +500,6 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_FS_XATTR=y
@@ -524,13 +520,11 @@ CONFIG_DEBUG_INFO_SPLIT=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_SCHEDSTATS=y
-CONFIG_TIMER_STATS=y
 CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_ARM_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
-- 
2.16.2
