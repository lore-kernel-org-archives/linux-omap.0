From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH] OMAPDSS: Provide interface for audio support in DSS
Date: Fri, 20 Apr 2012 12:20:59 -0500
Message-ID: <4F919AFB.8080105@ti.com>
References: <1332971516-4325-1-git-send-email-ricardo.neri@ti.com>  <1332971516-4325-2-git-send-email-ricardo.neri@ti.com> <1334923436.1564.8.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37197 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168Ab2DTRU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Apr 2012 13:20:58 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q3KHKvn5005303
	for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 12:20:57 -0500
Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q3KHKv6N001685
	for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 12:20:57 -0500
In-Reply-To: <1334923436.1564.8.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: s-chereau@ti.com, x0055901@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

Thanks for your comments!

On 04/20/2012 07:03 AM, Tomi Valkeinen wrote:
> On Wed, 2012-03-28 at 15:51 -0600, Ricardo Neri wrote:
>> There exist several display technologies and standards that support audio as
>> well. Hence, it is relevant to update the DSS device driver to provide an audio
>> interface that may be used by an audio or any other driver interested in the
>> functionality.
>>
>> The DSS audio functions are intended to be used as follows:
>>
>> The audio_enable function is intended to prepare the relevant IP for playback
>> (e.g., enabling an audio FIFO, taking out of reset some IP, etc).
>>
>> While the display may support audio, it is possible that for certain
>> configurations audio is not supported (e.g., an HDMI display using a VESA video
>> timing). The audio_detect function is intended to query whether the current
>> configuration of the display supports audio.
>>
>> The audio_config function is intended to configure all the relevant audio
>> parameters of the display. In order to make the function independent of any DSS
>> device driver or IP, it takes an IEC-60958 channel status word struct as well
>> as a CEA-861 audio infoframe struct. At the moment, this should be enough to
>> support HDMI and DisplayPort, as both are based on CEA-861 and IEC-60958.
>>
>> The audio_start function is intended to effectively start/stop audio playback
>> after the configuration has taken place.
>>
>> Please note that asound.h is #included only to pass the relevant data
>> structures to the DSS device driver. The DSS device driver should
>> not link to any ALSA function as DSS and ALSA are built in separate modules.
>>
>> Signed-off-by: Ricardo Neri<ricardo.neri@ti.com>
>> ---
>>   Documentation/arm/OMAP/DSS |   28 ++++++++++++++++++++++++++++
>>   include/video/omapdss.h    |   12 ++++++++++++
>>   2 files changed, 40 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
>> index 888ae7b..b303a5c 100644
>> --- a/Documentation/arm/OMAP/DSS
>> +++ b/Documentation/arm/OMAP/DSS
>> @@ -47,6 +47,34 @@ flexible way to enable non-common multi-display configuration. In addition to
>>   modelling the hardware overlays, omapdss supports virtual overlays and overlay
>>   managers. These can be used when updating a display with CPU or system DMA.
>>
>> +omapdss driver support for audio
>> +--------------------------------
>> +There exist several display technologies and standards that support audio as
>> +well. Hence, it is relevant to update the DSS device driver to provide an audio
>> +interface that may be used by an audio or any other driver interested in the
>> +functionality.
>> +
>> +The audio_enable function is intended to prepare the relevant IP for playback
>> +(e.g., enabling an audio FIFO, taking out of reset some IP, etc).
>> +
>> +While the display may support audio, it is possible that for certain
>> +configurations audio is not supported (e.g., an HDMI display using a VESA video
>> +timing). The audio_detect function is intended to query whether the current
>> +configuration of the display supports audio.
>> +
>> +The audio_config function is intended to configure all the relevant audio
>> +parameters of the display. In order to make the function independent of DSS
>> +any device driver, it takes a IEC-60958 channel status word as well
>> +as a CEA-861 audio infoframe. At the moment, this should be enough to support
>> +HDMI and DisplayPort, as both are based on CEA-861 and IEC-60958.
>> +
>> +The audio_start function is intended to effectively start/stop audio playback
>> +after the configuration has taken place.
>> +
>> +Please note that asound.h is #included only to pass the relevant data
>> +structures to the DSS device driver. The DSS device driver should
>> +not link to any ALSA function as DSS and ALSA are built in separate modules.
>> +
>>   Panel and controller drivers
>>   ----------------------------
>>
>> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
>> index 483f67c..e35ae96 100644
>> --- a/include/video/omapdss.h
>> +++ b/include/video/omapdss.h
>> @@ -21,6 +21,7 @@
>>   #include<linux/list.h>
>>   #include<linux/kobject.h>
>>   #include<linux/device.h>
>> +#include<sound/asound.h>
>
> You don't need to include asound.h, you can just:
>
> struct snd_aes_iec958;
> struct snd_cea_861_aud_if;

Thanks! I missed this.
>
>>   #define DISPC_IRQ_FRAMEDONE		(1<<  0)
>>   #define DISPC_IRQ_VSYNC			(1<<  1)
>> @@ -642,6 +643,17 @@ struct omap_dss_driver {
>>
>>   	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
>>   	bool (*detect)(struct omap_dss_device *dssdev);
>> +
>> +	/*
>> +	 * For display drivers that support audio. This encompasses
>> +	 * HDMI and DisplayPort at the moment.
>> +	 */
>> +	int (*audio_enable)(struct omap_dss_device *dssdev, bool enable);
>> +	int (*audio_start)(struct omap_dss_device *dssdev, bool start);
>> +	bool (*audio_detect)(struct omap_dss_device *dssdev);
>> +	int (*audio_config)(struct omap_dss_device *dssdev,
>> +		struct snd_aes_iec958 *iec, struct snd_cea_861_aud_if *aud_if);
>
> I can't say anything about the parameters for audio_config, so I trust
> they are ok. But some comments about the functions:

Fwiw, I have been testing this approach on OMAP4 and OMAP5 during the 
last week and it seems to work fine. :) Perhaps in the future I can 
extend it to cover speaker mapping for the multichannel use-case.

>
> I don't like foo_enable(bool enable) style functions. While it does
> reduce the amount of code a bit, I think it's much less readable than
> separate foo_enable() and foo_disable() functions.

I will split the functions audio_enable into audio_enable and 
audio_disable and audio_start into audio_start and audio_stop.
>
> audio_detect sounds a bit misleading to me... You're not detecting
> anything, but asking if audio is supported. So... "audio_supported()" or
> something?

I was looking for a name that denotes that audio support is dynamic: 
while a display may be capable of playing audio, it may be supported 
only for some configurations (e.g., VESA vs CEA video timings). 
Something like audio_supported_now() would be fully descriptive but I 
guess audio_supported() looks nicer.
>
> Is there need for the audio_config function, or could the audio configs
> be given with audio_start call?

I propose to have separate functions for configuration and audio start 
to provide full flexibility. The users of the DSS audio interface should 
be able to decide when to configure and when to start the audio; 
otherwise, synchronization issues may arise. For instance, on OMAP HDMI 
IPs, the audio configuration must be done while the audio wrapper is 
disabled; but the DMA transfers must start after enabling the audio 
wrapper (or FIFO underflow and audio channel shifting may occur). As the 
DMA tranfers are started by a different driver (e.g., ASoC), DSS does 
control it and, instead, should provide functionality to config and 
start audio when required.

Furthermore, IMHO, having a config function to effectively configure and 
a start function to effectively start audio contributes to improve 
readability.

BR,
Ricardo

>
>   Tomi

