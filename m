From: Kevin Hilman <khilman@linaro.org>
Subject: [GIT PULL] PM / AVS: SmartReflex: misc. cleanups for v3.11
Date: Thu, 13 Jun 2013 15:16:30 -0700
Message-ID: <87r4g5ac75.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Rafael,

Please pull the following cleanups to  AVS/SmartReflex for v3.11.

Thanks,

Kevin

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.11/avs

for you to fetch changes up to efca406b940e93e6af38c597eecd5fb79b39b7ea:

  PM / AVS: SmartReflex: use devm_* API to initialize SmartReflex (2013-06-10 10:50:48 -0700)

----------------------------------------------------------------
PM / AVS: SmartReflex: misc. cleanups for v3.11

----------------------------------------------------------------
Andrii Tseglytskyi (6):
      PM / AVS: SmartReflex: disable runtime PM on driver remove
      PM / AVS: SmartReflex: fix driver name
      PM / AVS: SmartReflex: use omap_sr * for errgen interfaces
      PM / AVS: SmartReflex: use omap_sr * for minmax interfaces
      PM / AVS: SmartReflex: use omap_sr * for enable/disable interface
      PM / AVS: SmartReflex: use devm_* API to initialize SmartReflex

Nishanth Menon (1):
      PM / AVS: SmartReflex: disable errgen before vpbound disable

 arch/arm/mach-omap2/smartreflex-class3.c |   8 +-
 drivers/power/avs/smartreflex.c          | 154 +++++++++++++------------------
 include/linux/power/smartreflex.h        |  10 +-
 3 files changed, 72 insertions(+), 100 deletions(-)
