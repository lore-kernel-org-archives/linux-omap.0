From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] mfd: twl6040: Check clk_prepare_enable() return value in twl6040_power()
Date: Wed, 20 Apr 2016 11:16:38 -0400
Message-ID: <1461165398-12289-2-git-send-email-javier@osg.samsung.com>
References: <1461165398-12289-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461165398-12289-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

The clk_prepare_enable() function can fail so check the return
value and propagate the error in case of a failure.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/mfd/twl6040.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 4de92c16dfb8..852d5874aabb 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -291,7 +291,11 @@ int twl6040_power(struct twl6040 *twl6040, int on)
 		if (twl6040->power_count++)
 			goto out;
 
-		clk_prepare_enable(twl6040->clk32k);
+		ret = clk_prepare_enable(twl6040->clk32k);
+		if (ret) {
+			twl6040->power_count = 0;
+			goto out;
+		}
 
 		/* Allow writes to the chip */
 		regcache_cache_only(twl6040->regmap, false);
-- 
2.5.5
