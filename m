From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 0/4] gpiolib: fix issues with legacy spi-cs-high handling
Date: Sun, 31 Mar 2019 12:07:19 +0200
Message-ID: <cover.1554026842.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

2018-07-25 07:55:28: 

H. Nikolaus Schaller (4):
  DTS: GTA04: SPI / gpiolib: work around a regression that unhides a
    broken legacy handler, which makes the gta04 display inoperable
  REVERT: DTS: GTA04: SPI / gpiolib: no no no, we do not want to "fix"
    our device tree file
  gpiolib: make legacy handling for spi-cs-high optional
  gpiolib: spi-cs-high is checking the wrong node (the controller and
    not the SPI slave device)

 drivers/gpio/Kconfig      | 8 ++++++++
 drivers/gpio/gpiolib-of.c | 8 +++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.19.1
