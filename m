From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] mfd: twl4030-power: Fix driver path in file comment
Date: Tue, 19 Apr 2016 17:24:26 -0400
Message-ID: <1461101066-27753-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

The driver's file path in the comment is wrong, use the correct one.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/mfd/twl4030-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 04b539850e72..f832233fd365 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/i2c/chips/twl4030-power.c
+ * linux/drivers/mfd/twl4030-power.c
  *
  * Handle TWL4030 Power initialization
  *
-- 
2.5.5
