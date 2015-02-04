From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
	<benoit.thebaudeau.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Wed, 4 Feb 2015 12:11:13 +0100
Message-ID: <CA+sos7_kRHru5_AZcVyhzYHtA3JkdcRVfq=bT3X=bMWjFvrd=Q@mail.gmail.com>
References: <54CF2CDA.3060607@ti.com> <1422888485-13626-1-git-send-email-jsarha@ti.com>
 <CA+sos78ar+MX2CvrjtzYN9MvtO9g=upMuOScXuXa2=zQ81qQwQ@mail.gmail.com>
 <54D1D80F.1090304@ti.com> <CA+sos797a7CT2KqCwrW5CaL1vF0GVCHQGxp3gDAB7PTFi4jZjQ@mail.gmail.com>
 <54D1EE24.3000309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54D1EE24.3000309-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alsa-devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, wlear-uoOHlzqel7feqrA4Bvp/NA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Dear Peter Ujfalusi,

On Wed, Feb 4, 2015 at 11:02 AM, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>=
 wrote:
> On 02/04/2015 11:33 AM, Beno=C3=AEt Th=C3=A9baudeau wrote:
>> What I meant was to do the following instead:
>>
>> /*
>>  * ADC PGA mix input volumes. From -12 to 0 dB in 1.5 dB steps. Disc=
onnected
>>  * below -12 dB
>>  */
>> static const DECLARE_TLV_DB_SCALE(mix_tlv, -1350, 150, 1);
>>
>> /* Left PGA Mixer for tlv320aic3104 */
>> static const struct snd_kcontrol_new aic3104_left_pga_mixer_controls=
[] =3D {
>>     SOC_DAPM_SINGLE_MUT_TLV("Line1L Volume",
>>                 LINE1L_2_LADC_CTRL, 3, 7, 15, 1, mix_tlv),
>
> You mean SOC_DAPM_SINGLE_TLV() ?

No. It would not fit our needs here.

> There is no _MUT_ variant AFAIK.

Indeed, but support could be added, for it, something like (might need
updating and some other changes in DAPM):

#define SOC_DAPM_SINGLE_MUT_TLV(xname, reg, shift, min, max, invert,
tlv_array) \
{    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D xname, \
    .info =3D snd_soc_info_volsw_mut, \
    .access =3D SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_=
READWRITE,\
    .tlv.p =3D (tlv_array), \
    .get =3D snd_soc_dapm_get_volsw_mut, .put =3D snd_soc_dapm_put_vols=
w_mut, \
    .private_value =3D SOC_SINGLE_MUT_VALUE(reg, shift, min, max, inver=
t) }

/**
 * snd_soc_dapm_get_volsw_mut - dapm mixer get callback
 * @kcontrol: mixer control
 * @ucontrol: control element information
 *
 * Callback to get the value of a dapm mixer control with a hole separa=
ting the
 * mute value from the other valid values.
 *
 * Returns 0 for success.
 */
int snd_soc_dapm_get_volsw_mut(struct snd_kcontrol *kcontrol,
    struct snd_ctl_elem_value *ucontrol)
{
    struct snd_soc_dapm_widget_list *wlist =3D snd_kcontrol_chip(kcontr=
ol);
    struct snd_soc_dapm_widget *widget =3D wlist->widgets[0];
    struct soc_mixer_control *mc =3D
        (struct soc_mixer_control *)kcontrol->private_value;
    unsigned int reg =3D mc->reg;
    unsigned int shift =3D mc->shift;
    unsigned int rshift =3D mc->rshift;
    int min =3D mc->min;
    int max =3D mc->max;
    unsigned int invert =3D mc->invert;
    unsigned int mask =3D (1 << fls(max)) - 1;

