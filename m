From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH 0/3] regulator: tps65218: Fix LS3 and add LS2
Date: Wed, 20 Feb 2019 09:15:49 +0100
Message-ID: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch-series fixes issues in the LS3 configuration
and adds support for the LS2 regulator in the tps65218

Christian Hohnstaedt (3):
  regulator: tps65218.c: fix LS3 issues
  dt-bindings: regulator: Add LS2 load switch
  regulator: tps65218: Add support for LS2

 .../devicetree/bindings/regulator/tps65218.txt     |  9 +++++++--
 drivers/regulator/tps65218-regulator.c             | 23 +++++++++++++++-------
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.7.4
