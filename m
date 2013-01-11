From: Ricardo Neri <rneri@dextratech.com>
Subject: [PATCH] OMAPDSS: HDMI: Rework function to calculate N/CTS params
Date: Thu, 10 Jan 2013 18:53:43 -0600
Message-ID: <1357865623-19157-1-git-send-email-rneri@dextratech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from spamfilter.dextratech.com ([187.141.251.67]:35287 "EHLO
	mail.dextratech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab3AKAxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 19:53:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: dzuniga@dextratech.com, linux-omap@vger.kernel.org, Ricardo Neri <rneri@dextratech.com>

The function is reworked to be more readable and fix wrong computations at two
corner cases:

*It takes advantage of the properties of the N and CTS values to recursively
compute the parameters for the highest audio sample rates.

*Fix an overflow in the computation of CTS that was happening with the
 pclk = 148.5MHz, fs=176.4kHz and color of 36 bits/pixel use case.

*The N value is updated for the pclk=27.027MHz, fs=32kHz and color of
 30 bits/pixel use case to produce a CTS value that is closer to an
 integer and, therefore, produce less clock drift. However, no valid
 value of N can yield to an integer CTS value for such use case.

Signed-off-by: Ricardo Neri <rneri@dextratech.com>
---
 drivers/video/omap2/dss/hdmi.c |  142 ++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 72 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 769d082..0857834 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -824,100 +824,98 @@ static void hdmi_put_clocks(void)
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
 int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 {
+	int r;
 	u32 deep_color;
-	bool deep_color_correct = false;
 	u32 pclk = hdmi.ip_data.cfg.timings.pixel_clock;

-	if (n == NULL || cts == NULL)
+	if (n == NULL || cts == NULL || sample_freq == 0)
 		return -EINVAL;

 	/* TODO: When implemented, query deep color mode here. */
 	deep_color = 100;

-	/*
-	 * When using deep color, the default N value (as in the HDMI
-	 * specification) yields to an non-integer CTS. Hence, we
-	 * modify it while keeping the restrictions described in
-	 * section 7.2.1 of the HDMI 1.4a specification.
-	 */
 	switch (sample_freq) {
 	case 32000:
-	case 48000:
-	case 96000:
-	case 192000:
-		if (deep_color == 125)
-			if (pclk == 27027 || pclk == 74250)
-				deep_color_correct = true;
-		if (deep_color == 150)
-			if (pclk == 27027)
-				deep_color_correct = true;
-		break;
-	case 44100:
-	case 88200:
-	case 176400:
-		if (deep_color == 125)
-			if (pclk == 27027)
-				deep_color_correct = true;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (deep_color_correct) {
-		switch (sample_freq) {
-		case 32000:
+		if (deep_color == 125 && pclk == 74250) {
 			*n = 8192;
 			break;
-		case 44100:
-			*n = 12544;
+		}
+
+		if (deep_color == 125 && pclk == 27027) {
+			/*
+			 * For this specific configuration, no value within the
+			 * allowed interval of N (as per the HDMI spec) will
+			 * produce an integer value of CTS. The value we use
+			 * here will produce CTS = 11587.000427246, which is
+			 * slightly larger than the integer. This difference
+			 * could cause the audio clock at the sink to slowly
+			 * drift. The true solution requires alternating between
+			 * two CTS relevant values with careful timing in order
+			 * to, on average, obtain the true CTS float value.
+			*/
+			*n = 13529;
 			break;
-		case 48000:
+		}
+
+		if (deep_color == 150 && pclk == 27027) {
 			*n = 8192;
 			break;
-		case 88200:
-			*n = 25088;
-			break;
-		case 96000:
-			*n = 16384;
-			break;
-		case 176400:
-			*n = 50176;
-			break;
-		case 192000:
-			*n = 32768;
-			break;
-		default:
-			return -EINVAL;
 		}
-	} else {
-		switch (sample_freq) {
-		case 32000:
-			*n = 4096;
-			break;
-		case 44100:
-			*n = 6272;
-			break;
-		case 48000:
-			*n = 6144;
-			break;
-		case 88200:
+
+		*n = 4096;
+		break;
+	case 44100:
+		if (deep_color == 125 && pclk == 27027) {
 			*n = 12544;
 			break;
-		case 96000:
-			*n = 12288;
-			break;
-		case 176400:
-			*n = 25088;
+		}
+
+		*n = 6272;
+		break;
+	case 48000:
+		if (deep_color == 125 && (pclk == 27027 || pclk == 74250)) {
+			*n = 8192;
 			break;
-		case 192000:
-			*n = 24576;
+		}
+
+		if (deep_color == 150 && pclk == 27027) {
+			*n = 8192;
 			break;
-		default:
-			return -EINVAL;
 		}
+
+		*n = 6144;
+		break;
+	case 88200:
+		r = hdmi_compute_acr(44100, n, cts);
+		*n *= 2;
+		return r;
+	case 96000:
+		r = hdmi_compute_acr(48000, n, cts);
+		*n *= 2;
+		return r;
+	case 176400:
+		r = hdmi_compute_acr(44100, n, cts);
+		*n *= 4;
+		return r;
+	case 192000:
+		r = hdmi_compute_acr(48000, n, cts);
+		*n *= 4;
+		return r;
+	default:
+		return -EINVAL;
 	}
-	/* Calculate CTS. See HDMI 1.3a or 1.4a specifications */
-	*cts = pclk * (*n / 128) * deep_color / (sample_freq / 10);
+
+	/*
+	 * Calculate CTS. See HDMI 1.3a or 1.4a specifications. Preserve the
+	 * remainder in case N is not a multiple of 128.
+	 */
+	*cts = (*n / 128) * pclk * deep_color;
+	*cts += (*n % 128) * pclk * deep_color / 128;
+	*cts /= (sample_freq / 10);
+
+	if ((pclk * (*n / 128) * deep_color) % (sample_freq / 10))
+		DSSWARN("CTS is not integer fs[%u]pclk[%u]N[%u]\n",
+			sample_freq, pclk, *n);

 	return 0;
 }
--
1.7.10.4

