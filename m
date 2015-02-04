From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
	<benoit.thebaudeau.dev@gmail.com>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for tlv320aic3104
Date: Wed, 4 Feb 2015 14:30:04 +0100
Message-ID: <CA+sos7_6iG=h3BzH5vp+TNehFY--wy8bbVqc8rc3-aqtmbjAdA@mail.gmail.com>
References: <54CF2CDA.3060607@ti.com> <1422888485-13626-1-git-send-email-jsarha@ti.com>
 <CA+sos78ar+MX2CvrjtzYN9MvtO9g=upMuOScXuXa2=zQ81qQwQ@mail.gmail.com>
 <54D1D80F.1090304@ti.com> <CA+sos797a7CT2KqCwrW5CaL1vF0GVCHQGxp3gDAB7PTFi4jZjQ@mail.gmail.com>
 <54D1EE24.3000309@ti.com> <CA+sos7_kRHru5_AZcVyhzYHtA3JkdcRVfq=bT3X=bMWjFvrd=Q@mail.gmail.com>
 <54D2121B.3030200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:57854 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530AbbBDNaZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2015 08:30:25 -0500
In-Reply-To: <54D2121B.3030200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, Alsa-devel <alsa-devel@alsa-project.org>, devicetree@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, wlear@appliedlogix.com

On Wed, Feb 4, 2015 at 1:35 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> =
wrote:
> On 02/04/2015 01:11 PM, Beno=C3=AEt Th=C3=A9baudeau wrote:
>> On Wed, Feb 4, 2015 at 11:02 AM, Peter Ujfalusi <peter.ujfalusi@ti.c=
om> wrote:
>>> On 02/04/2015 11:33 AM, Beno=C3=AEt Th=C3=A9baudeau wrote:
>>>> What I meant was to do the following instead:
>>>>
>>>> /*
>>>>  * ADC PGA mix input volumes. From -12 to 0 dB in 1.5 dB steps. Di=
sconnected
>>>>  * below -12 dB
>>>>  */
>>>> static const DECLARE_TLV_DB_SCALE(mix_tlv, -1350, 150, 1);
>>>>
>>>> /* Left PGA Mixer for tlv320aic3104 */
>>>> static const struct snd_kcontrol_new aic3104_left_pga_mixer_contro=
ls[] =3D {
>>>>     SOC_DAPM_SINGLE_MUT_TLV("Line1L Volume",
>>>>                 LINE1L_2_LADC_CTRL, 3, 7, 15, 1, mix_tlv),
>>>
>>> You mean SOC_DAPM_SINGLE_TLV() ?
>>
>> No. It would not fit our needs here.
>>
>>> There is no _MUT_ variant AFAIK.
>>
>> Indeed, but support could be added, for it, something like (might ne=
ed
>> updating and some other changes in DAPM):
>>
>> #define SOC_DAPM_SINGLE_MUT_TLV(xname, reg, shift, min, max, invert,
>> tlv_array) \
>> {    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D xname, \
>>     .info =3D snd_soc_info_volsw_mut, \
>>     .access =3D SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCE=
SS_READWRITE,\
>>     .tlv.p =3D (tlv_array), \
>>     .get =3D snd_soc_dapm_get_volsw_mut, .put =3D snd_soc_dapm_put_v=
olsw_mut, \
>>     .private_value =3D SOC_SINGLE_MUT_VALUE(reg, shift, min, max, in=
vert) }
>
> We would need more than this for aic3x driver. Something which handle=
s:
> valid field values: 0 - 8 (inverted or not)
> Plus when mute is asked we should write 0xf (mute value)
> 0b1001 - 0b1110 is reserved value on all codecs.
>
> #define SOC_DAPM_SINGLE_MUT_TLV(xname, reg, shift, min, max, mute_val=
,
>                                 invert, tlv_array)

mute_val could be deduced from max thanks to invert. This is what I
did with SOC_DAPM_SINGLE_MUT_TLV(). See the value 15 passed to it.

>>> According to the datasheets of aic3106, aic3104:
>>> 0b0000 - 0b1000 is valid (0 - -12 dB)
>>> 0b1001 - 0b1110 is reserved, do not write these sequences to the re=
gister
>>> 0b1111 is disconnected.
>>>
>>> And for fun the aic3007's reg20 for example:
>>> 0b0000 - 0dB
>>> 0b0001 - 0b0011 - reserved
>>> 0b0100 - -6dB
>>> 0b0101 - 0b0111 - reserved
>>> 0b1000 - -12dB
>>> 0b1001 - 0b1110 - reserved
>>> 0b1111 - disconnected
>>>
>>> Note that the driver never had control for these gains and the aic3=
104 support
>>> is following this behavior, but if we do it for aic3104 we should d=
o it for
>>> all other support codecs as well as a followup patch or series. IMH=
O.
>>
>> I had not checked the other CODECs. So for all these CODECs, togglin=
g
>> either as 0b0000/0b0001 or as 0b1110/0b1111 (like the driver current=
ly
>> does) is wrong.
>
> The driver toggles between 0b0000 and 0b1111 currently, which is corr=
ect:
> # amixer sset 'Left PGA Mixer Line1L' off
> snd_soc_dapm_put_volsw_aic3x 1: reg: 0x13, val: 0x00
> snd_soc_dapm_put_volsw_aic3x 2: val: 0x78, mask: 0x78
>
> # amixer sset 'Left PGA Mixer Line1L' on
> snd_soc_dapm_put_volsw_aic3x 1: reg: 0x13, val: 0x01
> snd_soc_dapm_put_volsw_aic3x 2: val: 0x00, mask: 0x78

So the current behavior is indeed correct, but incomplete.

>> I agree that they should be fixed too. But for them,
>> it's even more complicated because of the multiple reserved value
>> ranges. Or maybe we could just ignore these reserved ranges and hand=
le
>> the mute value, but that would mean relying on the user not to use
>> reserved values. So maybe use TLV_DB_RANGE_HEAD() and
>> TLV_DB_SCALE_ITEM() to define mix_tlv, then use
>> SOC_(DAPM_)SINGLE_TLV().
>
> I myself also wondered time to time why the driver was written the wa=
y it has
> been regarding to these gain controls.

Yes. I think that TLV_DB_RANGE_HEAD() and TLV_DB_SCALE_ITEM() would be
a good solution to get rid of SOC_DAPM_SINGLE_AIC3X() /
snd_soc_dapm_put_volsw_aic3x() while fully implementing these controls
as volumes. That would be worth checking.

Best regards,
Beno=C3=AEt
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
