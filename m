From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] DRA7x: Increase QSPI frequency to 64MHz
Date: Thu, 14 Apr 2016 15:48:19 +0530
Message-ID: <1460629101-24309-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>, nsekhar@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


This patch series increases QSPI bus frequency to 64MHz and switch to
SPI mode 0 in order to increase read/write throughput.
First patch removes QSPI pinmux from DT as pinmux can only be done in
U-Boot(see patch commit message for more info). Second patch does the
dts changes to support 64MHz mode 0 operation.


Tested on DRA74 and DRA72 EVM with U-Boot 2016.05-rc1.

Vignesh R (2):
  ARM: dts: dra7x: Remove QSPI pinmux
  ARM: dts: dra7x: Support QSPI MODE-0 operation at 64MHz

 Documentation/devicetree/bindings/spi/ti_qspi.txt |  7 +++++++
 arch/arm/boot/dts/dra7-evm.dts                    | 23 ++---------------------
 arch/arm/boot/dts/dra72-evm.dts                   | 20 ++------------------
 3 files changed, 11 insertions(+), 39 deletions(-)

-- 
2.8.1
