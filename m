From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 00/14] mfd: convert subsystem to i2c_new_dummy_device()
Date: Mon, 22 Jul 2019 19:26:07 +0200
Message-ID: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This series is part of a tree-wide movement to replace the I2C API call
'i2c_new_dummy' which returns NULL with its new counterpart returning an
ERRPTR.

The series was generated with coccinelle (audited afterwards, of course) and
build tested by me and by buildbot. No tests on HW have been performed.

The branch is based on v5.3-rc1. A branch (with some more stuff included) can
be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/new_dummy

Some drivers still need to be manually converted. Patches for those will be
sent out individually.


Wolfram Sang (14):
  mfd: 88pm800: convert to i2c_new_dummy_device
  mfd: 88pm860x-core: convert to i2c_new_dummy_device
  mfd: ab3100-core: convert to i2c_new_dummy_device
  mfd: bcm590xx: convert to i2c_new_dummy_device
  mfd: da9150-core: convert to i2c_new_dummy_device
  mfd: max14577: convert to i2c_new_dummy_device
  mfd: max77693: convert to i2c_new_dummy_device
  mfd: max77843: convert to i2c_new_dummy_device
  mfd: max8907: convert to i2c_new_dummy_device
  mfd: max8925-i2c: convert to i2c_new_dummy_device
  mfd: max8997: convert to i2c_new_dummy_device
  mfd: max8998: convert to i2c_new_dummy_device
  mfd: palmas: convert to i2c_new_dummy_device
  mfd: twl-core: convert to i2c_new_dummy_device

 drivers/mfd/88pm800.c       | 12 ++++++------
 drivers/mfd/88pm860x-core.c |  6 +++---
 drivers/mfd/ab3100-core.c   |  6 +++---
 drivers/mfd/bcm590xx.c      |  6 +++---
 drivers/mfd/da9150-core.c   |  6 +++---
 drivers/mfd/max14577.c      |  6 +++---
 drivers/mfd/max77693.c      | 12 ++++++------
 drivers/mfd/max77843.c      |  6 +++---
 drivers/mfd/max8907.c       |  6 +++---
 drivers/mfd/max8925-i2c.c   | 12 ++++++------
 drivers/mfd/max8997.c       | 18 +++++++++---------
 drivers/mfd/max8998.c       |  6 +++---
 drivers/mfd/palmas.c        |  6 +++---
 drivers/mfd/twl-core.c      |  6 +++---
 14 files changed, 57 insertions(+), 57 deletions(-)

-- 
2.20.1
