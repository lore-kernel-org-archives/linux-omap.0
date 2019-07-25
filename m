From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/3]  regulator: twl6030: Fix the VMMC reset behavior
Date: Thu, 25 Jul 2019 11:45:39 +0200
Message-ID: <20190725094542.16547-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>
List-Id: linux-omap@vger.kernel.org

Hello,

With the TWL6030 PMIC, during reset the VMMC regulator doesn't reach
0V and only drops to 1.8V, furthermore the pulse width is under 200us
whereas the SD specification expect 1ms.

Fortunately, the WR_S bit allows the TWL6030 to no reset at all the
VMMC during warm reset and keep the current voltage. Thanks to this
workaround the SD card doesn't reach a undefined reset stage.

The first patch describes the new property needed for this "feature".

The second one is just a small cleanup done while I wrote the last
patch, but as it was not really related to the feature itself, I made
a separate patch for it.

The last patch adds the feature in the driver.

Gregory

Gregory CLEMENT (3):
  dt-bindings: regulator: twl6030: Add retain-on-reset property
  regulator: twl6030: use variable for device node
  regulator: twl6030: workaround the VMMC reset behavior

 .../bindings/regulator/twl-regulator.txt      |  7 +++++++
 drivers/regulator/twl6030-regulator.c         | 21 +++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.20.1
