From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/2] omap-ssi: clk change support
Date: Sun, 31 Jan 2016 01:52:36 +0100
Message-ID: <1454201558-31285-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

During diffing the n950 with the mainline kernel I noticed, that the main
difference is additional DVFS support. These patches import those differences
(forward-ported to pinctrl & common clock framework) to the mainline kernel.

-- Sebastian

Sebastian Reichel (2):
  ARM: dts: OMAP3-N950-N9: Add ssi idle pinctrl state
  HSI: omap-ssi: add clk change support

 arch/arm/boot/dts/omap3-n950-n9.dtsi    | 16 ++++++++-
 drivers/hsi/controllers/omap_ssi.c      | 63 +++++++++++++++++++++++++++++++++
 drivers/hsi/controllers/omap_ssi.h      |  6 ++++
 drivers/hsi/controllers/omap_ssi_port.c | 20 +++++++++++
 4 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.7.0.rc3
