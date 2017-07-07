From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/2] regulator: cpcap: Fix standby mode
Date: Fri,  7 Jul 2017 22:08:11 +0200
Message-ID: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This fixes standby mode of vaudio on Motorola Droid 4.

-- Sebastian

Sebastian Reichel (2):
  regulator: cpcap: Fix standby mode
  ARM: dts: motorola-cpcap-mapphone: set initial mode for vaudio

 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi |  1 +
 drivers/regulator/cpcap-regulator.c            | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.13.2
