From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/3] ti_am335x_tsc: Fix suspend/resume
Date: Sat, 14 Apr 2018 15:21:50 +0530
Message-ID: <20180414095153.32060-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vignesh R <vigneshr@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

This patch series fixes couple of issues wrt suspend/resume with TI AM335x
TSC driver. Disable and clear any pending IRQs before suspend, and
handle case where TSC wakeup would fail, if there were touch events
during suspend.

v2:
Rebase onto latest linux-next.
v1:https://lkml.org/lkml/2016/5/16/150

Grygorii Strashko (2):
  Input: ti_am335x_tsc - Ack pending IRQs at probe and before suspend
  Input: ti_am335x_tsc - Prevent system suspend when TSC is in use

Vignesh R (1):
  Input: ti_am335x_tsc - Mark IRQ as wakeup capable

 drivers/input/touchscreen/ti_am335x_tsc.c | 14 ++++++++++++++
 include/linux/mfd/ti_am335x_tscadc.h      |  1 +
 2 files changed, 15 insertions(+)

-- 
2.17.0
