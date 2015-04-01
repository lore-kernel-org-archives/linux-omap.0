From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/3] rtc: omap: Fix misc bugs
Date: Wed, 1 Apr 2015 11:24:55 +0530
Message-ID: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, rtc-linux@googlegroups.com
Cc: t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

This patch series fixes miscellaneous bugs in OMAP RTC driver.

Tested on DRA72-evm with an out of tree patch for RTC hwmod.
Logs: http://pastebin.ubuntu.com/10716566/

Lokesh Vutla (3):
  rtc: omap: Unlock and Lock rtc registers before and after register
    writes
  rtc: omap: Update Kconfig for OMAP RTC
  rtc: omap: use module_platform_driver

 drivers/rtc/Kconfig    |  6 +++---
 drivers/rtc/rtc-omap.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 13 deletions(-)

-- 
1.9.1
