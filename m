From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 10/14] OMAPDSS: HDMI: Add support for more audio sample rates in N/CTS calculation
Date: Thu, 3 May 2012 20:44:04 -0500
Message-ID: <1336095848-6923-11-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52865 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771Ab2EDBoc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:32 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Add support for more sample rates when calculating N and CTS. This
covers all the audio sample rates that an HDMI source is allowed
to transmit according to the HDMI 1.4a specification.

Also, reorganize the logic for the calculation when using deep color.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   88 +++++++++++++++++++++++++++++++++------
 1 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2a810b7..aee0acf 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -577,6 +577,7 @@ static void hdmi_put_clocks(void)
 int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
+	bool deep_color_correct = false;
 	u32 pclk = hdmi.ip_data.cfg.timings.pixel_clock;
 
 	if (n == NULL || cts == NULL)
@@ -585,29 +586,88 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 	/* TODO: When implemented, query deep color mode here. */
 	deep_color = 100;
 
+	/*
+	 * When using deep color, the default N value (as in the HDMI
+	 * specification) yields to an non-integer CTS. Hence, we
+	 * modify it while keeping the restrictions described in
+	 * section 7.2.1 of the HDMI 1.4a specification.
+	 */
 	switch (sample_freq) {
 	case 32000:
-		if ((deep_color == 125) && ((pclk == 54054) ||
-					    (pclk == 74250)))
-			*n = 8192;
-		else
-			*n = 4096;
+	case 48000:
+	case 96000:
+	case 192000:
+		if (deep_color == 125)
+			if (pclk == 27027 || pclk == 74250)
+				deep_color_correct = true;
+		if (deep_color == 150)
+			if (pclk == 27027)
+				deep_color_correct = true;
 		break;
 	case 44100:
-		*n = 6272;
-		break;
-	case 48000:
-		if ((deep_color == 125) && ((pclk == 54054) ||
-					    (pclk == 74250)))
-			*n = 8192;
-		else
-			*n = 6144;
+	case 88200:
+	case 176400:
+		if (deep_color == 125)
+			if (pclk == 27027)
+				deep_color_correct = true;
 		break;
 	default:
-		*n = 0;
 		return -EINVAL;
 	}
 
+	if (deep_color_correct) {
+		switch (sample_freq) {
+		case 32000:
+			*n = 8192;
+			break;
+		case 44100:
+			*n = 12544;
+			break;
+		case 48000:
+			*n = 8192;
+			break;
+		case 88200:
+			*n = 25088;
+			break;
+		case 96000:
+			*n = 16384;
+			break;
+		case 176400:
+			*n = 50176;
+			break;
+		case 192000:
+			*n = 32768;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		switch (sample_freq) {
+		case 32000:
+			*n = 4096;
+			break;
+		case 44100:
+			*n = 6272;
+			break;
+		case 48000:
+			*n = 6144;
+			break;
+		case 88200:
+			*n = 12544;
+			break;
+		case 96000:
+			*n = 12288;
+			break;
+		case 176400:
+			*n = 25088;
+			break;
+		case 192000:
+			*n = 24576;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 	/* Calculate CTS. See HDMI 1.3a or 1.4a specifications */
 	*cts = pclk * (*n / 128) * deep_color / (sample_freq / 10);
 
-- 
1.7.5.4

