From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 00/20] mfd: Add devm_ apis for mfd_add_devices and mfd_release_devices
Date: Fri, 8 Apr 2016 00:12:54 +0530
Message-ID: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: lee.jones@linaro.org, corbet@lwn.net, andreas.werner@men.de, tony@atomide.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

This series add devm_ version of the APIs mfd_add_devices() and 
mfd_release_devices() and get rid of call for mfd_release_devices()
some places and also remove the need of .remove callbacks as this
is not needed.

Changes from V1:
- Remove devm_mfd_remove_devices() as it is not required.
- Convert mfd to MFD on all commit message.
- Handles the comment received from V1 patch like better error handling,
  APIs description.
- Collected acks and reviewed by.
- Run checkpatch --strict on all patches and fix alignment error.

Laxman Dewangan (20):
  mfd: Add resource managed apis for mfd_add_devices
  mfd: Add devm_mfd_add_devices() in list of managed interfaces
  mfd: act8945a: Use devm_mfd_add_devices() for mfd_device registration
  mfd: as3711: Use devm_mfd_add_devices() for mfd_device registration
  mfd: atmel-hlcdc: Use devm_mfd_add_devices() for mfd_device
    registration
  mfd: bcm590xx: Use devm_mfd_add_devices() for mfd_device registration
  mfd: hi6421-pmic: Use devm_mfd_add_devices() for mfd_device
    registration
  mfd: lp3943: Use devm_mfd_add_devices() for mfd_device registration
  mfd: menf21bmc: Use devm_mfd_add_devices() for mfd_device registration
  mfd: mt6397: Use devm_mfd_add_devices() for mfd_device registration
  mfd: rdc321x: Use devm_mfd_add_devices() for mfd_device registration
  mfd: rk808: Use devm_mfd_add_devices() for mfd_device registration
  mfd: rn5t618: Use devm_mfd_add_devices() for mfd_device registration
  mfd: rt5033: Use devm_mfd_add_devices() for mfd_device registration
  mfd: sky81452: Use devm_mfd_add_devices() for mfd_device registration
  mfd: stw481x: Use devm_mfd_add_devices() for mfd_device registration
  mfd: tps6507x: Use devm_mfd_add_devices() for mfd_device registration
  mfd: tps65217: Use devm_mfd_add_devices() for mfd_device registration
  mfd: tps65910: Use devm_mfd_add_devices() for mfd_device registration
  mfd: wm8400: Use devm_mfd_add_devices() for mfd_device registration

 Documentation/driver-model/devres.txt |  3 +++
 drivers/mfd/act8945a.c                | 13 +++---------
 drivers/mfd/as3711.c                  | 11 +---------
 drivers/mfd/atmel-hlcdc.c             | 10 +--------
 drivers/mfd/bcm590xx.c                |  9 +--------
 drivers/mfd/hi6421-pmic-core.c        | 10 +--------
 drivers/mfd/lp3943.c                  | 14 +++----------
 drivers/mfd/menf21bmc.c               |  9 +--------
 drivers/mfd/mfd-core.c                | 38 +++++++++++++++++++++++++++++++++++
 drivers/mfd/mt6397-core.c             | 12 ++---------
 drivers/mfd/rdc321x-southbridge.c     |  8 +-------
 drivers/mfd/rk808.c                   |  3 +--
 drivers/mfd/rn5t618.c                 |  3 +--
 drivers/mfd/rt5033.c                  | 10 +--------
 drivers/mfd/sky81452.c                | 10 ++-------
 drivers/mfd/stw481x.c                 |  9 +--------
 drivers/mfd/tps6507x.c                | 11 +---------
 drivers/mfd/tps65217.c                | 12 +----------
 drivers/mfd/tps65910.c                |  3 +--
 drivers/mfd/wm8400-core.c             | 25 +++--------------------
 include/linux/mfd/core.h              |  4 ++++
 21 files changed, 71 insertions(+), 156 deletions(-)

-- 
2.1.4

