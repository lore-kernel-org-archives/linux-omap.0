From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/4] fixes for latest bq27xxx driver and OpenPandora DT nodes
Date: Thu, 31 Aug 2017 08:59:49 +0200
Message-ID: <cover.1504162792.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: afd@ti.com, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Latest bq27xxx drivers allow to write RAM/NVRAM parameters
of the fuel gauge chip from values defined in board specific
device tree.

This allows to specify the battery properties of a standard
battery.

This patch set enables this for two chips where I have tested
it on real devices:

bq27421: Pyra handheld prototype
bq27500: OpenPandora 600 Mhz standard device

Since the Pyra DT is not yet mainlined, there are only DT
patches for the OpenPandora.

H. Nikolaus Schaller (4):
  power: supply: bq27xxx: enable writing capacity values for bq27421
  power: supply: bq27xxx: enable writing capacity values for bq27500
  DT: OpenPandora: add battery node to describe OpenPandora battery
  DT: OpenPandora: fix for configuration of bq27500 fuel gauge

 arch/arm/boot/dts/omap3-pandora-common.dtsi | 11 ++++++++++-
 drivers/power/supply/bq27xxx_battery.c      |  8 --------
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.12.2
