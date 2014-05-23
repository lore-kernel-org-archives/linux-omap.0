From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 07/13] ASoC: omap-hdmi-card: Add platform data stuct for omap-hdmi-card driver
Date: Fri, 23 May 2014 22:07:56 +0300
Message-ID: <49e1e8f9d6841b63f6ba096743f48c94842fe956.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbaEWTIe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 May 2014 15:08:34 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The names of the needed ASoC component drivers need to be passed to
the omap-hdmi-card driver for it to find them.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 include/sound/omap-hdmi-card-pdata.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/sound/omap-hdmi-card-pdata.h

diff --git a/include/sound/omap-hdmi-card-pdata.h b/include/sound/omap-hdmi-card-pdata.h
new file mode 100644
index 0000000..f70495b
--- /dev/null
+++ b/include/sound/omap-hdmi-card-pdata.h
@@ -0,0 +1,28 @@
+/*
+ * omap-hdmi-card-pdata.h
+ *
+ * Platform data for OMAP ALSA SoC card driver for HDMI audio on OMAP4+
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
+#ifndef __OMAP_HDMI_CARD_PDATA_H__
+#define __OMAP_HDMI_CARD_PDATA_H__
+
+struct asoc_omap_hdmi_card_pdata {
+	const char *cpudai_name;
+	const char *codec_name;
+};
+
+#endif
-- 
1.7.9.5

