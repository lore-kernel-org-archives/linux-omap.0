From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: omap2plus_defconfig: Enable n900 modem as loadable
 modules
Date: Mon, 16 Mar 2015 13:00:03 -0700
Message-ID: <1426536003-7077-4-git-send-email-tony@atomide.com>
References: <1426536003-7077-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426536003-7077-1-git-send-email-tony@atomide.com>
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
Cc: Sebastian Reichel <sre@ring0.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Enable n900 modem as loadable modules.

Cc: Sebastian Reichel <sre@ring0.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6c7722d..cd1c0f3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -87,6 +87,7 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 # CONFIG_INET_LRO is not set
 CONFIG_NETFILTER=y
+CONFIG_PHONET=m
 CONFIG_CAN=m
 CONFIG_CAN_C_CAN=m
 CONFIG_CAN_C_CAN_PLATFORM=m
@@ -178,6 +179,7 @@ CONFIG_USB_EPSON2888=y
 CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_KC2190=y
+CONFIG_USB_CDC_PHONET=m
 CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_USB=m
 CONFIG_LIBERTAS_SDIO=m
@@ -224,6 +226,11 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_TI_QSPI=m
+CONFIG_HSI=m
+CONFIG_OMAP_SSI=m
+CONFIG_NOKIA_MODEM=m
+CONFIG_SSI_PROTOCOL=m
+CONFIG_HSI_CHAR=m
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
@@ -348,6 +355,7 @@ CONFIG_USB_CONFIGFS_ECM=y
 CONFIG_USB_CONFIGFS_ECM_SUBSET=y
 CONFIG_USB_CONFIGFS_RNDIS=y
 CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_PHONET=y
 CONFIG_USB_CONFIGFS_MASS_STORAGE=y
 CONFIG_USB_CONFIGFS_F_LB_SS=y
 CONFIG_USB_CONFIGFS_F_FS=y
@@ -356,6 +364,7 @@ CONFIG_USB_CONFIGFS_F_UAC2=y
 CONFIG_USB_CONFIGFS_F_MIDI=y
 CONFIG_USB_CONFIGFS_F_HID=y
 CONFIG_USB_ZERO=m
+CONFIG_USB_G_NOKIA=m
 CONFIG_MMC=y
 CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
@@ -405,6 +414,7 @@ CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_FS_XATTR=y
-- 
2.1.4
