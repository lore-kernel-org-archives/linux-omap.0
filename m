From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCHv4 2/2] ASoC: OMAP-McBSP: ASoC interface for McBSP sidetone
Date: Thu, 18 Feb 2010 20:42:29 +0200
Message-ID: <1266518549-23809-3-git-send-email-ilkka.koskinen@nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
 <1266518549-23809-2-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41169 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab0BRSlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 13:41:14 -0500
In-Reply-To: <1266518549-23809-2-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: eduardo.valentin@nokia.com, ext-Eero.Nurkkala@nokia.com

Add ASoC interface for OMAP McBSP2 and McBSP3 sidetones.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |  138 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-mcbsp.h |    2 +
 2 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index c0039b3..503c58d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -39,6 +39,14 @@
 
 #define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
 
+#define OMAP_MCBSP_SOC_SINGLE_S16_EXT(xname, xmin, xmax, \
+	xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = omap_mcbsp_st_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long) &(struct soc_mixer_control) \
+	{.min = xmin, .max = xmax} }
+
 struct omap_mcbsp_data {
 	unsigned int			bus_id;
 	struct omap_mcbsp_reg_cfg	regs;
@@ -637,6 +645,136 @@ struct snd_soc_dai omap_mcbsp_dai[] = {
 
 EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
 
+int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int max = mc->max;
+	int min = mc->min;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = min;
+	uinfo->value.integer.max = max;
+	return 0;
+}
+
+#define OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(id, channel)			\
+static int								\
+omap_mcbsp##id##_set_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
+					struct snd_ctl_elem_value *uc)	\
+{									\
+	struct soc_mixer_control *mc =					\
+		(struct soc_mixer_control *)kc->private_value;		\
+	int max = mc->max;						\
+	int min = mc->min;						\
+	int val = uc->value.integer.value[0];				\
+									\
+	if (val < min || val > max)					\
+		return -EINVAL;						\
+									\
+	/* OMAP McBSP implementation uses index values 0..4 */		\
+	return omap_st_set_chgain((id)-1, channel, val);		\
+}
+
+#define OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(id, channel)			\
+static int								\
+omap_mcbsp##id##_get_st_ch##channel##_volume(struct snd_kcontrol *kc,	\
+					struct snd_ctl_elem_value *uc)	\
+{									\
+	s16 chgain;							\
+									\
+	if (omap_st_get_chgain((id)-1, channel, &chgain))		\
+		return -EAGAIN;						\
+									\
+	uc->value.integer.value[0] = chgain;				\
+	return 0;							\
+}
+
+OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(2, 0)
+OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(2, 1)
+OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(3, 0)
+OMAP_MCBSP_ST_SET_CHANNEL_VOLUME(3, 1)
+OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(2, 0)
+OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(2, 1)
+OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(3, 0)
+OMAP_MCBSP_ST_GET_CHANNEL_VOLUME(3, 1)
+
+static int omap_mcbsp_st_put_mode(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	u8 value = ucontrol->value.integer.value[0];
+
+	if (value == omap_st_is_enabled(mc->reg))
+		return 0;
+
+	if (value)
+		omap_st_enable(mc->reg);
+	else
+		omap_st_disable(mc->reg);
+
+	return 1;
+}
+
+static int omap_mcbsp_st_get_mode(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	ucontrol->value.integer.value[0] = omap_st_is_enabled(mc->reg);
+	return 0;
+}
+
+static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] = {
+	SOC_SINGLE_EXT("McBSP2 Sidetone Switch", 1, 0, 1, 0,
+			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
+	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volume",
+				      -32768, 32767,
+				      omap_mcbsp2_get_st_ch0_volume,
+				      omap_mcbsp2_set_st_ch0_volume),
+	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volume",
+				      -32768, 32767,
+				      omap_mcbsp2_get_st_ch1_volume,
+				      omap_mcbsp2_set_st_ch1_volume),
+};
+
+static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
+	SOC_SINGLE_EXT("McBSP3 Sidetone Switch", 2, 0, 1, 0,
+			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
+	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volume",
+				      -32768, 32767,
+				      omap_mcbsp3_get_st_ch0_volume,
+				      omap_mcbsp3_set_st_ch0_volume),
+	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volume",
+				      -32768, 32767,
+				      omap_mcbsp3_get_st_ch1_volume,
+				      omap_mcbsp3_set_st_ch1_volume),
+};
+
+int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id)
+{
+	if (!cpu_is_omap34xx())
+		return -ENODEV;
+
+	switch (mcbsp_id) {
+	case 2: /* McBSP 2 */
+		return snd_soc_add_controls(codec, omap_mcbsp2_st_controls,
+					ARRAY_SIZE(omap_mcbsp2_st_controls));
+	case 3: /* McBSP 3 */
+		return snd_soc_add_controls(codec, omap_mcbsp3_st_controls,
+					ARRAY_SIZE(omap_mcbsp3_st_controls));
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
+
 static int __init snd_omap_mcbsp_init(void)
 {
 	return snd_soc_register_dais(omap_mcbsp_dai,
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index 1968d03..6c363e5 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -57,4 +57,6 @@ enum omap_mcbsp_div {
 
 extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
 
+int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id);
+
 #endif
-- 
1.6.0.4

