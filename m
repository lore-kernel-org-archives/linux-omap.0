From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 12/14] OMAPDSS: HDMI: OMAP4: Remap speaker order to match ALSA order
Date: Thu, 3 May 2012 20:44:06 -0500
Message-ID: <1336095848-6923-13-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52868 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757189Ab2EDBod (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:33 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

As of today, the only know user of the DSS HDMI audio support is
ASoC. Hence, it makes sense to remap the speaker order to match
the ALSA speaker order. In the future, a dynamic mapping mechanism
may be implemented.

Remapping is needed as the HDMI speaker order is FL/FR/LFE/C/RL/RR/
RLC-FLC/RRC-FLC while the ALSA order is FL/FR/RL/RR/C/LFE/SL/SR.
Refer to CEA-861 Section 6.6.2 for further details.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 74d9420..4dcdbbb 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1154,6 +1154,14 @@ static void ti_hdmi_4xxx_core_audio_config(struct hdmi_ip_data *ip_data,
 	r = FLD_MOD(r, cfg->en_parallel_aud_input, 2, 2);
 	r = FLD_MOD(r, cfg->en_spdif, 1, 1);
 	hdmi_write_reg(av_base, HDMI_CORE_AV_AUD_MODE, r);
+
+	/* Audio channel mappings */
+	/* TODO: Make channel mapping dynamic. For now, map channels
+	 * in the ALSA order: FL/FR/RL/RR/C/LFE/SL/SR. Remapping is needed as
+	 * HDMI speaker order is different. See CEA-861 Section 6.6.2.
+	 */
+	hdmi_write_reg(av_base, HDMI_CORE_AV_I2S_IN_MAP, 0x78);
+	REG_FLD_MOD(av_base, HDMI_CORE_AV_SWAP_I2S, 1, 5, 5);
 }
 
 static void ti_hdmi_4xxx_core_audio_infoframe_cfg(struct hdmi_ip_data *ip_data,
-- 
1.7.5.4

