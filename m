From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v02 0/2] ARM: DTS: am33xx/am437x: Use the new eDMA bindings
Date: Thu, 17 Dec 2015 15:33:35 +0200
Message-ID: <1450359217-3038-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, tony@atomide.com
Cc: nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vinod.koul@intel.com, balbi@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- Updated to use the non 16bit arrays [1]
- send the two patch as a series

[1]
As it has been discussed earlier:
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg122117.html

the DT bindings has been changes compared to what we had in 4.4-rc1: the arrays
now don't have the 16bit type.
The changes are now merged to mainline and Vinod provided us a branch:

git://git.infradead.org/users/vkoul/slave-dma.git fix/edma

Which is based on 4.4-rc1 and only contains the two patch for changing the eDMA
bindings.

Regards,
Peter
---

Peter Ujfalusi (2):
  ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
  ARM: DTS: am437x: Use the new DT bindings for the eDMA3

 arch/arm/boot/dts/am335x-evm.dts    |  9 +---
 arch/arm/boot/dts/am335x-pepper.dts | 11 +----
 arch/arm/boot/dts/am33xx.dtsi       | 94 ++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/am4372.dtsi       | 80 +++++++++++++++++++++++--------
 arch/arm/boot/dts/am437x-gp-evm.dts |  9 +---
 5 files changed, 133 insertions(+), 70 deletions(-)

-- 
2.6.4
