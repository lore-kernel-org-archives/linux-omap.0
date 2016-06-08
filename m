From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mfd: omap-usb-tll: fix include of omap-usb.h
Date: Wed,  8 Jun 2016 19:06:20 +0100
Message-ID: <1465409180-18634-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Fix the warnings about the following functions not being
declared by including omap-usb.h which declares them:

drivers/mfd/omap-usb-tll.c:333:5: warning: symbol 'omap_tll_init' was not declared. Should it be static?
drivers/mfd/omap-usb-tll.c:408:5: warning: symbol 'omap_tll_enable' was not declared. Should it be static?
drivers/mfd/omap-usb-tll.c:442:5: warning: symbol 'omap_tll_disable' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mfd/omap-usb-tll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index c30290f..1aa74c4 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -30,6 +30,8 @@
 #include <linux/platform_data/usb-omap.h>
 #include <linux/of.h>
 
+#include "omap-usb.h"
+
 #define USBTLL_DRIVER_NAME	"usbhs_tll"
 
 /* TLL Register Set */
-- 
2.8.1
