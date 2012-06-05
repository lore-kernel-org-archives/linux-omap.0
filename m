From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Mon, 4 Jun 2012 20:24:06 -0500
Message-ID: <4FCD5FB6.4040806@ti.com>
References: <4FC5C8E5.7060108@gmail.com> <4FC6AEAF.5020501@ti.com> <4FC6F330.8070408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab2FEBYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 21:24:41 -0400
In-Reply-To: <4FC6F330.8070408@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Xiao Jiang <jgq516@gmail.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Xiao, Tomi, Jarkko,

On 05/30/2012 11:27 PM, Xiao Jiang wrote:
> Ricardo Neri wrote:
>> +Tomi
>>
>> Hi Xiao,
>>
>> On 05/30/2012 02:14 AM, Xiao Jiang wrote:
>>> Hello,
>>>
>>> After enable SND_OMAP_SOC_OMAP_HDMI with omap2plus_defconfig, I got some
>>> err infos with latest
>>> Linus's tree, does somebody also has the same issue?
>>>
>>> sound/soc/omap/omap-hdmi.c:45:24: error: field 'dss_audio' has
>>> incomplete type
>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_startup':
>>> sound/soc/omap/omap-hdmi.c:67:27: error: 'struct omap_dss_driver' has no
>>> member named 'audio_supported'
>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_prepare':
>>> sound/soc/omap/omap-hdmi.c:79:29: error: 'struct omap_dss_driver' has no
>>> member named 'audio_enable'
>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_hw_params':
>>> sound/soc/omap/omap-hdmi.c:208:28: error: 'struct omap_dss_driver' has
>>> no member named 'audio_config'
>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_trigger':
>>> sound/soc/omap/omap-hdmi.c:224:29: error: 'struct omap_dss_driver' has
>>> no member named 'audio_start'
>>> sound/soc/omap/omap-hdmi.c:229:23: error: 'struct omap_dss_driver' has
>>> no member named 'audio_stop'
>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_shutdown':
>>> sound/soc/omap/omap-hdmi.c:242:22: error: 'struct omap_dss_driver' has
>>> no member named 'audio_disable'
>>> sound/soc/omap/omap-hdmi.c: In function 'omap_hdmi_dai_prepare':
>>> sound/soc/omap/omap-hdmi.c:80:1: warning: control reaches end of
>>> non-void function
>>
>> Build breaks because there some patches [1] that are still missing in
>> Linus' tree. ASoC HDMI audio driver for OMAP[2] now uses the new DSS
>> audio functionality in [1], but ASoC patches were merged first. DSS
>> patches have been accepted and they are part of Tomi's pull request
>> for DSS for K3.5. Hopefully this will be fixed when v3.5-rc1 is out.
>>
> Ricardo, thanks for your detail infos :).

Just wanted to confirm to you that this build break is not present in 
3.5-rc1 as both omapdss and asoc dependencies are present.

Ricardo
>
> Regards,
> Xiao
>> BR,
>>
>> Ricardo
>>
>> [1].http://www.spinics.net/lists/linux-omap/msg69466.html
>> [2].http://www.spinics.net/lists/linux-omap/msg70561.html
>>>
>>> Regards,
>>> Xiao
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>

