From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/3] rtc: omap: Fix misc bugs
Date: Thu, 2 Apr 2015 16:39:08 +0530
Message-ID: <1427972951-18959-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, rtc-linux@googlegroups.com
Cc: t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lokeshvutla@ti.com, alexandre.belloni@free-electrons.com
List-Id: linux-omap@vger.kernel.org

This patch series fixes miscellaneous bugs in OMAP RTC driver.

Tested on BeagleBone-Black.
Logs: http://pastebin.ubuntu.com/10723287/

V1 patches can be seen here: http://www.mail-archive.com/linux-omap%40vger.kernel.org/msg115839.html

Lokesh Vutla (3):
  rtc: omap: Unlock and Lock rtc registers before and after register
    writes
  rtc: omap: Update Kconfig for OMAP RTC
  rtc: omap: use module_platform_driver

 drivers/rtc/Kconfig    |  6 ++---
 drivers/rtc/rtc-omap.c | 68 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 16 deletions(-)

-- 
1.9.1
