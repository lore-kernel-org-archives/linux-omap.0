From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH 0/2] Add input voltage configuration for TPS65218
Date: Tue, 18 Dec 2018 09:05:54 +0100
Message-ID: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch allows to configure input-voltage settings
of the TPS65218 regulator via device tree.

Christian Hohnstaedt (2):
  dt-bindings: regulator: extend tps65218 bindings
  mfd: tps65218.c: Add input voltage options

 .../devicetree/bindings/regulator/tps65218.txt     | 10 +++++
 drivers/mfd/tps65218.c                             | 46 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)

-- 
2.7.4
