From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 13/13] mfd: menelaus: remove unnecessary definition
Date: Wed, 27 Nov 2013 13:06:57 -0600
Message-ID: <1385579217-20127-14-git-send-email-balbi@ti.com>
References: <1385579217-20127-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385579217-20127-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sameo@linux.intel.com
Cc: lee.jones@linaro.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

menelaus_i2c_driver isn't referenced on probe,
just remove that unnecessary line. No functional
changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index e7006e4..376f01d 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1206,8 +1206,6 @@ static inline void menelaus_rtc_init(struct menelaus_chip *m)
 
 /*-----------------------------------------------------------------------*/
 
-static struct i2c_driver menelaus_i2c_driver;
-
 static int menelaus_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-- 
1.8.4.GIT
