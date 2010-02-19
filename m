From: <ext-Eero.Nurkkala@nokia.com>
Subject: RE: [PATCHv4 2/2] ASoC: OMAP-McBSP: ASoC interface for McBSP
 sidetone
Date: Fri, 19 Feb 2010 08:30:30 +0100
Message-ID: <1FFEF31EBAA4F64B80D33027D42977602143ED8FED@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
 <1266518549-23809-2-git-send-email-ilkka.koskinen@nokia.com>,<1266518549-23809-3-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49358 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab0BSHax convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 02:30:53 -0500
In-Reply-To: <1266518549-23809-3-git-send-email-ilkka.koskinen@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ilkka.koskinen@nokia.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, broonie@opensource.wolfsonmicro.com, tony
Cc: eduardo.valentin@nokia.com


> +
> +static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] =3D {
> +       SOC_SINGLE_EXT("McBSP2 Sidetone Switch", 1, 0, 1, 0,
> +                       omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mod=
e),
> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volu=
me",
> +                                     -32768, 32767,
> +                                     omap_mcbsp2_get_st_ch0_volume,
> +                                     omap_mcbsp2_set_st_ch0_volume),
> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volu=
me",
> +                                     -32768, 32767,
> +                                     omap_mcbsp2_get_st_ch1_volume,
> +                                     omap_mcbsp2_set_st_ch1_volume),
> +};
> +
> +static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] =3D {
> +       SOC_SINGLE_EXT("McBSP3 Sidetone Switch", 2, 0, 1, 0,
> +                       omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mod=
e),
> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volu=
me",
> +                                     -32768, 32767,
> +                                     omap_mcbsp3_get_st_ch0_volume,
> +                                     omap_mcbsp3_set_st_ch0_volume),
> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volu=
me",
> +                                     -32768, 32767,
> +                                     omap_mcbsp3_get_st_ch1_volume,
> +                                     omap_mcbsp3_set_st_ch1_volume),
> +};
> +

Just a short note,
"Gain values are in the interval (-2..2) in Q1.14 format, negative valu=
es are expressed in
2's complement."

So, from:
http://en.wikipedia.org/wiki/Q_(number_format)

"
The notation used is Qm.n, where:

    * Q designates that the number is in Q format notation =97 the Texa=
s Instruments representation for signed fixed-point numbers.
    * m (optional; default=3D0) is the number of bits used to designate=
 the two's complement integer portion of the number, exclusive of the s=
ign bit.
    * n is the number of bits used to designate the two's complement fr=
actional portion of the number, i.e. the number of bits to the right of=
 the binary point.
"

=2E.so if you do tests, and find out the gains behave "irrationally" oc=
casionally, you can't possibly claim it isn't working as expected ;)

- Eero--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
