From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 0/3] pwm: ti: Miscellaneous Fixes and cleanup for pwm.
Date: Wed, 18 Dec 2013 17:06:52 +0530
Message-ID: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series caters to the issue faced while using tiecap
as a module.

The patch fix lock dependency issue which leads to crash during rmmod. 
Also fixes the clock control register setup values during CLK EN call. 

Sourav Poddar (3):
  pwm: core: Rearrange pwm lock usage.
  driver: pwm: ti-ecap: Rmove duplicate put_sync call.
  driver: pwmss: Disable stop during Enable clock call..

 drivers/pwm/core.c        |    4 +++-
 drivers/pwm/pwm-tiecap.c  |    1 -
 drivers/pwm/pwm-tipwmss.c |    2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

