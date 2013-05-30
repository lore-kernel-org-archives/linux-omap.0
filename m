From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v2 0/3] PM / AVS: SmartReflex: driver misc fixes
Date: Thu, 30 May 2013 13:08:33 +0300
Message-ID: <1369908516-26573-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: khilman@linaro.org, j-keerthy@ti.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The following patch series contain several misc fixes to SmartReflex driver:

1. disable errgen before vpbound disable. Critical fix, needed for
proper work of AVS-VP communicaton protocol.

2. disable runtime PM on driver remove. Trivial - runtime PM cleanup.

3. fix driver name. Trivial - proper DRIVER_NAME was not defined
since SmartReflex driver was introduced with initial commit.

Patches are based on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
tag: v3.10-rc3

Verified on OMAP4430. Boot - OK. SmartReflex registers debug dump - OK

Changes in v2:
- rebased to v3.10-rc3
- minor comment update in "disable errgen before vpbound disable" patch

Andrii Tseglytskyi (2):
  PM / AVS: SmartReflex: disable runtime PM on driver remove
  PM / AVS: SmartReflex: fix driver name

Nishanth Menon (1):
  PM / AVS: SmartReflex: disable errgen before vpbound disable

 drivers/power/avs/smartreflex.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
1.7.9.5

