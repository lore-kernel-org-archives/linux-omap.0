From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra72-evm: Add i2c1 and tps65917 nodes
Date: Mon, 28 Jul 2014 11:48:52 +0530
Message-ID: <1406528334-4415-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: nm@ti.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, galak@codeaurora.org, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

The patch series adds i2c1 and tps65917 and related nodes.
The patch series is boot tested on DRA72-EVM.

Thanks to Lokesh <lokeshvutla@ti.com> for testing the series.

Keerthy J (2):
  ARM: dts: dra72-evm: Enable I2C1 node
  ARM: dts: dra72-evm: Add tps65917 PMIC node

 arch/arm/boot/dts/dra72-evm.dts |  120 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

-- 
1.7.9.5
