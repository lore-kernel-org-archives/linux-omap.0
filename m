From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Update for dropped options
Date: Mon,  4 Feb 2019 12:37:46 -0800
Message-ID: <20190204203747.7376-1-tony@atomide.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These are automatically selected with make multi_v7_defconfig,
except for SH_DMAE which is selected only by sound/soc/sh/Kconfig.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -227,7 +227,6 @@ CONFIG_VIRTIO_NET=y
 CONFIG_B53_SPI_DRIVER=m
 CONFIG_B53_MDIO_DRIVER=m
 CONFIG_B53_MMAP_DRIVER=m
-CONFIG_B53_SRAB_DRIVER=m
 CONFIG_NET_DSA_BCM_SF2=m
 CONFIG_SUN4I_EMAC=y
 CONFIG_BCMGENET=m
@@ -256,7 +255,6 @@ CONFIG_BROADCOM_PHY=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MARVELL_PHY=y
 CONFIG_MICREL_PHY=y
-CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_PEGASUS=y
@@ -871,7 +869,6 @@ CONFIG_UNIPHIER_MDMAC=y
 CONFIG_XILINX_DMA=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_DW_DMAC=y
-CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
 CONFIG_RENESAS_USB_DMAC=m
 CONFIG_VIRTIO_PCI=y
-- 
2.20.1
