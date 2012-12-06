From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/3] gpio: twl4030: TODO comment to remove the PWMA/B (LEDA/B) handling
Date: Thu, 6 Dec 2012 11:52:07 +0100
Message-ID: <1354791127-20545-4-git-send-email-peter.ujfalusi@ti.com>
References: <1354791127-20545-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354791127-20545-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This GPIO driver should not configure anything else then GPIOs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpio/gpio-twl4030.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index a38e6e9c..1e9f08c4 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -47,6 +47,7 @@
  * intended to support multiple hosts.
  *
  * There are also two LED pins used sometimes as output-only GPIOs.
+ * TODO: Handling of PWMA/B (LEDA/B) should be removed from this GPIO driver!
  */
 
 /* genirq interfaces are not available to modules */
@@ -131,6 +132,7 @@ static inline int gpio_twl4030_read(u8 address)
 
 /*----------------------------------------------------------------------*/
 
+/* TODO: Handling of PWMA/B (LEDA/B) should be removed from this GPIO driver! */
 static u8 cached_leden;
 
 /* The LED lines are open drain outputs ... a FET pulls to GND, so an
-- 
1.8.0
