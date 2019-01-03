From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH v2 0/2] Add input voltage configuration for TPS65218
Date: Thu, 3 Jan 2019 14:47:04 +0100
Message-ID: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch allows to configure input-voltage settings
of the TPS65218 regulator via device tree.

Changes for v2:
 - handle the different options in separate functions
 - add "ti," prefix and "-microvolt" postfix
 - remove debug prints
 - abort with an error in case of invalid values.
 - extend documentation of the options (taken from the datasheet)

Christian Hohnstaedt (2):
  dt-bindings: regulator: extend tps65218 bindings
  mfd: tps65218.c: Add input voltage options

 .../devicetree/bindings/regulator/tps65218.txt     | 22 ++++++
 drivers/mfd/tps65218.c                             | 87 ++++++++++++++++++++++
 include/linux/mfd/tps65218.h                       |  4 +
 3 files changed, 113 insertions(+)

-- 
2.7.4
