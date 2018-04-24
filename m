From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 0/3] ti_am335x_tsc: Fix suspend/resume
Date: Tue, 24 Apr 2018 11:57:38 +0530
Message-ID: <20180424062741.7891-1-vigneshr@ti.com>
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


Grygorii Strashko (2):
  Input: ti_am335x_tsc - Ack pending IRQs at probe and before suspend
  Input: ti_am335x_tsc - Prevent system suspend when TSC is in use

Vignesh R (1):
  Input: ti_am335x_tsc - Mark IRQ as wakeup capable

 drivers/input/touchscreen/ti_am335x_tsc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.17.0
