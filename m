From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 06/13] ASoC: omap-hdmi-dai: Add platform data struct for omap-hdmi-dai driver
Date: Fri, 23 May 2014 22:07:55 +0300
Message-ID: <1b85e5331518bc519021a49a1fb28d6cce303d90.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46921 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaEWTIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 15:08:32 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Provide the means to pass OMAPDSS HDMI resources over to omap-hdmi-dai
driver when the OMAPDSS driver registers the DAI driver.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/sound/omap-hdmi-dai-pdata.h |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/sound/omap-hdmi-dai-pdata.h

diff --git a/include/sound/omap-hdmi-dai-pdata.h b/include/sound/omap-hdmi-dai-pdata.h
new file mode 100644
index 0000000..337c859
--- /dev/null
+++ b/include/sound/omap-hdmi-dai-pdata.h
@@ -0,0 +1,31 @@
+/*
+ * omap-hdmi-dai-pdata.h
+ *
+ * Platform data for OMAP ALSA SoC DAI driver for HDMI audio on OMAP4+
+ * processors.
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
+ * Authors: Jyri Sarha <jsarha@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#ifndef __OMAP_HDMI_DAI_PDATA_H__
+#define __OMAP_HDMI_DAI_PDATA_H__
+
+struct omap_dss_device;
+
+struct asoc_omap_hdmi_dai_pdata {
+	struct omap_dss_device *dssdev;
+	dma_addr_t dma_addr;
+	unsigned int dma_req;
+};
+
+#endif
-- 
1.7.9.5