    ucontrol->value.integer.value[0] =3D
        (snd_soc_read(widget->codec, reg) >> shift) & mask;
    if (shift !=3D rshift)
        ucontrol->value.integer.value[1] =3D
            (snd_soc_read(widget->codec, reg) >> rshift) & mask;
    if (invert) {
        ucontrol->value.integer.value[0] =3D
            mask - ucontrol->value.integer.value[0];
        if (shift !=3D rshift)
            ucontrol->value.integer.value[1] =3D
                mask - ucontrol->value.integer.value[1];
    }
    if (ucontrol->value.integer.value[0] > 0)
        ucontrol->value.integer.value[0] -=3D min - 1;
    if (shift !=3D rshift)
        if (ucontrol->value.integer.value[1] > 0)
            ucontrol->value.integer.value[1] -=3D min - 1;

    return 0;
}
EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw_mut);

/**
 * snd_soc_dapm_put_volsw_mut - dapm mixer set callback
 * @kcontrol: mixer control
 * @ucontrol: control element information
 *
 * Callback to set the value of a dapm mixer control with a hole separa=
ting the
 * mute value from the other valid values.
 *
 * Returns 0 for success.
 */
int snd_soc_dapm_put_volsw_mut(struct snd_kcontrol *kcontrol,
    struct snd_ctl_elem_value *ucontrol)
{
    struct snd_soc_dapm_widget_list *wlist =3D snd_kcontrol_chip(kcontr=
ol);
    struct snd_soc_dapm_widget *widget =3D wlist->widgets[0];
    struct snd_soc_codec *codec =3D widget->codec;
    struct soc_mixer_control *mc =3D
        (struct soc_mixer_control *)kcontrol->private_value;
    unsigned int reg =3D mc->reg;
    unsigned int shift =3D mc->shift;
    int min =3D mc->min;
    int max =3D mc->max;
    unsigned int mask =3D (1 << fls(max)) - 1;
    unsigned int invert =3D mc->invert;
    unsigned int val;
    int connect, change;
    struct snd_soc_dapm_update update;
    int wi;

    val =3D (ucontrol->value.integer.value[0] & mask);
    connect =3D !!val;

    if (val)
        val +=3D min - 1;
    if (invert)
        val =3D mask - val;
    mask =3D mask << shift;
    val =3D val << shift;

    mutex_lock(&codec->mutex);

    change =3D snd_soc_test_bits(widget->codec, reg, mask, val);
    if (change) {
        for (wi =3D 0; wi < wlist->num_widgets; wi++) {
            widget =3D wlist->widgets[wi];

            widget->value =3D val;

            update.kcontrol =3D kcontrol;
            update.widget =3D widget;
            update.reg =3D reg;
            update.mask =3D mask;
            update.val =3D val;
            widget->dapm->update =3D &update;

            dapm_mixer_update_power(widget, kcontrol, connect);

            widget->dapm->update =3D NULL;
        }
    }

    mutex_unlock(&codec->mutex);
    return 0;
}
EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw_mut);

> According to the datasheets of aic3106, aic3104:
> 0b0000 - 0b1000 is valid (0 - -12 dB)
> 0b1001 - 0b1110 is reserved, do not write these sequences to the regi=
ster
> 0b1111 is disconnected.
>
> And for fun the aic3007's reg20 for example:
> 0b0000 - 0dB
> 0b0001 - 0b0011 - reserved
> 0b0100 - -6dB
> 0b0101 - 0b0111 - reserved
> 0b1000 - -12dB
> 0b1001 - 0b1110 - reserved
> 0b1111 - disconnected
>
> Note that the driver never had control for these gains and the aic310=
4 support
> is following this behavior, but if we do it for aic3104 we should do =
it for
> all other support codecs as well as a followup patch or series. IMHO.

I had not checked the other CODECs. So for all these CODECs, toggling
either as 0b0000/0b0001 or as 0b1110/0b1111 (like the driver currently
does) is wrong. I agree that they should be fixed too. But for them,
it's even more complicated because of the multiple reserved value
ranges. Or maybe we could just ignore these reserved ranges and handle
the mute value, but that would mean relying on the user not to use
reserved values. So maybe use TLV_DB_RANGE_HEAD() and
TLV_DB_SCALE_ITEM() to define mix_tlv, then use
SOC_(DAPM_)SINGLE_TLV().

Best regards,
Beno=C3=AEt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
