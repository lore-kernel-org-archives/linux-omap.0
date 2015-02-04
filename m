From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Wed, 4 Feb 2015 10:27:59 +0200
Message-ID: <54D1D80F.1090304@ti.com>
References: <54CF2CDA.3060607@ti.com> <1422888485-13626-1-git-send-email-jsarha@ti.com> <CA+sos78ar+MX2CvrjtzYN9MvtO9g=upMuOScXuXa2=zQ81qQwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46614 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932350AbbBDI2L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Feb 2015 03:28:11 -0500
In-Reply-To: <CA+sos78ar+MX2CvrjtzYN9MvtO9g=upMuOScXuXa2=zQ81qQwQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?QmVub8OudCBUaMOpYmF1ZGVhdQ==?= <benoit.thebaudeau.dev@gmail.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, Alsa-devel <alsa-devel@alsa-project.org>, devicetree@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, wlear@appliedlogix.com

On 02/04/2015 12:25 AM, Beno=C3=AEt Th=C3=A9baudeau wrote:
> Dear Jyri Sarha,
>=20
> Sorry to come late.
>=20
> On Mon, Feb 2, 2015 at 3:48 PM, Jyri Sarha <jsarha@ti.com> wrote:
> [...]
>> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv32=
0aic3x.c
>> index b7ebce0..cb92cdb 100644
>> --- a/sound/soc/codecs/tlv320aic3x.c
>> +++ b/sound/soc/codecs/tlv320aic3x.c
> [...]
>> @@ -550,6 +575,22 @@ static const struct snd_kcontrol_new aic3x_righ=
t_pga_mixer_controls[] =3D {
>>         SOC_DAPM_SINGLE_AIC3X("Mic3R Switch", MIC3LR_2_RADC_CTRL, 0,=
 1, 1),
>>  };
>>
>> +/* Left PGA Mixer for tlv320aic3104 */
>> +static const struct snd_kcontrol_new aic3104_left_pga_mixer_control=
s[] =3D {
>> +       SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_LADC_CTRL, 3=
, 1, 1),
>> +       SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_LADC_CTRL, 3=
, 1, 1),
>> +       SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_LADC_CTRL, 4,=
 1, 1),
>> +       SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_LADC_CTRL, 0,=
 1, 1),
>> +};
>> +
>> +/* Right PGA Mixer for tlv320aic3104 */
>> +static const struct snd_kcontrol_new aic3104_right_pga_mixer_contro=
ls[] =3D {
>> +       SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_RADC_CTRL, 3=
, 1, 1),
>> +       SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_RADC_CTRL, 3=
, 1, 1),
>> +       SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_RADC_CTRL, 4,=
 1, 1),
>> +       SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_RADC_CTRL, 0,=
 1, 1),
>> +};
>> +
>=20
> This part is wrong. All these controls should be turned into TLVs.
> Otherwise, because of the reset values of these registers, the
> reserved value 0b1110 is used for the corresponding bit-fields if
> their lsb is cleared using the controls above.

These mixers are using  custom put callbacks via SOC_DAPM_SINGLE_AIC3X(=
):
snd_soc_dapm_put_volsw_aic3x, this will make sure that the input level =
control
bits are handled right.
The driver does not have means to handle the gain on these registers, i=
t is
either 0db (connected) or not connected.

> Generally speaking, you have tracked reserved registers, but you
> should also track reserved values.
>=20
>>  /* Left Line1 Mux */
>>  static const struct snd_kcontrol_new aic3x_left_line1l_mux_controls=
 =3D
>>  SOC_DAPM_ENUM("Route", aic3x_line1l_2_l_enum);
> [...]
>> @@ -839,6 +890,72 @@ static const struct snd_soc_dapm_route intercon=
[] =3D {
> [...]
>> +/* For other than tlv320aic3104 */
>=20
> Typo above: not "other than" here.
>=20
>> +static const struct snd_soc_dapm_route intercon_extra_3104[] =3D {
>> +       /* Left Input */
>> +       {"Left PGA Mixer", "Mic2L Switch", "MIC2L"},
>> +       {"Left PGA Mixer", "Mic2R Switch", "MIC2R"},
>> +
>> +       /* Right Input */
>> +       {"Right PGA Mixer", "Mic2L Switch", "MIC2L"},
>> +       {"Right PGA Mixer", "Mic2R Switch", "MIC2R"},
>> +};
>> +
>>  static const struct snd_soc_dapm_route intercon_mono[] =3D {
>>         /* Mono Output */
>>         {"Mono Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
> [...]
>=20
> The rest is good.
>=20
> Best regards,
> Beno=C3=AEt
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
