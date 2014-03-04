From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 1/5] ASoC: tlv320aic31xx: Add basic codec driver implementation
Date: Tue, 4 Mar 2014 15:36:33 +0200
Message-ID: <5315D6E1.3010008@ti.com>
References: <cover.1393405575.git.jsarha@ti.com> <73198e2f7aca0379abc596027d7d59ac250061c7.1393405575.git.jsarha@ti.com> <20140303063444.GR2411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53962 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932104AbaCDNgl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 08:36:41 -0500
In-Reply-To: <20140303063444.GR2411@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, peter.ujfalusi@ti.com, detheridge@ti.com

On 03/03/2014 08:34 AM, Mark Brown wrote:
> On Wed, Feb 26, 2014 at 11:14:25AM +0200, Jyri Sarha wrote:
>> This commit adds a bare bones driver support for TLV320AIC31XX family
>> audio codecs. The driver adds basic stereo playback trough headphone
>> and speaker outputs and mono capture trough microphone inputs.
>
> Always CC maintainers on patches please.
>

Will do.

>> +static bool aic31xx_volatile(struct device *dev, unsigned int reg)
>> +{
>> +	if (aic31xx_precious(dev, reg) || aic31xx_real_volatile(dev, reg))
>> +		return true;
>> +
>> +	switch (reg) {
>> +	case AIC31XX_PAGECTL: /* regmap implementation requires this */
>> +	case AIC31XX_RESET: /* always clears after write */
>> +		return true;
>> +	}
>> +	return false;
>> +}
>
> This is more complex than you need, just write a standalone volatile
> function with some comments in it.
>

Replaced with straight forward aic31xx_volatile() and aic31xx_writable() 
functions.

