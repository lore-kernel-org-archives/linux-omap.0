From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 6/7] mfd: omap-usb-host: Return value is not 'const int'
Date: Thu, 15 Sep 2016 11:45:20 +0100
Message-ID: <20160915104521.14286-7-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Change from 'const int' to just 'int'.

Cc: <robh+dt@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/omap-usb-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 1d924d1..7aab376 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -162,7 +162,7 @@ static const char * const port_modes[] = {
  * provided port mode string as per the port_modes table.
  * If no match is found it returns -ENODEV
  */
-static const int omap_usbhs_get_dt_port_mode(const char *mode)
+static int omap_usbhs_get_dt_port_mode(const char *mode)
 {
 	int i;
 
-- 
2.9.3
