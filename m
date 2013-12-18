From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 3/3] driver: pwmss: Disable stop clk bit during enable clock call.
Date: Wed, 18 Dec 2013 17:06:55 +0530
Message-ID: <1387366615-23182-4-git-send-email-sourav.poddar@ti.com>
References: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1387366615-23182-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org

Writing to ecap register on second insmod crashes with an external
abort. This happens becuase the STOP_CLK bit remains set(from rmmod) 
during the second insmod thereby not allowing the clocks to get enabled.

So, we disable STOP clock bit while doing a clock enable.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/pwm/pwm-tipwmss.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pwm/pwm-tipwmss.c b/drivers/pwm/pwm-tipwmss.c
index 3b119bc..4749866 100644
--- a/drivers/pwm/pwm-tipwmss.c
+++ b/drivers/pwm/pwm-tipwmss.c
@@ -40,6 +40,8 @@ u16 pwmss_submodule_state_change(struct device *dev, int set)
 
 	mutex_lock(&info->pwmss_lock);
 	val = readw(info->mmio_base + PWMSS_CLKCONFIG);
+	if (set == PWMSS_ECAPCLK_EN)
+		val &= ~PWMSS_ECAPCLK_STOP_REQ;
 	val |= set;
 	writew(val , info->mmio_base + PWMSS_CLKCONFIG);
 	mutex_unlock(&info->pwmss_lock);
-- 
1.7.1

