From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH v2 0/2] regulator: tps65218: support LS2
Date: Mon, 25 Feb 2019 07:41:04 +0100
Message-ID: <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add support for the LS2 regulator in the tps65218 device


Christian Hohnstaedt (2):
  dt-bindings: regulator: Add LS2 load switch documentation
  regulator: tps65218: Add support for LS2

 .../devicetree/bindings/regulator/tps65218.txt         |  4 ++--
 drivers/regulator/tps65218-regulator.c                 | 18 +++++++++++++-----
 include/linux/mfd/tps65218.h                           |  3 ++-
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.7.4
