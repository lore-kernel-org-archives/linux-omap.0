From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 0/3] Add device tree support for AM33XX regulators
Date: Mon, 25 Jun 2012 17:34:35 +0530
Message-ID: <1340625878-32336-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add device tree support for regulators present on AM33XX family of
devices like AM335X-EVM and AM335X-Bone. TPS65217 regulator is present
on AM335X-Bone and TPS65910 on AM335X-EVM.

First patch adds the device tree support to tps65217 regulator so
that it will take the parameters from am335x-bone.dts file and
convert to regulator parameters.

Second patch adds tps65217 device tree data to am335x-bone.dts file
with i2c salve address. Created seperate file tps65217, which contains
the generic tps65217 device tree data. 

Third patch adds tps65910 device tree data to am335x-evm.dts file
with i2c salve address. Created seperate file tps65910, which contains
the generic tps65910 device tree data.

These patches were tested along with these patches
* DT addition to AM33XX family
http://marc.info/?l=linux-omap&m=134035826700991&w=2

AnilKumar Ch (3):
  regulator: tps65217: Add device tree support
  ARM: OMAP2+: AM33XX: Add tps65217 device tree data
  ARM: OMAP2+: AM33XX: Add tps65910 device tree data

 .../devicetree/bindings/regulator/tps65217.txt     |   66 +++++++++++++++++
 arch/arm/boot/dts/am335x-bone.dts                  |   10 +++
 arch/arm/boot/dts/am335x-evm.dts                   |   10 +++
 arch/arm/boot/dts/tps65217.dtsi                    |   67 +++++++++++++++++
 arch/arm/boot/dts/tps65910.dtsi                    |   76 ++++++++++++++++++++
 drivers/mfd/tps65217.c                             |   67 ++++++++++++++++-
 drivers/regulator/tps65217-regulator.c             |    1 +
 include/linux/mfd/tps65217.h                       |    3 +-
 8 files changed, 297 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65217.txt
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

-- 
1.7.9.5
