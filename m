From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ARM: dts: am437x boards: Correct (again) tps65218 irq type
Date: Tue, 8 May 2018 16:20:49 +0300
Message-ID: <20180508132053.5471-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

While based on the datasheet of tps65218 the INT is low active, the GIC_SPI
does not support anythin but IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING:

[    2.761814] genirq: Setting trigger mode 8 for irq 102 failed (irq_chip_set_type_parent+0x0/0x30)
[    2.770913] tps65218 0-0024: Failed to request IRQ 102 for tps65218: -22
[    2.777854] tps65218: probe of 0-0024 failed with error -22

Use LEVEL_HIGH for the interrupt as it looks to be the correct setting:
INTn of tps65218 is connected to NMIn of the SoC.

The offending patches are only in linux-next.

Regards,
Peter
---
Peter Ujfalusi (4):
  ARM: dts: am437x-gp-evm: Fixup (again) tps65218 irq type
  ARM: dts: am437x-cm-t43: Fixup (again) tps65218 irq type
  ARM: dts: am437x-epos-evm: Fixup (again) tps65218 irq type
  Revert "ARM: dts: am437x-sk-evm: Correct tps65218 irq type"

 arch/arm/boot/dts/am437x-cm-t43.dts  | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts  | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
