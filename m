From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/9] include: platform_data: Platform data header for OMAP4 ASoC audio
Date: Thu, 22 Dec 2011 18:38:14 +0200
Message-ID: <1324571902-16918-2-git-send-email-peter.ujfalusi@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41366 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753331Ab1LVQip (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 11:38:45 -0500
Received: by lahd3 with SMTP id d3so1288066lah.5
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 08:38:42 -0800 (PST)
In-Reply-To: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Include file to be used with the upcoming ASoC machine driver
for OMAP platform using ABE with twl6040 codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/omap-abe-twl6040.h |   48 ++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/omap-abe-twl6040.h

diff --git a/include/linux/platform_data/omap-abe-twl6040.h b/include/linux/platform_data/omap-abe-twl6040.h
new file mode 100644
index 0000000..286f644
--- /dev/null
+++ b/include/linux/platform_data/omap-abe-twl6040.h
@@ -0,0 +1,48 @@
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
+};
+
+#endif /* _OMAP_ABE_TWL6040_H_ */
-- 
1.7.8.1

