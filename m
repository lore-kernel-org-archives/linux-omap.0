From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 - resend 04/13] include: platform_data: Platform data header for OMAP4 ASoC audio
Date: Tue, 24 Jan 2012 13:52:21 +0200
Message-ID: <1327405950-6676-5-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:44920 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756411Ab2AXLwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 06:52:53 -0500
Received: by mail-lpp01m010-f45.google.com with SMTP id o5so840998lah.4
        for <linux-omap@vger.kernel.org>; Tue, 24 Jan 2012 03:52:52 -0800 (PST)
In-Reply-To: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Include file to be used with the upcoming ASoC machine driver
for OMAP platform using ABE with twl6040 codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/platform_data/omap-abe-twl6040.h |   49 ++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/omap-abe-twl6040.h

diff --git a/include/linux/platform_data/omap-abe-twl6040.h b/include/linux/platform_data/omap-abe-twl6040.h
new file mode 100644
index 0000000..5d298ac
--- /dev/null
+++ b/include/linux/platform_data/omap-abe-twl6040.h
@@ -0,0 +1,49 @@
+/**
+ * omap-abe-twl6040.h - ASoC machine driver OMAP4+ devices, header.
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com
+ * All rights reserved.
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ */
+
+#ifndef _OMAP_ABE_TWL6040_H_
+#define _OMAP_ABE_TWL6040_H_
+
+/* To select if only one channel is connected in a stereo port */
+#define ABE_TWL6040_LEFT	(1 << 0)
+#define ABE_TWL6040_RIGHT	(1 << 1)
+
+struct omap_abe_twl6040_data {
+	char *card_name;
+	/* Feature flags for connected audio pins */
+	u8	has_hs;
+	u8	has_hf;
+	bool	has_ep;
+	u8	has_aux;
+	u8	has_vibra;
+	bool	has_dmic;
+	bool	has_hsmic;
+	bool	has_mainmic;
+	bool	has_submic;
+	u8	has_afm;
+	/* Other features */
+	bool	jack_detection;	/* board can detect jack events */
+	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
+};
+
+#endif /* _OMAP_ABE_TWL6040_H_ */
-- 
1.7.8.3

