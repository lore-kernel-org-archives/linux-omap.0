From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: OMAP-McBSP: ASoC interface for
 McBSP sidetone
Date: Thu, 28 Jan 2010 16:21:43 +0000
Message-ID: <1264695703.3044.244.camel@odin>
References: <1264693587-4764-1-git-send-email-ilkka.koskinen@nokia.com>
	 <1264693587-4764-2-git-send-email-ilkka.koskinen@nokia.com>
	 <1264693587-4764-3-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:55840 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601Ab0A1QVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 11:21:45 -0500
Received: by fxm20 with SMTP id 20so848817fxm.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 08:21:43 -0800 (PST)
In-Reply-To: <1264693587-4764-3-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com

On Thu, 2010-01-28 at 17:46 +0200, Ilkka Koskinen wrote:
> Add ASoC interface for OMAP McBSP2 and McBSP3 sidetones.
> 
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |  187 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/omap/omap-mcbsp.h |    2 +
>  2 files changed, 189 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 6bbbd2a..295620b 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -39,6 +39,14 @@

snip

> +/* McBSP Sidetone Switch */
> +static const char *omap_mcbsp_st_status[] = {
> +	"off",
> +	"on",
> +};
> +

Should this not be a switch (like a mute switch) rather than an enum
kcontrol ?

> +static const struct soc_enum omap_mcbsp_st_status_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(omap_mcbsp_st_status),
> +			    omap_mcbsp_st_status),
> +};
> +
> +static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] = {
> +	SOC_ENUM_EXT("McBSP2 Sidetone Switch", omap_mcbsp_st_status_enum[0],
> +			omap_mcbsp2_st_get_mode, omap_mcbsp2_st_set_mode),
> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp2_get_st_ch0_volume,
> +				      omap_mcbsp2_set_st_ch0_volume),
> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp2_get_st_ch1_volume,
> +				      omap_mcbsp2_set_st_ch1_volume),
> +};
> +
> +static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
> +	SOC_ENUM_EXT("McBSP3 Sidetone Switch", omap_mcbsp_st_status_enum[0],
> +			omap_mcbsp3_st_get_mode, omap_mcbsp3_st_set_mode),
> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp3_get_st_ch0_volume,
> +				      omap_mcbsp3_set_st_ch0_volume),
> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volume",
> +				      -32768, 32767,
> +				      omap_mcbsp3_get_st_ch1_volume,
> +				      omap_mcbsp3_set_st_ch1_volume),
> +};
> +
> +int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id)
> +{
> +	if (!cpu_is_omap34xx())
> +		return -ENODEV;
> +
> +	switch (mcbsp_id) {
> +	case 2: /* McBSP 2 */
> +		return snd_soc_add_controls(codec, omap_mcbsp2_st_controls,
> +					ARRAY_SIZE(omap_mcbsp2_st_controls));
> +	case 3: /* McBSP 3 */
> +		return snd_soc_add_controls(codec, omap_mcbsp3_st_controls,
> +					ARRAY_SIZE(omap_mcbsp3_st_controls));
> +	default:
> +		break;
> +	}
> +
> +	return -1;

-EINVAL;

> +}
> +EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
> +
>  static int __init snd_omap_mcbsp_init(void)
>  {
>  	return snd_soc_register_dais(omap_mcbsp_dai,
> diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
> index 647d2f9..7537435 100644
> --- a/sound/soc/omap/omap-mcbsp.h
> +++ b/sound/soc/omap/omap-mcbsp.h
> @@ -57,4 +57,6 @@ enum omap_mcbsp_div {
>  
>  extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
>  
> +int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, int mcbsp_id);
> +
>  #endif


