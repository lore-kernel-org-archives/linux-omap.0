From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec driver
Date: Thu, 25 Feb 2010 10:17:10 +0000
Message-ID: <20100225101710.GE10141@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
 <1267007881.3274.136.camel@odin>
 <1889FA7136B567478A67D4B0F85B0CCE65DD22C9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46588 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754838Ab0BYKRN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 05:17:13 -0500
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD22C9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 24, 2010 at 05:37:44PM -0600, Olaya, Margarita wrote:
> > -----Original Message-----
> > From: Liam Girdwood [mailto:lrg@slimlogic.co.uk]

> > Are these two functions writing the default codec register values to the
> > CODEC or are these non default (i.e. reset) values. If they are reset
> > values is it not better to just issue the reset (and save the slow I2C
> > writes) ?

> Yeap, but they write non default values to most of the registers.

Why are these non-default values being set?  The general style with
things like this is that the register defaults listed in the driver are
the physical defaults, and any explicit configuration is done with
register writes.  This makes it clearer what's being changed and means
that the actual register defaults are there for use if required.

Normally only things that should be changed for all systems would be
configured in this manner, things like audio paths which might change
per system would be left for userspace to configure.

BTW, please remember to delete unneeded context from your mails when
replying - it makes them much easier to read since the new text isn't
buried in many page of quotations (especially so when reading mail on a
mobile device).

