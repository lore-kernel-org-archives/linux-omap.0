From: "Yuri Jaeger Monti" <yurijm@gmail.com>
Subject: Re: OMAP5912 AIC23
Date: Thu, 28 Aug 2008 14:02:01 -0300
Message-ID: <65e025470808281002r5c4b7a52la9d57791f24ce247@mail.gmail.com>
References: <65e025470808251004w109cece7t9caeaa81b422554b@mail.gmail.com>
	 <65e025470808251011j42564e2g7a445558f9e82559@mail.gmail.com>
	 <48B362BD.10009@css-design.us>
	 <65e025470808260722m59ff5207n43f7c4feac8a5e30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:30212 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYH1RCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 13:02:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so412783wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 10:02:01 -0700 (PDT)
In-Reply-To: <65e025470808260722m59ff5207n43f7c4feac8a5e30@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Poulsen <spoulsen@css-design.us>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Steve,

Would you mind to share with us the driver for the AIC23 you made? or
the kernel configuration you used?
Unfortunately I'm still nowhere to get the problem solved. I'm stuck
in this underrun problem.

Thanks


---
Yuri Jaeger Monti

On Tue, Aug 26, 2008 at 11:22 AM, Yuri Jaeger Monti <yurijm@gmail.com> wrote:
> Thanks for your reply Steve!
>
> I'm using the AIC23 driver bundled in the OMAP kernel, I tried playing
> through OSS directly to /dev/dsp (which gives me the best results,
> choppy sound though) and through ALSA which is similar. Doing cat
> test.wav > /dev/dsp or /dev/audio just gives me noise output. And I
> still can't record anything.
>
> I've tried every player possible. Here is the output of aplay:
>
> root@DEA /opt/audios/wav # aplay -lL
> default:CARD=AIC23
>    OSK AIC23, omap alsa pcm
>    Default Audio Device
> null
>    Discard all samples (playback) or generate zero samples (capture)
> **** List of PLAYBACK Hardware Devices ****
> card 0: AIC23 [OSK AIC23], device 0: OMAP PCM [omap alsa pcm]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
>
> root@DEA /opt/audios # aplay audio_44100_16PCM.au -vv
> Playing Sparc Audio 'audio_44100_16PCM.au' : Signed 16 bit Big Endian,
> Rate 44100 Hz, Stereo
> Plug PCM: Linear conversion PCM (S16_LE)
> Its setup is:
>  stream       : PLAYBACK
>  access       : RW_INTERLEAVED
>  format       : S16_BE
>  subformat    : STD
>  channels     : 2
>  rate         : 44100
>  exact rate   : 44100 (44100/1)
>  msbits       : 16
>  buffer_size  : 32768
>  period_size  : 2048
>  period_time  : 46439
>  tick_time    : 0
>  tstamp_mode  : NONE
>  period_step  : 1
>  sleep_min    : 0
>  avail_min    : 2048
>  xfer_align   : 2048
>  start_threshold  : 32768
>  stop_threshold   : 32768
>  silence_threshold: 0
>  silence_size : 0
>  boundary     : 1073741824
> Slave: Hardware PCM card 0 'OSK AIC23' device 0 subdevice 0
> Its setup is:
>  stream       : PLAYBACK
>  access       : MMAP_INTERLEAVED
>  format       : S16_LE
>  subformat    : STD
>  channels     : 2
>  rate         : 44100
>  exact rate   : 44100 (44100/1)
>  msbits       : 16
>  buffer_size  : 32768
>  period_size  : 2048
>  period_time  : 46439
>  tick_time    : 0
>  tstamp_mode  : NONE
>  period_step  : 1
>  sleep_min    : 0
>  avail_min    : 2048
>  xfer_align   : 2048
>  start_threshold  : 32768
>  stop_threshold   : 32768
>  silence_threshold: 0
>  silence_size : 0
>  boundary     : 1073741824
> ###############                                   +| 99%underrun!!!
> (at least 0.366 ms long)
> Status:
>  state       : XRUN
>  trigger_time: 1217931313.815063477
>  tstamp      : 1217931313.815307617
>  delay       : 0
>  avail       : 32768
>  avail_max   : 32768
> ##############                                    +| 99%underrun!!!
> (at least 0.152 ms long)
> Status:
>  state       : XRUN
>  trigger_time: 1217931314.353729248
>  tstamp      : 1217931314.353851319
>  delay       : 0
>  avail       : 32768
>  avail_max   : 32768
> ##################################################+| 99%underrun!!!
> (at least 0.153 ms long)
> Status:
>  state       : XRUN
>  trigger_time: 1217931314.892425537
>  tstamp      : 1217931314.892547608
>  delay       : 0
>  avail       : 32768
>  avail_max   : 32768
> ##################################################+| 99%underrun!!!
> (at least 0.092 ms long)
> Status:
>  state       : XRUN
>  trigger_time: 1217931315.467193604
>  tstamp      : 1217931315.467254639
>  delay       : 0
>  avail       : 32768
>  avail_max   : 32768
> ###############################                   +| 99%underrun!!!
> (at least 0.092 ms long)
> Status:
>  state       : XRUN
>  trigger_time: 1217931316.107543946
>  tstamp      : 1217931316.107635498
>  delay       : 0
>  avail       : 34816
>  avail_max   : 34816
> ##################################################+| 99%underrun!!!
> (at least 0.091 ms long)
> Status:
>  state       : XRUN
>  trigger_time: 1217931316.747711182
>  tstamp      : 1217931316.747802735
>  delay       : 0
>  avail       : 34816
>  avail_max   : 34816
> ##################################################+| 99%underrun!!!
> (at least 0.122 ms long)
> Status:
>  state       : XRUN
>  trigger_time: 1217931317.326873780
>  tstamp      : 1217931317.326965332
>  delay       : 0
>  avail       : 32768
>  avail_max   : 32768
> ##DMA timeout with device 8#######################+| 99%
> {sound_dma_irq_handler}-ERROR: DCSR_ERROR!
> ##################################################+| 99%
>
> root@DEA /opt/audios/wav # aplay test.wav
> Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 24000 Hz, Mono
> underrun!!! (at least 0.396 ms long)
>
>
> When playing a long audio file, there is a lot of underruns (XRUN).
> I've tried playing ogg files with ogg123, mp3 files with madplay and
> also tested with a lot of different sample rates and bitrates, always
> choppy sound (good quality but the audio looks like it's splitted into
> chunks, and sometimes it loops in the end).
>
> Do you have any hint?
>
> Thanks
>
>
> ---
> Yuri Jaeger Monti
>
>
>
> On Mon, Aug 25, 2008 at 10:56 PM, Steve Poulsen <spoulsen@css-design.us> wrote:
>> Yuri,
>>
>> We have had good luck with ARM audio under this setup.  We did write our own
>> AIC23 drivers which we used directly from our application.  We used a device
>> entry (/dev/aic23) that hooked in our driver.  We were able to open those in
>> any application and play/record or both.  The only possible problem was if
>> we tried to do things like "cat file.pcm > /dev/aic23".  Although this would
>> work, some cases would not work due to those applications buffering schemes.
>>  For example, this was bad:  "cat /dev/aic23 > /dev/aic23".   It would work,
>> but would be choppy.
>> How are you playing audio?
>>
>> Steve
>>
>> Yuri Jaeger Monti wrote:
>>>
>>> Hi fellows,
>>>
>>> I tried everything I could to solve the buffer underrun error's while
>>> playing some audio in the OSK5912 with the AIC23, and I don't know
>>> what should I do anymore.
>>> I'm trying to simply output and audio file via the ARM, I think this
>>> should be ok but the audio is always choppy.
>>> Am I doing something wrong? Or perhaps should I use only the DSP
>>> processor to play the audio? (didn't tried this yet because I need the
>>> DSP to do other tasks).
>>>
>>> Cheers
>>>
>>> ---
>>> Yuri Jaeger Monti
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
>
