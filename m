From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: RE: [PATCHv4 2/2] ASoC: OMAP-McBSP: ASoC interface for McBSP
 sidetone
Date: Fri, 19 Feb 2010 14:04:38 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1002191355450.3039@tumpelo.nmp.nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com> <1266518549-23809-2-git-send-email-ilkka.koskinen@nokia.com>,<1266518549-23809-3-git-send-email-ilkka.koskinen@nokia.com>
 <1FFEF31EBAA4F64B80D33027D42977602143ED8FED@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1406685011-1266581079=:3039"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37467 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab0BSMDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 07:03:23 -0500
In-Reply-To: <1FFEF31EBAA4F64B80D33027D42977602143ED8FED@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1406685011-1266581079=:3039
Content-Type: TEXT/PLAIN; charset=Windows-1252; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 19 Feb 2010, Nurkkala Eero.An (EXT-Offcode/Oulu) wrote:

>
>> +
>> +static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] = {
>> +       SOC_SINGLE_EXT("McBSP2 Sidetone Switch", 1, 0, 1, 0,
>> +                       omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
>> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volume",
>> +                                     -32768, 32767,
>> +                                     omap_mcbsp2_get_st_ch0_volume,
>> +                                     omap_mcbsp2_set_st_ch0_volume),
>> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volume",
>> +                                     -32768, 32767,
>> +                                     omap_mcbsp2_get_st_ch1_volume,
>> +                                     omap_mcbsp2_set_st_ch1_volume),
>> +};
>> +
>> +static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] = {
>> +       SOC_SINGLE_EXT("McBSP3 Sidetone Switch", 2, 0, 1, 0,
>> +                       omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
>> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volume",
>> +                                     -32768, 32767,
>> +                                     omap_mcbsp3_get_st_ch0_volume,
>> +                                     omap_mcbsp3_set_st_ch0_volume),
>> +       OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volume",
>> +                                     -32768, 32767,
>> +                                     omap_mcbsp3_get_st_ch1_volume,
>> +                                     omap_mcbsp3_set_st_ch1_volume),
>> +};
>> +
>
> Just a short note, "Gain values are in the interval (-2..2) in Q1.14 
> format, negative values are expressed in 2's complement."
>
> So, from:
> http://en.wikipedia.org/wiki/Q_(number_format)
>
> "
> The notation used is Qm.n, where:
>
>    * Q designates that the number is in Q format notation — the Texas 
> Instruments representation for signed fixed-point numbers.
>    * m (optional; default=0) is the number of bits used to designate the 
> two's complement integer portion of the number, exclusive of the sign 
> bit.
>    * n is the number of bits used to designate the two's complement 
> fractional portion of the number, i.e. the number of bits to the right 
> of the binary point. "
>
> ..so if you do tests, and find out the gains behave "irrationally" 
> occasionally, you can't possibly claim it isn't working as expected ;)

I'm a bit confused. What do you mean by that?

AFAICS, Q1.14 defines values [-16384.0, +16383.5], which are mapped in the 
driver to integers [-32768, 32767], right? Moreover, those Q1.14 values in 
registers are mapped to [-2, 2] in HW. So is there a problem somewhere?

Cheers, Ilkka
--8323328-1406685011-1266581079=:3039--