> 
> >
> > > +/*
> > > + * MICATT volume control:
> > > + * from -6 to 0 dB in 6 dB steps
> > > + */
> > > +static DECLARE_TLV_DB_SCALE(mic_preamp_tlv, -600, 600, 0);
> > > +
> > > +/*
> > > + * MICGAIN volume control:
> > > + * from 6 to 30 dB in 6 dB steps
> > > + */
> > > +static DECLARE_TLV_DB_SCALE(mic_amp_tlv, 600, 600, 0);
> > > +
> > > +/*
> > > + * HSGAIN volume control:
> > > + * from -30 to 0 dB in 2 dB steps
> > > + */
> > > +static DECLARE_TLV_DB_SCALE(hs_tlv, -3000, 200, 0);
> > > +
> > > +/*
> > > + * HFGAIN volume control:
> > > + * from -52 to 6 dB in 2 dB steps
> > > + */
> > > +static DECLARE_TLV_DB_SCALE(hf_tlv, -5200, 200, 0);
> > > +
> > > +/* Left analog microphone selection */
> > > +static const char *twl6030_amicl_texts[] =
> > > +       {"Headset Mic", "Main Mic", "Aux/FM Left", "Off"};
> > > +
> > > +/* Right analog microphone selection */
> > > +static const char *twl6030_amicr_texts[] =
> > > +       {"Headset Mic", "Sub Mic", "Aux/FM Right", "Off"};
> > > +
> > > +static const struct soc_enum twl6030_enum[] = {
> > > +       SOC_ENUM_SINGLE(TWL6030_REG_MICLCTL, 3, 3, twl6030_amicl_texts),
> > > +       SOC_ENUM_SINGLE(TWL6030_REG_MICRCTL, 3, 3, twl6030_amicr_texts),
> > > +};
> > > +
> > > +static const struct snd_kcontrol_new amicl_control =
> > > +       SOC_DAPM_ENUM("Route", twl6030_enum[0]);
> > > +
> > > +static const struct snd_kcontrol_new amicr_control =
> > > +       SOC_DAPM_ENUM("Route", twl6030_enum[1]);
> > > +
> > > +/* Headset DAC playback switches */
> > > +static const struct snd_kcontrol_new hsdacl_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSLCTL, 5, 1, 0);
> > > +
> > > +static const struct snd_kcontrol_new hsdacr_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSRCTL, 5, 1, 0);
> > > +
> > > +/* Handsfree DAC playback switches */
> > > +static const struct snd_kcontrol_new hfdacl_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFLCTL, 2, 1, 0);
> > > +
> > > +static const struct snd_kcontrol_new hfdacr_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFRCTL, 2, 1, 0);
> > > +
> > > +/* Headset driver switches */
> > > +static const struct snd_kcontrol_new hsl_driver_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSLCTL, 2, 1, 0);
> > > +
> > > +static const struct snd_kcontrol_new hsr_driver_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSRCTL, 2, 1, 0);
> > > +
> > > +/* Handsfree driver switches */
> > > +static const struct snd_kcontrol_new hfl_driver_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFLCTL, 4, 1, 0);
> > > +
> > > +static const struct snd_kcontrol_new hfr_driver_switch_controls =
> > > +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFRCTL, 4, 1, 0);
> > > +
> > > +static const struct snd_kcontrol_new twl6030_snd_controls[] = {
> > > +       /* Capture gains */
> > > +       SOC_DOUBLE_TLV("Capture Preamplifier Volume",
> > > +               TWL6030_REG_MICGAIN, 6, 7, 1, 1, mic_preamp_tlv),
> > > +       SOC_DOUBLE_TLV("Capture Volume",
> > > +               TWL6030_REG_MICGAIN, 0, 3, 4, 0, mic_amp_tlv),
> > > +
> > > +       /* Playback gains */
> > > +       SOC_DOUBLE_TLV("Headset Playback Volume",
> > > +               TWL6030_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
> > > +       SOC_DOUBLE_R_TLV("Handsfree Playback Volume",
> > > +               TWL6030_REG_HFLGAIN, TWL6030_REG_HFRGAIN, 0, 0x1D, 1, hf_tlv),
> > > +
> > > +};
> > > +
> > > +static const struct snd_soc_dapm_widget twl6030_dapm_widgets[] = {
> > > +       /* Inputs */
> > > +       SND_SOC_DAPM_INPUT("MAINMIC"),
> > > +       SND_SOC_DAPM_INPUT("HSMIC"),
> > > +       SND_SOC_DAPM_INPUT("SUBMIC"),
> > > +       SND_SOC_DAPM_INPUT("AFML"),
> > > +       SND_SOC_DAPM_INPUT("AFMR"),
> > > +
> > > +       /* Outputs */
> > > +       SND_SOC_DAPM_OUTPUT("HSOL"),
> > > +       SND_SOC_DAPM_OUTPUT("HSOR"),
> > > +       SND_SOC_DAPM_OUTPUT("HFL"),
> > > +       SND_SOC_DAPM_OUTPUT("HFR"),
> > > +
> > > +       /* Analog input muxes for the capture amplifiers */
> > > +       SND_SOC_DAPM_MUX("Analog Left Capture Route",
> > > +                       SND_SOC_NOPM, 0, 0, &amicl_control),
> > > +       SND_SOC_DAPM_MUX("Analog Right Capture Route",
> > > +                       SND_SOC_NOPM, 0, 0, &amicr_control),
> > > +
> > > +       /* Analog capture PGAs */
> > > +       SND_SOC_DAPM_PGA("MicAmpL",
> > > +                       TWL6030_REG_MICLCTL, 0, 0, NULL, 0),
> > > +       SND_SOC_DAPM_PGA("MicAmpR",
> > > +                       TWL6030_REG_MICRCTL, 0, 0, NULL, 0),
> > > +
> > > +       /* ADCs */
> > > +       SND_SOC_DAPM_ADC("ADC Left", "Left Front Capture",
> > > +                       TWL6030_REG_MICLCTL, 2, 0),
> > > +       SND_SOC_DAPM_ADC("ADC Right", "Right Front Capture",
> > > +                       TWL6030_REG_MICRCTL, 2, 0),
> > > +
> > > +       /* Microphone bias */
> > > +       SND_SOC_DAPM_MICBIAS("Headset Mic Bias",
> > > +                       TWL6030_REG_AMICBCTL, 0, 0),
> > > +       SND_SOC_DAPM_MICBIAS("Main Mic Bias",
> > > +                       TWL6030_REG_AMICBCTL, 4, 0),
> > > +       SND_SOC_DAPM_MICBIAS("Digital Mic1 Bias",
> > > +                       TWL6030_REG_DMICBCTL, 0, 0),
> > > +       SND_SOC_DAPM_MICBIAS("Digital Mic2 Bias",
> > > +                       TWL6030_REG_DMICBCTL, 4, 0),
> > > +
> > > +       /* DACs */
> > > +       SND_SOC_DAPM_DAC("HSDAC Left", "Headset Playback",
> > > +                       TWL6030_REG_HSLCTL, 0, 0),
> > > +       SND_SOC_DAPM_DAC("HSDAC Right", "Headset Playback",
> > > +                       TWL6030_REG_HSRCTL, 0, 0),
> > > +       SND_SOC_DAPM_DAC("HFDAC Left", "Handsfree Playback",
> > > +                       TWL6030_REG_HFLCTL, 0, 0),
> > > +       SND_SOC_DAPM_DAC("HFDAC Right", "Handsfree Playback",
> > > +                       TWL6030_REG_HFRCTL, 0, 0),
> > > +
> > > +       /* Analog playback switches */
> > > +       SND_SOC_DAPM_SWITCH("HSDAC Left Playback",
> > > +                       SND_SOC_NOPM, 0, 0, &hsdacl_switch_controls),
> > > +       SND_SOC_DAPM_SWITCH("HSDAC Right Playback",
> > > +                       SND_SOC_NOPM, 0, 0, &hsdacr_switch_controls),
> > > +       SND_SOC_DAPM_SWITCH("HFDAC Left Playback",
> > > +                       SND_SOC_NOPM, 0, 0, &hfdacl_switch_controls),
> > > +       SND_SOC_DAPM_SWITCH("HFDAC Right Playback",
> > > +                       SND_SOC_NOPM, 0, 0, &hfdacr_switch_controls),
> > > +
> > > +       SND_SOC_DAPM_SWITCH("Headset Left Driver",
> > > +                       SND_SOC_NOPM, 0, 0, &hsl_driver_switch_controls),
> > > +       SND_SOC_DAPM_SWITCH("Headset Right Driver",
> > > +                       SND_SOC_NOPM, 0, 0, &hsr_driver_switch_controls),
> > > +       SND_SOC_DAPM_SWITCH("Handsfree Left Driver",
> > > +                       SND_SOC_NOPM, 0, 0, &hfl_driver_switch_controls),
> > > +       SND_SOC_DAPM_SWITCH("Handsfree Right Driver",
> > > +                       SND_SOC_NOPM, 0, 0, &hfr_driver_switch_controls),
> > > +
> > > +       /* Analog playback PGAs */
> > > +       SND_SOC_DAPM_PGA("HFDAC Left PGA",
> > > +                       TWL6030_REG_HFLCTL, 1, 0, NULL, 0),
> > > +       SND_SOC_DAPM_PGA("HFDAC Right PGA",
> > > +                       TWL6030_REG_HFRCTL, 1, 0, NULL, 0),
> > > +
> > > +};
> > > +
> > > +static const struct snd_soc_dapm_route intercon[] = {
> > > +       /* Capture path */
> > > +       {"Analog Left Capture Route", "Headset Mic", "HSMIC"},
> > > +       {"Analog Left Capture Route", "Main Mic", "MAINMIC"},
> > > +       {"Analog Left Capture Route", "Aux/FM Left", "AFML"},
> > > +
> > > +       {"Analog Right Capture Route", "Headset Mic", "HSMIC"},
> > > +       {"Analog Right Capture Route", "Sub Mic", "SUBMIC"},
> > > +       {"Analog Right Capture Route", "Aux/FM Right", "AFMR"},
> > > +
> > > +       {"MicAmpL", NULL, "Analog Left Capture Route"},
> > > +       {"MicAmpR", NULL, "Analog Right Capture Route"},
> > > +
> > > +       {"ADC Left", NULL, "MicAmpL"},
> > > +       {"ADC Right", NULL, "MicAmpR"},
> > > +
> > > +       /* Headset playback path */
> > > +       {"HSDAC Left Playback", "Switch", "HSDAC Left"},
> > > +       {"HSDAC Right Playback", "Switch", "HSDAC Right"},
> > > +
> > > +       {"Headset Left Driver", "Switch", "HSDAC Left Playback"},
> > > +       {"Headset Right Driver", "Switch", "HSDAC Right Playback"},
> > > +
> > > +       {"HSOL", NULL, "Headset Left Driver"},
> > > +       {"HSOR", NULL, "Headset Right Driver"},
> > > +
> > > +       /* Handsfree playback path */
> > > +       {"HFDAC Left Playback", "Switch", "HFDAC Left"},
> > > +       {"HFDAC Right Playback", "Switch", "HFDAC Right"},
> > > +
> > > +       {"HFDAC Left PGA", NULL, "HFDAC Left Playback"},
> > > +       {"HFDAC Right PGA", NULL, "HFDAC Right Playback"},
> > > +
> > > +       {"Handsfree Left Driver", "Switch", "HFDAC Left PGA"},
> > > +       {"Handsfree Right Driver", "Switch", "HFDAC Right PGA"},
> > > +
> > > +       {"HFL", NULL, "Handsfree Left Driver"},
> > > +       {"HFR", NULL, "Handsfree Right Driver"},
> > > +};
> > > +
> > > +static int twl6030_add_widgets(struct snd_soc_codec *codec)
> > > +{
> > > +       snd_soc_dapm_new_controls(codec, twl6030_dapm_widgets,
> > > +                                ARRAY_SIZE(twl6030_dapm_widgets));
> > > +
> > > +       snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
> > > +
> > > +       snd_soc_dapm_new_widgets(codec);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int twl6030_set_bias_level(struct snd_soc_codec *codec,
> > > +                               enum snd_soc_bias_level level)
> > > +{
> > > +       struct twl6030_data *priv = codec->private_data;
> > > +       int audpwron = priv->audpwron;
> > > +
> > > +       switch (level) {
> > > +       case SND_SOC_BIAS_ON:
> > > +       case SND_SOC_BIAS_PREPARE:
> > > +       case SND_SOC_BIAS_STANDBY:
> > > +               if (priv->codec_powered)
> > > +                       break;
> > > +
> > > +               if (gpio_is_valid(audpwron)) {
> > > +                       /* use AUDPWRON line */
> > > +                       gpio_set_value(audpwron, 1);
> > > +
> > > +                       /* power-up sequence latency */
> > > +                       mdelay(16);
> >
> > This is perhaps too long for mdelay. Probably want to sleep here.
> 
> Ok, I'll change it.
> 
> Regards,
> Margarita
> >
> > Thanks
> >
> > Liam
> >
> > --
> > Freelance Developer, SlimLogic Ltd
> > ASoC and Voltage Regulator Maintainer.
> > http://www.slimlogic.co.uk
> 
