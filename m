From: "Quadros, Roger" <rogerq@ti.com>
Subject: RE: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
Date: Mon, 10 Jun 2013 10:03:36 +0000
Message-ID: <688FBEF7C8277944BE5AED9A41FB1EBC1AB12D0F@DNCE05.ent.ti.com>
References: <20130607203936.16513.57494.stgit@localhost>,<20130607205044.16513.27675.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45815 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab3FJKEG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 06:04:06 -0400
In-Reply-To: <20130607205044.16513.27675.stgit@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

________________________________________
From: Tony Lindgren [tony@atomide.com]
Sent: Friday, June 07, 2013 11:50 PM
To: linus.walleij@linaro.org
Cc: devicetree-discuss@lists.ozlabs.org; Haojian Zhuang; Ujfalusi, Peter; linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Quadros, Roger
Subject: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for wake-up events

For wake-up events from deeper idle modes we need to check the
configured padconf registers for the wake-up bit and then call
the related interrupt handler.

Done in collaboration with Roger Quadros <rogerq@ti.com>.

Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/Makefile                          |    3
 drivers/pinctrl/pinctrl-single-omap.c             |  287 +++++++++++++++++++++
 include/linux/platform_data/pinctrl-single-omap.h |    4
 3 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/pinctrl-single-omap.c
 create mode 100644 include/linux/platform_data/pinctrl-single-omap.h

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 9bdaeb8..abf7f01 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -30,7 +30,8 @@ obj-$(CONFIG_PINCTRL_NOMADIK) += pinctrl-nomadik.o
 obj-$(CONFIG_PINCTRL_STN8815)  += pinctrl-nomadik-stn8815.o
 obj-$(CONFIG_PINCTRL_DB8500)   += pinctrl-nomadik-db8500.o
 obj-$(CONFIG_PINCTRL_DB8540)   += pinctrl-nomadik-db8540.o
-obj-$(CONFIG_PINCTRL_SINGLE)   += pinctrl-single.o
+pcs-$(CONFIG_ARCH_OMAP2PLUS)   += pinctrl-single-omap.o
+obj-$(CONFIG_PINCTRL_SINGLE)   += pinctrl-single.o $(pcs-y)
 obj-$(CONFIG_PINCTRL_SIRF)     += pinctrl-sirf.o
 obj-$(CONFIG_PINCTRL_SUNXI)    += pinctrl-sunxi.o
 obj-$(CONFIG_PINCTRL_TEGRA)    += pinctrl-tegra.o
diff --git a/drivers/pinctrl/pinctrl-single-omap.c b/drivers/pinctrl/pinctrl-single-omap.c
new file mode 100644
index 0000000..680cf81
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-single-omap.c
@@ -0,0 +1,287 @@
+/*
+ * pinctrl-single-omap - omap specific wake-up irq handler
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
<snip>

+
+static int __init pcs_omap_init(void)
+{
+       platform_driver_register(&pcs_omap_soc_driver);
+       platform_driver_register(&pcs_omap_driver);
+
+       return 0;
+}
+module_init(pcs_omap_init);

It seems this has to be moved to an earlier place (e.g. subsys_initcall)
else the pinctrl core fails to find the pinctrl device at the device creation
time and bails out with -EPROBE_DEFER. Also, that device is never
created again, so -EPROBE_DEFER doesn't seem to work there.

The code i'm talking about is in dt_to_map_one_config()
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/devicetree.c#n109

+
+static void __exit pcs_omap_exit(void)
+{
+       platform_driver_unregister(&pcs_omap_driver);
+       platform_driver_unregister(&pcs_omap_soc_driver);
+}
+module_exit(pcs_omap_exit);
+
+MODULE_ALIAS("platform: pinctrl-single-omap");
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("pinctrl-single-omap driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/pinctrl-single-omap.h b/include/linux/platform_data/pinctrl-single-omap.h
new file mode 100644
index 0000000..bd92efc
--- /dev/null
+++ b/include/linux/platform_data/pinctrl-single-omap.h
@@ -0,0 +1,4 @@
+struct pcs_omap_pdata {
+       int irq;
+       void (*reconfigure_io_chain)(void);
+};


