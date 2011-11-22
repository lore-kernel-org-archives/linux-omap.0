From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 2/2] OMAPDSS: HDMI: Indirect trigger to IP specific version
Date: Tue, 22 Nov 2011 20:54:06 +0530
Message-ID: <1321975446-12820-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40156 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab1KVPYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:24:17 -0500
Received: by ghrr1 with SMTP id r1so264500ghr.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:24:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mythripk@ti.com, tomi.valkeinen@ti.com, Jassi Brar <jaswinder.singh@linaro.org>

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/hdmi.c            |    6 ++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    2 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index d3eae98..9822951 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -687,6 +687,12 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int hdmi_audio_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	return hdmi_4xxx_audio_trigger(&hdmi.ip_data, substream, cmd, dai);
+}
+
 static int hdmi_audio_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index e1a6ce5..4b71093 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -1204,7 +1204,7 @@ int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
 	return 0;
 }
 
-int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
+int hdmi_4xxx_audio_trigger(struct hdmi_ip_data *ip_data,
 				struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai)
 {
diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index 2040956..a975f17 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -576,7 +576,7 @@ struct hdmi_core_audio_config {
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
-int hdmi_audio_trigger(struct hdmi_ip_data *ip_data,
+int hdmi_4xxx_audio_trigger(struct hdmi_ip_data *ip_data,
 				struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *dai);
 int hdmi_config_audio_acr(struct hdmi_ip_data *ip_data,
-- 
1.7.4.1

