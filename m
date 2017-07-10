From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 0/3] regulator: cpcap: Fix standby mode
Date: Mon, 10 Jul 2017 16:33:38 +0200
Message-ID: <20170710143341.25543-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This fixes standby mode of vaudio on Motorola Droid 4.

Changes since PATCHv1:
 * return -EINVAL for invalid modes
 * Split driver change into two patches, since two things are changed
 * Add Acked-by from Tony

-- Sebastian

Sebastian Reichel (3):
  regulator: cpcap: Fix standby mode
  regulator: cpcap: Add OF mode mapping
  ARM: dts: motorola-cpcap-mapphone: set initial mode for vaudio

 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi |  1 +
 drivers/regulator/cpcap-regulator.c            | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.13.2
