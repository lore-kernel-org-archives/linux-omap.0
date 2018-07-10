From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 0/4] rtc: OMAP: Add support for rtc-only mode
Date: Tue, 10 Jul 2018 12:20:48 +0530
Message-ID: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

Prepare rtc driver for rtc-only with DDR in self-refresh mode.
The patch series is based on top of Johan Hovald's series:

https://lkml.kernel.org/r/20180704090558.16647-1-johan@kernel.org

Tested for suspend/resume and poweroff on am437x-gp-evm.

Keerthy (4):
  rtc: omap: Cut down the shutdown time from 2 seconds to 1 sec
  rtc: OMAP: Add support for rtc-only mode
  rtc: omap: use of_device_is_system_power_controller function
  rtc: interface: Add power_off_program ops

 drivers/rtc/interface.c | 12 +++++++++
 drivers/rtc/rtc-omap.c  | 71 ++++++++++++++++++++++++++++++++++++-------------
 include/linux/rtc.h     |  2 ++
 3 files changed, 66 insertions(+), 19 deletions(-)

-- 
1.9.1
