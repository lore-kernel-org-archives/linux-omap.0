From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 0/3] Coupled-regulators follow up
Date: Mon, 19 Nov 2018 00:56:15 +0300
Message-ID: <20181118215619.21518-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This is a follow up to [0].

What's changed in v2:

  - The "Use ww_mutex for regulators locking" patch compiles now for the
    drivers that are touching "rdev's" mutex, in a result regulator_[un]lock()
    functions are public now.

  - Added new patch to the series ("Keep regulators-list locked while
    traversing the list") which further firms regulators locking.

  - Changed commit description of the "Change regulator-coupled-max-spread
    property" patch, saying that it's fine to change the binding because
    property doesn't have any users yet. That was requested by Rob Herring
    in the review comment to v1.

[0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=69250

Dmitry Osipenko (3):
  regulator: core: Use ww_mutex for regulators locking
  regulator: core: Properly handle case where supply is the couple
  regulator: core: Keep regulators-list locked while traversing the list

 drivers/regulator/core.c              | 425 ++++++++++++++++++++------
 drivers/regulator/da9210-regulator.c  |   4 +-
 drivers/regulator/stpmic1_regulator.c |   4 +-
 drivers/regulator/wm8350-regulator.c  |   4 +-
 include/linux/regulator/driver.h      |   6 +-
 5 files changed, 339 insertions(+), 104 deletions(-)

-- 
2.19.1
