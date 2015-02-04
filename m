From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
	<benoit.thebaudeau.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Wed, 4 Feb 2015 10:33:28 +0100
Message-ID: <CA+sos797a7CT2KqCwrW5CaL1vF0GVCHQGxp3gDAB7PTFi4jZjQ@mail.gmail.com>
References: <54CF2CDA.3060607@ti.com> <1422888485-13626-1-git-send-email-jsarha@ti.com>
 <CA+sos78ar+MX2CvrjtzYN9MvtO9g=upMuOScXuXa2=zQ81qQwQ@mail.gmail.com> <54D1D80F.1090304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54D1D80F.1090304-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wlear-uoOHlzqel7feqrA4Bvp/NA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Dear Peter Ujfalusi,

On Wed, Feb 4, 2015 at 9:27 AM, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> =
wrote:
> On 02/04/2015 12:25 AM, Beno=C3=AEt Th=C3=A9baudeau wrote:
>> On Mon, Feb 2, 2015 at 3:48 PM, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:
>> [...]
>>> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv3=
20aic3x.c
>>> index b7ebce0..cb92cdb 100644
>>> --- a/sound/soc/codecs/tlv320aic3x.c
>>> +++ b/sound/soc/codecs/tlv320aic3x.c
>> [...]
>>> @@ -550,6 +575,22 @@ static const struct snd_kcontrol_new aic3x_rig=
ht_pga_mixer_controls[] =3D {
>>>         SOC_DAPM_SINGLE_AIC3X("Mic3R Switch", MIC3LR_2_RADC_CTRL, 0=
, 1, 1),
>>>  };
>>>
>>> +/* Left PGA Mixer for tlv320aic3104 */
>>> +static const struct snd_kcontrol_new aic3104_left_pga_mixer_contro=
ls[] =3D {
>>> +       SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_LADC_CTRL, =
3, 1, 1),
>>> +       SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_LADC_CTRL, =
3, 1, 1),
>>> +       SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_LADC_CTRL, 4=
, 1, 1),
>>> +       SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_LADC_CTRL, 0=
, 1, 1),
>>> +};
>>> +
>>> +/* Right PGA Mixer for tlv320aic3104 */
>>> +static const struct snd_kcontrol_new aic3104_right_pga_mixer_contr=
ols[] =3D {
>>> +       SOC_DAPM_SINGLE_AIC3X("Line1R Switch", LINE1R_2_RADC_CTRL, =
3, 1, 1),
>>> +       SOC_DAPM_SINGLE_AIC3X("Line1L Switch", LINE1L_2_RADC_CTRL, =
3, 1, 1),
>>> +       SOC_DAPM_SINGLE_AIC3X("Mic2L Switch", MIC3LR_2_RADC_CTRL, 4=
, 1, 1),
>>> +       SOC_DAPM_SINGLE_AIC3X("Mic2R Switch", MIC3LR_2_RADC_CTRL, 0=
, 1, 1),
>>> +};
>>> +
>>
>> This part is wrong. All these controls should be turned into TLVs.
>> Otherwise, because of the reset values of these registers, the
>> reserved value 0b1110 is used for the corresponding bit-fields if
>> their lsb is cleared using the controls above.
>
> These mixers are using  custom put callbacks via SOC_DAPM_SINGLE_AIC3=
X():
> snd_soc_dapm_put_volsw_aic3x, this will make sure that the input leve=
l control
> bits are handled right.
> The driver does not have means to handle the gain on these registers,=
 it is
> either 0db (connected) or not connected.

What I meant was to do the following instead:

/*
 * ADC PGA mix input volumes. From -12 to 0 dB in 1.5 dB steps. Disconn=
ected
 * below -12 dB
 */
static const DECLARE_TLV_DB_SCALE(mix_tlv, -1350, 150, 1);

/* Left PGA Mixer for tlv320aic3104 */
static const struct snd_kcontrol_new aic3104_left_pga_mixer_controls[] =
=3D {
    SOC_DAPM_SINGLE_MUT_TLV("Line1L Volume",
                LINE1L_2_LADC_CTRL, 3, 7, 15, 1, mix_tlv),
    SOC_DAPM_SINGLE_MUT_TLV("Line1R Volume",
                LINE1R_2_LADC_CTRL, 3, 7, 15, 1, mix_tlv),
    SOC_DAPM_SINGLE_MUT_TLV("Mic2L Volume",
                MIC3LR_2_LADC_CTRL, 4, 7, 15, 1, mix_tlv),
    SOC_DAPM_SINGLE_MUT_TLV("Mic2R Volume",
                MIC3LR_2_LADC_CTRL, 0, 7, 15, 1, mix_tlv),
};

/* Right PGA Mixer for tlv320aic3104 */
static const struct snd_kcontrol_new aic3104_right_pga_mixer_controls[]=
 =3D {
    SOC_DAPM_SINGLE_MUT_TLV("Line1R Volume",
                LINE1R_2_RADC_CTRL, 3, 7, 15, 1, mix_tlv),
    SOC_DAPM_SINGLE_MUT_TLV("Line1L Volume",
                LINE1L_2_RADC_CTRL, 3, 7, 15, 1, mix_tlv),
    SOC_DAPM_SINGLE_MUT_TLV("Mic2L Volume",
                MIC3LR_2_RADC_CTRL, 4, 7, 15, 1, mix_tlv),
    SOC_DAPM_SINGLE_MUT_TLV("Mic2R Volume",
                MIC3LR_2_RADC_CTRL, 0, 7, 15, 1, mix_tlv),
};

Then, use the following instead of the "Switch" for the tlv320aic3104 i=
nterconn:
    {"Left PGA Mixer", "Line1L Volume", "Left Line1L Mux"},
    {"Left PGA Mixer", "Line1R Volume", "Left Line1R Mux"},
    {"Left PGA Mixer", "Mic2L Volume", "MIC2L"},
    {"Left PGA Mixer", "Mic2R Volume", "MIC2R"},

    {"Right PGA Mixer", "Line1L Volume", "Right Line1L Mux"},
    {"Right PGA Mixer", "Line1R Volume", "Right Line1R Mux"},
    {"Right PGA Mixer", "Mic2L Volume", "MIC2L"},
    {"Right PGA Mixer", "Mic2R Volume", "MIC2R"},

Best regards,
Beno=C3=AEt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