>> +static const struct regmap_range_cfg aic31xx_ranges[] = {
>> +	{
>> +		.name = "codec-regmap",
>
> Make this meaningful or omit it.
>

Removed.

>> +#define AIC31XX_NUM_SUPPLIES	6
>> +static const char * const aic31xx_supply_names[] = {
>
> Use the define in the array size to help check everything lines up.
>

Done.

>> +static const char * const ldac_in_text[] = {
>> +	"off", "Left Data", "Right Data", "Mono"
>> +};
>
> Off not off - be consistent both internally and with the general style.
>

Done.

>> +static const struct snd_kcontrol_new aic311x_snd_controls[] = {
>> +	SOC_DOUBLE_R("SP Driver Playback Switch", AIC31XX_SPLGAIN,
>> +		     AIC31XX_SPRGAIN, 2, 1, 0),
>
> SP?
>

"SP" replaced with "Speaker", also in DAPM switches.

>> +	if (!strcmp(w->name, "DAC Left")) {
>> +		mask = AIC31XX_LDACPWRSTATUS_MASK;
>
> There's no overlap with the enable bits?  In general it would seem nicer
> to have a switch based on the register bits used for the enable rather
> than the tree of string comparisions but it's probably not that big a
> deal overall.
>

Not with bits, but with regs. I decided this structure would be easier 
to implement and understand than having a switch(w->reg) with nested 
switch(w->shift) cases. I replaced the string comparisons with a single 
switch case using a binary combination of w->reg and w->shift.

>> +		dev_err(w->codec->dev, "Unknown widget '%s' calling %s/n",
>> +			w->name, __func__);
>> +		return -1;		switch (w->shift) {
		case 7:
			mask = AIC31XX_LDACPWRSTATUS_MASK;

>
> Return real error codes.
>

Changed to -EINVAL.

>> +	if (event == SND_SOC_DAPM_POST_PMU)
>> +		return aic31xx_wait_bits(aic31xx, reg, mask, mask, 5000, 100);
>> +	else if (event == SND_SOC_DAPM_POST_PMD)
>> +		return aic31xx_wait_bits(aic31xx, reg, mask, 0, 5000, 100);
>
> switch.
>

Done.

>> +	SND_SOC_DAPM_DAC_E("DAC Right", "DAC Right Input",
>> +			   AIC31XX_DACSETUP, 6, 0, aic31xx_dapm_power_event,
>> +			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
>
> Don't use stream names, use DAPM to route from the AIF to the widgets.
>

Renamed DAC stnames to "Left Playback" and "Right Playback".

>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>> +		break;
>
> params_width().
>

Done.

>> +			    AIC31XX_IFACE1_DATALEN_MASK,
>> +			    data);
>> +
>> +	return aic31xx_setup_pll(codec, params);
>
> This is going to mean that you have a symmetry constraint I think, if
> you try to set up different rates for playback and capture presumably
> things will break.  Setting symmetric_rates will tell applications about
> that.
>

Done.

>> +	case SND_SOC_DAIFMT_CBS_CFM:
>> +	case SND_SOC_DAIFMT_CBM_CFS:
>> +	case SND_SOC_DAIFMT_CBS_CFS:
>> +		dev_err(codec->dev, "Unsupported DAI master/slave interface\n");
>> +		return -EINVAL;
>> +	default:
>> +		dev_alert(codec->dev, "Invalid DAI master/slave interface\n");
>> +		return -EINVAL;
>
> Just have a default.
>

Done.

>> +	for (i = 0; aic31xx_divs[i].mclk != freq; i++)
>> +		if (i == ARRAY_SIZE(aic31xx_divs)) {
>> +			dev_err(aic31xx->dev, "%s: Unsupported frequency %d\n",
>> +				__func__, freq);
>> +			return -EINVAL;
>> +		}
>
> Braces around the for () too please.
>

Done.

>> +static int aic31xx_set_power(struct snd_soc_codec *codec, int power)
>> +{
>> +	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
>> +	int ret;
>> +
>> +	dev_dbg(codec->dev, "## %s: %d -> %d\n", __func__,
>> +		aic31xx->power, power);
>> +	if (aic31xx->power == power)
>> +		return 0;
>
> This looks like you need sensible refcounting somewhere?  Implementing
> this as the standard PM operations may be sensible.
>

Not really. This was just avoid power on sequence when bias level goes 
from SND_SOC_BIAS_PREPARE back to SND_SOC_BIAS_STANDBY. I'll change this 
to a "if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)" in set_bias_level 
like other codecs do.

>> +		if (gpio_is_valid(aic31xx->pdata.gpio_reset)) {
>> +			gpio_set_value(aic31xx->pdata.gpio_reset, 1);
>> +			udelay(100);
>> +		}
>> +		snd_soc_write(codec, AIC31XX_RESET, 0x01);
>> +		udelay(100);
>> +		regcache_cache_only(aic31xx->regmap, false);
>
> You should be coming out of cache only mode before you issue the reset
> write.  Is it not sensible to skip that if you have a physical reset
> line?
>
>> +		snd_soc_write(codec, AIC31XX_RESET, 0x01);
>> +		regcache_cache_only(aic31xx->regmap, true);
>> +
>> +		if (gpio_is_valid(aic31xx->pdata.gpio_reset))
>> +			gpio_set_value(aic31xx->pdata.gpio_reset, 0);
>
> Likewise here.  Also if you do reset the CODEC then the dance you did
> with the regulator notifiers becomes pointless - the goal with that is
> to avoid the need to resync the cache if the CODEC wasn't actually reset
> by a power cycle but since the CODEC is going to be explicitly reset
> before it's powered off there's no benefit.
>

I rewrote the bias-level/power logic a bit. It should now look more like 
the other codecs. I hope you like this version better.

>> +	switch (level) {
>> +	/* full On */
>> +	case SND_SOC_BIAS_ON:
>> +		/* All power is driven by DAPM system*/
>> +		break;
>> +	/* partial On */
>
> Coding style, please.
>

Removed the redundant badly indented comments.

Fixed also the Kconfig and Makefile ordering and added dt-include for 
micbias and changed the default to 2.0V. All are now squashed to a 
single patch.

In addition to addressing your comments I also added an internal ADC 
input and DAC output for codec to turn on at playback/capture start even 
if the alsamixers are not set correctly.

I'll mail the patches shortly.

Best regards,
Jyri
