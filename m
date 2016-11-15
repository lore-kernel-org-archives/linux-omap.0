From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 5/5] mfd: tps65217: Support an interrupt pin as the system wakeup
Date: Tue, 15 Nov 2016 22:02:15 +0900
Message-ID: <20161115130215.3301-6-woogyom.kim@gmail.com>
References: <20161115130215.3301-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115130215.3301-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

TPS65217 INT pin is used for the system wakeup from suspend mode.
This patch enables push button or charger input event as a wakeup source.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/mfd/tps65217.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 7376090..f769c7d 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -183,6 +183,8 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 		return ret;
 	}
 
+	enable_irq_wake(irq);
+
 	return 0;
 }
 
-- 
2.9.3
