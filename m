From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v2 0/2] PM / AVS: SmartReflex: optimization series
Date: Tue, 4 Jun 2013 12:58:31 +0300
Message-ID: <1370339913-16135-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: khilman@linaro.org, j-keerthy@ti.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The following patch series introduces a few optimizations for SmartReflex driver.

1. devm_* API usage for SmartReflex.
Benefits:
- auto handling of resources - allocation/auto free, map/auto unmap.
- lot of error checks can be dropped.

2. Another small optimization resolves order of initialization between SmartReflex driver
and SmartReflex class. Class is initialized before driver.

Patches are based on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
tag: v3.10-rc4

Verified on OMAP4430. Boot - OK. SmartReflex registers debug dump - OK

Series v2 contains:
- spurious #define removed from "PM / AVS: SmartReflex: use devm_* API to initialize SmartReflex"
- rebased to v3.10-rc4

Andrii Tseglytskyi (2):
  PM / AVS: SmartReflex: use devm_* API to initialize SmartReflex
  PM / AVS: SmartReflex/class3: Fix order of initialization of SR class
    and SR driver

 arch/arm/mach-omap2/smartreflex-class3.c |    2 +-
 drivers/power/avs/smartreflex.c          |   85 ++++++++----------------------
 2 files changed, 22 insertions(+), 65 deletions(-)

-- 
1.7.9.5

