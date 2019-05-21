From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] mfd: menelaus: Remove superfluous error message
Date: Tue, 21 May 2019 22:43:04 +0200
Message-ID: <20190521204304.21295-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-omap@vger.kernel.org

The RTC core already has error messages in case of failure, there is no
need to have another message in the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/mfd/menelaus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index d28ebe7ecd21..91c568ef5857 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1138,8 +1138,6 @@ static inline void menelaus_rtc_init(struct menelaus_chip *m)
 			menelaus_remove_irq_work(MENELAUS_RTCALM_IRQ);
 			device_init_wakeup(&m->client->dev, 0);
 		}
-		dev_err(&m->client->dev, "can't register RTC: %d\n",
-				(int) PTR_ERR(m->rtc));
 		the_menelaus->rtc = NULL;
 	}
 }
-- 
2.21.0
