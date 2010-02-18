From: Ilkka Koskinen <ikoskine@nokia.com>
Subject: Re: [alsa-devel] [PATCHv3 2/2] ASoC: OMAP-McBSP: ASoC interface for
 McBSP sidetone
Date: Thu, 18 Feb 2010 19:16:06 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1002181853470.28382@tumpelo.nmp.nokia.com>
References: <1266496635-31347-1-git-send-email-ilkka.koskinen@nokia.com> <1266496635-31347-2-git-send-email-ilkka.koskinen@nokia.com> <1266496635-31347-3-git-send-email-ilkka.koskinen@nokia.com> <201002181611.38241.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-747029430-1266513366=:28382"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46351 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab0BRROp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:14:45 -0500
In-Reply-To: <201002181611.38241.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-747029430-1266513366=:28382
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT



On Thu, 18 Feb 2010, Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On Thursday 18 February 2010 14:37:15 Koskinen Ilkka (Nokia-D/Tampere) wrote:
>
> ...
>
>> +static int omap_mcbsp_set_st_channel_vol(struct snd_kcontrol *kcontrol,
>> +                                     struct snd_ctl_elem_value *ucontrol,
>> +                                     int id, int channel)
>> +{
>> +     struct soc_mixer_control *mc =
>> +             (struct soc_mixer_control *)kcontrol->private_value;
>> +     int max = mc->max;
>> +     int min = mc->min;
>> +     int val = ucontrol->value.integer.value[0];
>> +
>> +     if (val < min || val > max)
>> +             return -EINVAL;
>> +
>> +     return omap_st_set_chgain((id)-1, val, 0, channel);
>
> So how do you actually set the ch1 gain to other than 0?
>
> int omap_st_set_chgain(unsigned int id, s16 ch0gain, s16 ch1gain, int channels);
>
> So in any cases you are calling with ch1gain = 0, and depending on the 
> selected channel you put that to ch0gain. All in all, with this code you 
> are only able to update ch0, and never the ch1.

Damn, it seems that I have messed up my trees :( That's obviously from the 
time I was just experimenting it, and I fixed it some time ago already.

> Should than the omap_st_set_chgain have only one parameter for the gain, and the
> channel parameter tells the code to which channel to put the gain?
>
>> +}
>> +
>> +static int omap_mcbsp_get_st_channel_vol(struct snd_kcontrol *kcontrol,
>> +                                     struct snd_ctl_elem_value *ucontrol,
>> +                                     int id, int channel)
>> +{
>> +     s16 ch0gain, ch1gain;
>> +
>> +     if (omap_st_get_chgain((id)-1, &ch0gain, &ch1gain))
>> +             return -EAGAIN;
>
> Than probably the omap_st_get_chgain should only retrieve the gain for one
> channel also?

Yes, indeed.


Sorry for the confusion. I'll send the fixed patches soon.

Cheers, Ilkka

>> +
>> +     if (channel == OMAP_MCBSP_ST_CHANNEL_0)
>> +             ucontrol->value.integer.value[0] = ch0gain;
>> +     else if (channel == OMAP_MCBSP_ST_CHANNEL_1)
>> +             ucontrol->value.integer.value[0] = ch1gain;
>> +
>> +     return 0;
>> +}
>> +
>
> --
> Péter
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
--8323328-747029430-1266513366=:28382--
