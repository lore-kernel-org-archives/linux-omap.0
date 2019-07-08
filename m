From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/2] DTS: ARM: some minor updates and fixes for GTA04
Date: Mon,  8 Jul 2019 16:46:03 +0200
Message-ID: <cover.1562597164.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: letux-kernel@openphoenux.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

We define define chosen/stdout-path chosen to remove the
console= entry in the kernel command line.

And we fix the SPI definition to make the LCD panel work
again.

H. Nikolaus Schaller (2):
  DTS: ARM: gta04: define chosen/stdout-path
  DTS: ARM: gta04: introduce legacy spi-cs-high to make display work
    again

 Documentation/devicetree/bindings/spi/spi-bus.txt | 6 ++++++
 arch/arm/boot/dts/omap3-gta04.dtsi                | 5 +++++
 2 files changed, 11 insertions(+)

-- 
2.19.1
