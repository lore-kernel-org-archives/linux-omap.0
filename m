From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/8] memory: emif: miscellaneous bug fixes for EMIF driver
Date: Mon, 11 Mar 2013 10:35:57 +0530
Message-ID: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

This series resolves a few minor issues for EMIF driver.

Tested all patches on OMAP4430-sdp.
Patch : "memory: emif: setup LP settings on freq update"
is tested on a local tree, since freq update cannot be
tested on mainline.

Ambresh K (1):
  memory: emif: setup LP settings on freq update

Grygorii Strashko (1):
  memory: emif: errata i743: Prohibit usage of Power-Down mode

Lokesh Vutla (2):
  memory: emif: Correct the lpmode timeout calculation
  memory: emif: Load the correct custom config values from dt

Nishanth Menon (3):
  memory: emif: handle overflow for timing for LP mode
  memory: emif: Handle devices which are not rated for >85C
  memory: emif: use restart if power_off not present when out of spec

Oleksandr Dmytryshyn (1):
  memory: emif: fix timings initialization issue

 drivers/memory/emif.c                   |  122 +++++++++++++++++++++++++++----
 include/linux/platform_data/emif_plat.h |    1 +
 2 files changed, 108 insertions(+), 15 deletions(-)

-- 
1.7.9.5
