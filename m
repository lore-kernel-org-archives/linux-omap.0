From: <ilkka.koskinen@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: OMAP-McBSP: ASoC interface for
 McBSP sidetone
Date: Fri, 29 Jan 2010 13:06:24 +0100
Message-ID: <F80267346F10C541946CBE8909F1C39E24928B7EE8@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1264693587-4764-1-git-send-email-ilkka.koskinen@nokia.com>
	<1264693587-4764-2-git-send-email-ilkka.koskinen@nokia.com>
	<1264693587-4764-3-git-send-email-ilkka.koskinen@nokia.com>
	<1264695703.3044.244.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1264695703.3044.244.camel@odin>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, tony@atomide.com, eduardo.valentin@nokia.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, ext-Eero.Nurkkala@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

>From: ext Liam Girdwood [mailto:lrg@slimlogic.co.uk] 
>Sent: 28 January, 2010 18:22
>On Thu, 2010-01-28 at 17:46 +0200, Ilkka Koskinen wrote:
>> Add ASoC interface for OMAP McBSP2 and McBSP3 sidetones.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
>> ---
>>  sound/soc/omap/omap-mcbsp.c |  187 
>+++++++++++++++++++++++++++++++++++++++++++
>>  sound/soc/omap/omap-mcbsp.h |    2 +
>>  2 files changed, 189 insertions(+), 0 deletions(-)
>> 
>> diff --git a/sound/soc/omap/omap-mcbsp.c 
>b/sound/soc/omap/omap-mcbsp.c
>> index 6bbbd2a..295620b 100644
>> --- a/sound/soc/omap/omap-mcbsp.c
>> +++ b/sound/soc/omap/omap-mcbsp.c
>> @@ -39,6 +39,14 @@
>
>snip
>
>> +/* McBSP Sidetone Switch */
>> +static const char *omap_mcbsp_st_status[] = {
>> +	"off",
>> +	"on",
>> +};
>> +
>
>Should this not be a switch (like a mute switch) rather than an enum
>kcontrol ?

Makes sense. I'll change it.

>> +static const struct soc_enum omap_mcbsp_st_status_enum[] = {
>> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(omap_mcbsp_st_status),
>> +			    omap_mcbsp_st_status),
>> +};
>> +
>> +static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] = {
>> +	SOC_ENUM_EXT("McBSP2 Sidetone Switch", 
>omap_mcbsp_st_status_enum[0],
>> +			omap_mcbsp2_st_get_mode, 
>omap_mcbsp2_st_set_mode),
>> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 
>0 Volume",
>> +				      -32768, 32767,
>> +				      omap_mcbsp2_get_st_ch0_volume,
>> +				      omap_mcbsp2_set_st_ch0_volume),
>> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 
>1 Volume",
>> +				      -32768, 32767,
>> +				      omap_mcbsp2_get_st_ch1_volume,
>> +				      omap_mcbsp2_set_st_ch1_volume),
>> +};
>> +
>> +static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
>> +	SOC_ENUM_EXT("McBSP3 Sidetone Switch", 
>omap_mcbsp_st_status_enum[0],
>> +			omap_mcbsp3_st_get_mode, 
>omap_mcbsp3_st_set_mode),
>> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 
>0 Volume",
>> +				      -32768, 32767,
>> +				      omap_mcbsp3_get_st_ch0_volume,
>> +				      omap_mcbsp3_set_st_ch0_volume),
>> +	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 
>1 Volume",
>> +				      -32768, 32767,
>> +				      omap_mcbsp3_get_st_ch1_volume,
>> +				      omap_mcbsp3_set_st_ch1_volume),
>> +};
>> +
>> +int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, 
>int mcbsp_id)
>> +{
>> +	if (!cpu_is_omap34xx())
>> +		return -ENODEV;
>> +
>> +	switch (mcbsp_id) {
>> +	case 2: /* McBSP 2 */
>> +		return snd_soc_add_controls(codec, 
>omap_mcbsp2_st_controls,
>> +					
>ARRAY_SIZE(omap_mcbsp2_st_controls));
>> +	case 3: /* McBSP 3 */
>> +		return snd_soc_add_controls(codec, 
>omap_mcbsp3_st_controls,
>> +					
>ARRAY_SIZE(omap_mcbsp3_st_controls));
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -1;
>
>-EINVAL;

Oops, thanks.

Cheers, Ilkka

>> +}
>> +EXPORT_SYMBOL_GPL(omap_mcbsp_st_add_controls);
>> +
>>  static int __init snd_omap_mcbsp_init(void)
>>  {
>>  	return snd_soc_register_dais(omap_mcbsp_dai,
>> diff --git a/sound/soc/omap/omap-mcbsp.h 
>b/sound/soc/omap/omap-mcbsp.h
>> index 647d2f9..7537435 100644
>> --- a/sound/soc/omap/omap-mcbsp.h
>> +++ b/sound/soc/omap/omap-mcbsp.h
>> @@ -57,4 +57,6 @@ enum omap_mcbsp_div {
>>  
>>  extern struct snd_soc_dai omap_mcbsp_dai[NUM_LINKS];
>>  
>> +int omap_mcbsp_st_add_controls(struct snd_soc_codec *codec, 
>int mcbsp_id);
>> +
>>  #endif
>
>
>
