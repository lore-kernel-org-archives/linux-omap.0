From: Satish Patel <satish.patel@ti.com>
Subject: [PATCH v3 0/5] Smart Card(SC) interface, TI USIM & NxP SC phy driver
Date: Wed, 28 May 2014 14:27:12 +0530
Message-ID: <1401267437-22489-1-git-send-email-satish.patel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, rob@landley.net, tony@atomide.com
Cc: grant.likely@linaro.org, robh+dt@kernel.org, Satish Patel <satish.patel@ti.com>
List-Id: linux-omap@vger.kernel.org

Changes since v2:
* RFC comments are fixed for all 

* ti-usim:
** synchronous card support is added
** Timeout added for ATR 
** BWT configuration
** softreset of IP at initialization added
** PM suspend/resume support added

* sc_phy : sync card support is added
* ARM: dts: AM43xx: fck clock entry is added to usim

v1 cover letter link#
https://lkml.org/lkml/2014/1/6/250

v2 cover letter link#
https://lkml.org/lkml/2014/1/19/168

Satish Patel (5):
  sc_phy:SmartCard(SC) PHY interface to SC controller
  misc: tda8026: Add NXP TDA8026 PHY driver
  char: ti-usim: Add driver for USIM module on AM43xx
  ARM: dts: AM43xx: DT entries added for ti-usim
  ARM: dts: AM43xx-epos-evm: DT entries  for ti-usim and phy

 Documentation/devicetree/bindings/misc/tda8026.txt |   19 +
 .../devicetree/bindings/ti-usim/ti-usim.txt        |   32 +
 Documentation/sc_phy.txt                           |  171 ++
 arch/arm/boot/dts/am4372.dtsi                      |   12 +
 arch/arm/boot/dts/am43x-epos-evm.dts               |   31 +
 drivers/char/Kconfig                               |    7 +
 drivers/char/Makefile                              |    1 +
 drivers/char/ti-usim-hw.h                          |  864 ++++++++
 drivers/char/ti-usim.c                             | 2213 ++++++++++++++++++++
 drivers/misc/Kconfig                               |    7 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/tda8026.c                             | 1258 +++++++++++
 include/linux/sc_phy.h                             |  136 ++
 include/linux/ti-usim.h                            |  111 +
 14 files changed, 4863 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/tda8026.txt
 create mode 100644 Documentation/devicetree/bindings/ti-usim/ti-usim.txt
 create mode 100644 Documentation/sc_phy.txt
 create mode 100644 drivers/char/ti-usim-hw.h
 create mode 100644 drivers/char/ti-usim.c
 create mode 100644 drivers/misc/tda8026.c
 create mode 100644 include/linux/sc_phy.h
 create mode 100644 include/linux/ti-usim.h

-- 
1.7.9.5
