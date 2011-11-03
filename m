From: Kyle Manna <kyle.manna@fuel7.com>
Subject: [PATCH v3 0/6] mfd: TPS65910: Bug fixes and enhancements
Date: Thu,  3 Nov 2011 12:08:00 -0500
Message-ID: <1320340086-15371-1-git-send-email-kyle.manna@fuel7.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kyle Manna <kyle.manna@fuel7.com>
List-Id: linux-omap@vger.kernel.org

This series of patches fixes a number of small problems with the TPS65910 that
were discovered on a custom board.

Additionally, the last patch enhances the platform to driver interface.

Changes from v1 based on feedback from Mark Brown:
* Drop the patch #5 from pervious series.  It worked around a bug created by 
  another patch.
* Rework patch #6 completely.

Changes from v2:
* Enhance TPS65910 detection logic by reading a register
* Correct commit subjects to reflect correct subsystems
* Added Mark Brown's ACKs to the regulator patches


[1] https://lkml.org/lkml/2011/10/19/182
[2] https://lkml.org/lkml/2011/10/19/191

Kyle Manna (6):
  mfd: TPS65910: Handle non-existent devices
  mfd: TPS65910: Add I2C slave address macros
  mfd: TPS65910: Fix typo that clobbers genirq
  mfd: TPS65910: Move linux/gpio.h include to header
  regulator: TPS65910: Move regulator defs to header
  regulator: TPS65910: Create an array for init data

 drivers/mfd/tps65910.c                 |   25 ++++++++++++++-------
 drivers/regulator/tps65910-regulator.c |   37 ++++++++-----------------------
 include/linux/mfd/tps65910.h           |   37 +++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 36 deletions(-)

-- 
1.7.5.4
