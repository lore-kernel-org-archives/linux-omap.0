From: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/5] mfd: twl: remove useless header
Date: Sat, 26 Nov 2016 20:13:23 +0200
Message-ID: <20161126181326.14951-3-Nicolae_Rosia@mentor.com>
References: <20161126181326.14951-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161126181326.14951-1-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Graeme Gregory <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This header has one user, twl-core.c .
Remove it before it gets more users.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/mfd/twl-core.c    |  8 ++++++--
 drivers/mfd/twl-core.h    | 10 ----------
 drivers/mfd/twl4030-irq.c |  2 --
 drivers/mfd/twl6030-irq.c |  2 --
 4 files changed, 6 insertions(+), 16 deletions(-)
 delete mode 100644 drivers/mfd/twl-core.h

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 48b0668..e16084e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -52,8 +52,6 @@
 /* Register descriptions for audio */
 #include <linux/mfd/twl4030-audio.h>
 
-#include "twl-core.h"
-
 /*
  * The TWL4030 "Triton 2" is one of a family of a multi-function "Power
  * Management and System Companion Device" chips originally designed for
@@ -150,6 +148,12 @@
 
 /*----------------------------------------------------------------------*/
 
+int twl6030_init_irq(struct device *dev, int irq_num);
+int twl6030_exit_irq(void);
+int twl4030_init_irq(struct device *dev, int irq_num);
+int twl4030_exit_irq(void);
+int twl4030_init_chip_irq(const char *chip);
+
 /* Structure for each TWL4030/TWL6030 Slave */
 struct twl_client {
 	struct i2c_client *client;
diff --git a/drivers/mfd/twl-core.h b/drivers/mfd/twl-core.h
deleted file mode 100644
index 6ff99dc..0000000
--- a/drivers/mfd/twl-core.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __TWL_CORE_H__
-#define __TWL_CORE_H__
-
-extern int twl6030_init_irq(struct device *dev, int irq_num);
-extern int twl6030_exit_irq(void);
-extern int twl4030_init_irq(struct device *dev, int irq_num);
-extern int twl4030_exit_irq(void);
-extern int twl4030_init_chip_irq(const char *chip);
-
-#endif /*  __TWL_CORE_H__ */
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index b46c0cf..000c231 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -35,8 +35,6 @@
 #include <linux/irqdomain.h>
 #include <linux/i2c/twl.h>
 
-#include "twl-core.h"
-
 /*
  * TWL4030 IRQ handling has two stages in hardware, and thus in software.
  * The Primary Interrupt Handler (PIH) stage exposes status bits saying
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 5357450..63eca76 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -42,8 +42,6 @@
 #include <linux/irqdomain.h>
 #include <linux/of_device.h>
 
-#include "twl-core.h"
-
 /*
  * TWL6030 (unlike its predecessors, which had two level interrupt handling)
  * three interrupt registers INT_STS_A, INT_STS_B and INT_STS_C.
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
