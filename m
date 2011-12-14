From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/10] include: platform_data: Platform data header for OMAP4 ASoC audio
Date: Wed, 14 Dec 2011 11:46:57 +0200
Message-ID: <1323856022-24053-5-git-send-email-peter.ujfalusi@ti.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:57726 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956Ab1LNJtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 04:49:12 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id j13so288552lah.11
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 01:49:11 -0800 (PST)
In-Reply-To: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Include file to be used with the upcoming ASoC machine driver
for OMAP platform using ABE with twl6040 codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/omap-abe-twl6040.h |   33 ++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/omap-abe-twl6040.h

diff --git a/include/linux/platform_data/omap-abe-twl6040.h b/include/linux/platform_data/omap-abe-twl6040.h
new file mode 100644
index 0000000..afbdff4
--- /dev/null
+++ b/include/linux/platform_data/omap-abe-twl6040.h
@@ -0,0 +1,33 @@
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
+enum board_type {
+	OMAP_ABE_TWL6040_SDP4430,
+	OMAP_ABE_TWL6040_PANDA,
+	OMAP_ABE_TWL6040_PANDA_ES,
+};
+
+struct omap_abe_twl6040_data {
+	char *card_name;
+	enum board_type board;
+};
-- 
1.7.8

