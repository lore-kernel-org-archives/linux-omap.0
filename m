From: J Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/4] MFD: Palmas: Add TPS659038 PMIC support on Palmas
Date: Tue, 18 Jun 2013 15:31:28 +0530
Message-ID: <1371549692-7361-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@kernel.org, j-keerthy@ti.com, ldewangan@nvidia.com, sameo@linux.intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

The Patch series adds TPS659038 PMIC support in the palmas MFD and Regulator
drivers. The TPS659038 has almost the same registers as of the earlier
supported variants of PALMAS family such as the TWL6035.

The critical differences between TPS659038 and TWL6035 being:

1) TPS659038 has nothing related to battery charging and back up battery stuff.
2) TPS659038 does not have does not have SMPS10(Boost) step up convertor.
3) TPS659038 does not have Battery detection and anything related to battery.
4) SD card detection, Battery presence detection, Vibrator, USB OTG are missing
   when compared to TWL6035.

The patch series is based on the patch:
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90598.html

V2:

Implemented Interrupts checking via DT instead of creating flags
and checking based on chip ID.
 
J Keerthy (4):
  MFD: Palmas: Check if interrupts property exists and then only
    request irq
  MFD: Palmas: Add SMPS10_BOOST feature
  mfd: Palmas: Add TPS659038 PMIC support
  regulator: Palmas: Add TPS659038 support

 Documentation/devicetree/bindings/mfd/palmas.txt   |    2 +
 .../devicetree/bindings/regulator/palmas-pmic.txt  |    1 +
 drivers/mfd/palmas.c                               |   45 ++++++++++++++++----
 drivers/regulator/palmas-regulator.c               |    4 ++
 include/linux/mfd/palmas.h                         |   14 ++++++
 5 files changed, 58 insertions(+), 8 deletions(-)

-- 
1.7.5.4

