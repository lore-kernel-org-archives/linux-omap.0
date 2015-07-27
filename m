From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/2] pbias regulator fixes
Date: Mon, 27 Jul 2015 16:54:08 +0530
Message-ID: <1437996250-2913-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grygorii.strashko@ti.com, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Patch series contains a couple of fixes. One that disables pbias
properly (write the correct value to disable regulator instead of
writing 0). And the other is to get the correct address to
enable/disable the pbias regulator.

Tested on DRA7 (tests pbias_mmc_omap5) and OMAP5 panda (tests
pbias_mmc_omap4).

Kishon Vijay Abraham I (2):
  regulator: pbias: use untranslated address to program pbias regulator
  regulator: pbias: Fix broken pbias disable functionality

 drivers/regulator/pbias-regulator.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
1.7.9.5
