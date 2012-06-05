From: Xiao Jiang <jgq516@gmail.com>
Subject: Re: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Tue, 05 Jun 2012 12:15:03 +0800
Message-ID: <4FCD87C7.3070504@gmail.com>
References: <4FC5C8E5.7060108@gmail.com> <4FC6AEAF.5020501@ti.com> <4FC6F330.8070408@gmail.com> <4FCD5FB6.4040806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39014 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757702Ab2FEDWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 23:22:05 -0400
Received: by vcbf11 with SMTP id f11so2896190vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Jun 2012 20:22:04 -0700 (PDT)
In-Reply-To: <4FCD5FB6.4040806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ricardo Neri wrote:
> Hi Xiao, Tomi, Jarkko,
>
> On 05/30/2012 11:27 PM, Xiao Jiang wrote:
>> Ricardo Neri wrote:
>>> +Tomi
>>>
>>> Hi Xiao,
>>>
>>> On 05/30/2012 02:14 AM, Xiao Jiang wrote:
>>>> Hello,
>>>>
>>>> After enable SND_OMAP_SOC_OMAP_HDMI with omap2plus_defconfig, I go=
t=20
>>>> some
>>>> err infos with latest
>>>> Linus's tree, does somebody also has the same issue?
>>>>
>>>> sound/soc/omap/omap-hdmi.c:45:24: error: field 'dss_audio' has
>>>> incomplete type
>>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_startup':
>>>> sound/soc/omap/omap-hdmi.c:67:27: error: 'struct omap_dss_driver'=20
>>>> has no
>>>> member named 'audio_supported'
>>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_prepare':
>>>> sound/soc/omap/omap-hdmi.c:79:29: error: 'struct omap_dss_driver'=20
>>>> has no
>>>> member named 'audio_enable'
>>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_hw_params':
>>>> sound/soc/omap/omap-hdmi.c:208:28: error: 'struct omap_dss_driver'=
 has
>>>> no member named 'audio_config'
>>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_trigger':
>>>> sound/soc/omap/omap-hdmi.c:224:29: error: 'struct omap_dss_driver'=
 has
>>>> no member named 'audio_start'
>>>> sound/soc/omap/omap-hdmi.c:229:23: error: 'struct omap_dss_driver'=
 has
>>>> no member named 'audio_stop'
>>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_shutdown':
>>>> sound/soc/omap/omap-hdmi.c:242:22: error: 'struct omap_dss_driver'=
 has
>>>> no member named 'audio_disable'
>>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_prepare':
>>>> sound/soc/omap/omap-hdmi.c:80:1: warning: control reaches end of
>>>> non-void function
>>>
>>> Build breaks because there some patches [1] that are still missing =
in
>>> Linus' tree. ASoC HDMI audio driver for OMAP[2] now uses the new DS=
S
>>> audio functionality in [1], but ASoC patches were merged first. DSS
>>> patches have been accepted and they are part of Tomi's pull request
>>> for DSS for K3.5. Hopefully this will be fixed when v3.5-rc1 is out=
=2E
>>>
>> Ricardo, thanks for your detail infos :).
>
> Just wanted to confirm to you that this build break is not present in=
=20
> 3.5-rc1 as both omapdss and asoc dependencies are present.
>
Hi Ricardo,

Good to know, but I can't get any voice with aplay, although penguins=20
are appeared on
the hdmi tv. Pls see below infos.

root@panda:/root> aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: OMAPHDMI [OMAPHDMI], device 0: HDMI omap-hdmi-hifi-0 []
Subdevices: 1/1
Subdevice #0: subdevice #0

root@panda:/root> alsamixer
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92 AlsaMixer v1.0.2=
1 =E2=96=92
=E2=96=92 Card: OMAPHDMI F1: Help =E2=96=92
=E2=96=92 Chip: F2: System information =E2=96=92
=E2=96=92 View: F3: Playback F4: Capture F5: All F6: Select sound card =
=E2=96=92
=E2=96=92 Item: Esc: Exit =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 This sound device does not have any controls. =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92 =E2=96=92
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=
=E2=96=92

root@panda:/root> aplay audio48k16S.wav
Playing WAVE 'audio48k16S.wav' : Signed 16 bit Little Endian, Rate 4800=
0=20
Hz, Stereo

But hdmi audio of imx6q board is ok with the same hdmi tv. Did I miss=20
something else? thanks.

Regards,
Xiao

> Ricardo
>>
>> Regards,
>> Xiao
>>> BR,
>>>
>>> Ricardo
>>>
>>> [1].http://www.spinics.net/lists/linux-omap/msg69466.html
>>> [2].http://www.spinics.net/lists/linux-omap/msg70561.html
>>>>
>>>> Regards,
>>>> Xiao
>>>>
>>>> --=20
>>>> To unsubscribe from this list: send the line "unsubscribe=20
>>>> linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
