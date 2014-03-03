From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/5] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Mon, 3 Mar 2014 14:34:44 +0800
Message-ID: <20140303063444.GR2411@sirena.org.uk>
References: <cover.1393405575.git.jsarha@ti.com>
 <73198e2f7aca0379abc596027d7d59ac250061c7.1393405575.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyi3v9V9xafcEDI/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <73198e2f7aca0379abc596027d7d59ac250061c7.1393405575.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--oyi3v9V9xafcEDI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2014 at 11:14:25AM +0200, Jyri Sarha wrote:
> This commit adds a bare bones driver support for TLV320AIC31XX family
> audio codecs. The driver adds basic stereo playback trough headphone
> and speaker outputs and mono capture trough microphone inputs.

Always CC maintainers on patches please.

> +static bool aic31xx_volatile(struct device *dev, unsigned int reg)
> +{
> +	if (aic31xx_precious(dev, reg) || aic31xx_real_volatile(dev, reg))
> +		return true;
> +
> +	switch (reg) {
> +	case AIC31XX_PAGECTL: /* regmap implementation requires this */
> +	case AIC31XX_RESET: /* always clears after write */
> +		return true;
> +	}
> +	return false;
> +}

This is more complex than you need, just write a standalone volatile
function with some comments in it.

> +static const struct regmap_range_cfg aic31xx_ranges[] = {
> +	{
> +		.name = "codec-regmap",

Make this meaningful or omit it.

> +#define AIC31XX_NUM_SUPPLIES	6
> +static const char * const aic31xx_supply_names[] = {

Use the define in the array size to help check everything lines up.

> +static const char * const ldac_in_text[] = {
> +	"off", "Left Data", "Right Data", "Mono"
> +};

Off not off - be consistent both internally and with the general style.

> +static const struct snd_kcontrol_new aic311x_snd_controls[] = {
> +	SOC_DOUBLE_R("SP Driver Playback Switch", AIC31XX_SPLGAIN,
> +		     AIC31XX_SPRGAIN, 2, 1, 0),

SP?

> +	if (!strcmp(w->name, "DAC Left")) {
> +		mask = AIC31XX_LDACPWRSTATUS_MASK;

There's no overlap with the enable bits?  In general it would seem nicer
to have a switch based on the register bits used for the enable rather
than the tree of string comparisions but it's probably not that big a
deal overall.

> +		dev_err(w->codec->dev, "Unknown widget '%s' calling %s/n",
> +			w->name, __func__);
> +		return -1;

Return real error codes.

> +	if (event == SND_SOC_DAPM_POST_PMU)
> +		return aic31xx_wait_bits(aic31xx, reg, mask, mask, 5000, 100);
> +	else if (event == SND_SOC_DAPM_POST_PMD)
> +		return aic31xx_wait_bits(aic31xx, reg, mask, 0, 5000, 100);

switch.

> +	SND_SOC_DAPM_DAC_E("DAC Right", "DAC Right Input",
> +			   AIC31XX_DACSETUP, 6, 0, aic31xx_dapm_power_event,
> +			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),

Don't use stream names, use DAPM to route from the AIF to the widgets.

> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		break;

params_width().

> +			    AIC31XX_IFACE1_DATALEN_MASK,
> +			    data);
> +
> +	return aic31xx_setup_pll(codec, params);

This is going to mean that you have a symmetry constraint I think, if
you try to set up different rates for playback and capture presumably
things will break.  Setting symmetric_rates will tell applications about
that.

> +	case SND_SOC_DAIFMT_CBS_CFM:
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		dev_err(codec->dev, "Unsupported DAI master/slave interface\n");
> +		return -EINVAL;
> +	default:
> +		dev_alert(codec->dev, "Invalid DAI master/slave interface\n");
> +		return -EINVAL;

Just have a default.

> +	for (i = 0; aic31xx_divs[i].mclk != freq; i++)
> +		if (i == ARRAY_SIZE(aic31xx_divs)) {
> +			dev_err(aic31xx->dev, "%s: Unsupported frequency %d\n",
> +				__func__, freq);
> +			return -EINVAL;
> +		}

Braces around the for () too please.

> +static int aic31xx_set_power(struct snd_soc_codec *codec, int power)
> +{
> +	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	dev_dbg(codec->dev, "## %s: %d -> %d\n", __func__,
> +		aic31xx->power, power);
> +	if (aic31xx->power == power)
> +		return 0;

This looks like you need sensible refcounting somewhere?  Implementing
this as the standard PM operations may be sensible.

> +		if (gpio_is_valid(aic31xx->pdata.gpio_reset)) {
> +			gpio_set_value(aic31xx->pdata.gpio_reset, 1);
> +			udelay(100);
> +		}
> +		snd_soc_write(codec, AIC31XX_RESET, 0x01);
> +		udelay(100);
> +		regcache_cache_only(aic31xx->regmap, false);

You should be coming out of cache only mode before you issue the reset
write.  Is it not sensible to skip that if you have a physical reset
line?

> +		snd_soc_write(codec, AIC31XX_RESET, 0x01);
> +		regcache_cache_only(aic31xx->regmap, true);
> +
> +		if (gpio_is_valid(aic31xx->pdata.gpio_reset))
> +			gpio_set_value(aic31xx->pdata.gpio_reset, 0);

Likewise here.  Also if you do reset the CODEC then the dance you did
with the regulator notifiers becomes pointless - the goal with that is
to avoid the need to resync the cache if the CODEC wasn't actually reset
by a power cycle but since the CODEC is going to be explicitly reset
before it's powered off there's no benefit.

> +	switch (level) {
> +	/* full On */
> +	case SND_SOC_BIAS_ON:
> +		/* All power is driven by DAPM system*/
> +		break;
> +	/* partial On */

Coding style, please.

--oyi3v9V9xafcEDI/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFCJ8AAoJELSic+t+oim9rZsQAIJehOjNiow17xo+3ldDV2Bp
NlOZ68IrYQ43kZX5Lk1aZ783hH8xOMrHyHiLB2HvPu2cdk5c8mkD3huCTjRKULAv
LfnYQxaNoN38oY5zNi3lw0681Ofq3n9OUR0fghY3McVDayQTTbPpcNOnJZbzrOIy
8hKv6HxsI+q1ZKQHfEyN6dz7ugDpa3OAUoGNIgi2hQEb8TTWxFKdaC+G0LM7IHQ+
/V8u3oQfujImPtssQdGbWv5LaALiCAICsSu6YylCoChpBHDKTbCnjLZEIm/ceWcQ
NxvQlRwc+HW/pYEpWfP4n6wkkUZT2fOeA7leIuct8d6xzvJqAT8okzwrA4sLYyKQ
ytBQiqXQi/9dLQtamdiKo/YN5T7pIlk2fQSQN08q/jDFAs6c7jxtMFd5zKGE1ZcV
vXfbrlWI1v7rsSwfYPfBevv8j/bpZ+3/SITw521wFRnHiXlBIp5bqxp0g4sEh6Uz
lP2GNciEr/fvqpyLk0RxpbYNrqhCyTV41tfc1eB2B/kFeRg3/TM10tnorlO7jAoD
mc3L0Jj1DvMfivNosN2bH1B9MndlwsPdFUKTA/mQYCL4Ze2rmb44nunpk8UfchFh
QVW2wJ2oJZmDJ4zm8799sGDUOgzkBuExpchkfOTALDj573/i61reCVJ6EP4HYtj2
XI0vM9GQndD0P2mGtmg6
=Fvm3
-----END PGP SIGNATURE-----

--oyi3v9V9xafcEDI/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
