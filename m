From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH v1 0/3] PM / AVS: SmartReflex: driver misc fixes
Date: Mon, 27 May 2013 14:07:23 +0300
Message-ID: <1369652846-14412-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, J Keerthy <j-keerthy@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The following patch series contain several misc fixes to SmartReflex driver:

1. disable errgen before vpbound disable. Critical fix, needed for
proper work of AVS-VP communicaton protocol.

2. disable runtime PM on driver remove. Trivial - runtime PM cleanup.

3. fix driver name. Trivial - proper DRIVER_NAME was not defined
since SmartReflex driver was introduced with initial commit.

Patches are based on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
tag: v3.10-rc2

Verified on OMAP4430. Boot - OK. SmartReflex registers debug dump - OK

Available on GitHub:
https://github.com/andriit/linux-omap-k3.8/commits/avs_sr_driver_misc_fixes_v01

Andrii Tseglytskyi (2):
  PM / AVS: SmartReflex: disable runtime PM on driver remove
  PM / AVS: SmartReflex: fix driver name

Nishanth Menon (1):
  PM / AVS: SmartReflex: disable errgen before vpbound disable

 drivers/power/avs/smartreflex.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
1.7.9.5
