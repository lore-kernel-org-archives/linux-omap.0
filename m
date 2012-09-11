From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/4] staging: omap-thermal: clean-ups and fixes
Date: Tue, 11 Sep 2012 19:06:51 +0300
Message-ID: <1347379615-6881-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: j-keerthy@ti.com, b-cousson@ti.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Greg,

Here are some patches to clean the omap-thermal driver code a bit.
There are 2 fixes as well related to registration to thermal fw.

These patches are based on staging-next tree.

They are also available here:
git@gitorious.org:thermal-framework/thermal-framework.git thermal_work/omap/omap-thermal-fixes

All best,

Eduardo Valentin (3):
  staging: omap-thermal: remove checkpatch.pl warnings on data files
  staging: omap-thermal: fix polling period settings
  staging: omap-thermal: improve conf data handling and initialization

J Keerthy (1):
  staging: omap-thermal: Correct checkpatch.pl warnings

 drivers/staging/omap-thermal/omap-bandgap.c        |   21 ++++----
 drivers/staging/omap-thermal/omap-thermal-common.c |   42 +++++++++++++--
 drivers/staging/omap-thermal/omap4-thermal.c       |   54 ++++++++++----------
 drivers/staging/omap-thermal/omap5-thermal.c       |   38 +++++++-------
 4 files changed, 93 insertions(+), 62 deletions(-)

-- 
1.7.7.1.488.ge8e1c
