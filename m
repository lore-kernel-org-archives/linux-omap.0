From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 6/7] ARM: omap2plus_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device modes)
Date: Tue, 19 Dec 2017 15:01:32 +0530
Message-ID: <20171219093133.16565-7-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Enable CONFIG_PCI_DRA7XX in order to be able to configure PCIe
controller present in dra7 SoCs in both host mode and device mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 7b97200c1d64..a01871d5aa73 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -48,6 +48,13 @@ CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DRA7XX=y
+CONFIG_PCI_DRA7XX_EP=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=m
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMA=y
@@ -137,6 +144,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_TSL2550=m
 CONFIG_SRAM=y
+CONFIG_PCI_ENDPOINT_TEST=m
 CONFIG_EEPROM_AT24=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
-- 
2.11.0
