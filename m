From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Thu, 19 May 2011 16:58:30 -0700
Message-ID: <4DD5AEA6.6020907@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105171342.35056.peter.ujfalusi@ti.com> <4DD464BB.3050708@gmail.com> <201105191428.10115.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60413 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1ESX6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 19:58:34 -0400
Received: by pvg12 with SMTP id 12so1418274pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 16:58:33 -0700 (PDT)
In-Reply-To: <201105191428.10115.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, Peter Hsiang <cdefgab1288@gmail.com>

On 05/19/11 04:28, Peter Ujfalusi wrote:
...
> 
>> My codec cannot be set to use only 16 bits per phase. Is there a way to
>> setup the omap so that data is sent to both channels? As you can see
>> above the xphase bit is one saying dual channels. Is this a dma setup
>> problem?
> 
> I can not find datasheet for the max98095...
> So you can not configure the codec to use 2x16 number of bit clocks. when it 
> is configured to receive/send 16bit stereo samples?
Correct, I can set bit clock to 64*lrclk, 48*lrclk, 128*lrclk, 17*lrclk,
and 18*lrclk. The audio folks here think that it is normal to send more
than required bit clocks, data is sent first so just ignore the rest.

It would appear that the mcbsp doesn't really use the lrclk (I think
called FSX), it just uses a positive transition to start the bit
shifting for all the requested bits. The falling edge does not start the
right channel, the shifter keeps going until all requested l/r counts
have been sent.

Or maybe something in the mcbsp has not been set up correctly?

> Is this the case (that the codec all the time have 32 clock cycles per 
> channel)? 
> 
> If this is the case, than it is kind of tricky to get around this, but you can 
> try the following (warning: hack):
> 
> In the codec driver:
> create/add a startup callback function for the dais (snd_soc_dai_ops):
> 
> static int max98095_startup(struct snd_pcm_substream *substream,
> 			   struct snd_soc_dai *dai)
> {
> 	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 16);
> 
> 	return 0;
> }
> 
> Modify the MAX98095_FORMATS to only support S32_LE (remove the other formats 
> for now)
> 
> In the hw_params calls handle the S32_LE in a same way as you handle the 
> S16_LE.
> 
> To explain what we are doing:
> Configure the codec to support only S32_LE format, but tell ALSA, that out of 
> the 32 bit only the first 16bit is valid.
> So the driver will be opened with S32_LE mode, but only the first 16 bits will 
> have audio data:
> 0-15: Left audio
> 16-31: zero (padding on left channel)
> 32-47: Right audio
> 48-63: zero (padding on right channel)
> 
> Use aplay -Dplughw:0,0 -v <some sample> to play audio, and see, if the HW has 
> been opened with S32_LE.
> 
> You should have full stereo sound now.
>
I do, thanks. I am truly amazed that I was able to follow your
instructions and get it to work first time. You must really know your
alsa machine implementation.


The problem is that now I cannot run 44.1Khz audio, I get underruns. I
am guessing that software is expanding the samples from 16 bits to 32?
Without your hack 44.1Khz audio works fine (but only audible in the
first channel).


> I have CC-d the author of the wm98095 codec driver, hi might be able to help 
> you with the codec setup...
> 

I talk to Peter every day. He brought up the codec, I am trying to use
the Beagleboardxm as a generic Linux platform for new codec bringups and
for following kernel and alsa cutting edge software.

Regards, Steve
