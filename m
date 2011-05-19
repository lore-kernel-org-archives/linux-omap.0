From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Wed, 18 May 2011 17:30:51 -0700
Message-ID: <4DD464BB.3050708@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105161154.55850.peter.ujfalusi@ti.com> <4DD167EC.2010007@gmail.com> <201105171342.35056.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:62988 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab1ESAaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 20:30:55 -0400
Received: by pxi16 with SMTP id 16so1430439pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 17:30:55 -0700 (PDT)
In-Reply-To: <201105171342.35056.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On 05/17/11 03:42, Peter Ujfalusi wrote:
> Hi,
> 
> On Monday 16 May 2011 21:07:40 Steve Calfee wrote:
>> No, they get called. I just don't get the clock on the bclk pin.
> 
> OK.
> Could you try to disconnect the CLKX, and FSX lines from OMAP, and see that 
> you have the clocks on the codec side?
> If in this way you still can not see the clocks, than your codec (max98095 ?) 
> is not generating the clocks.
> Could you also post from your machine driver how you configure the formats for 
> cpu/codec DAI (snd_soc_dai_set_fmt call)?
> 
> While the clock lines are not physically connected, you can try to configure 
> either side to generate the correct clocks on the lines. When you see that, 
> you can connect them together, and see (hear) if it works.
> 
Hi,

Good suggestion. After switching to my codec as master, I could see the
clocks. But one problem was the beagleboardxm trainer has level
shifters, but they are one directional, and not correct for my use. So I
reconnected to the expansion port pins (and re-did the voltage
requirement of the codec to 1.8 volts). Now I get some sound.

One problem remains and is a mystery to me. My omap setup with the
max98095 codec is identical to the on board twl4030 device. The twl4030
works find, but my codec only plays one channel.

I hooked up a logic analyzer and discovered that my codec sends 32 bit
clocks per fsx or what we call lrclk. The twl4030 sends 16 bit clocks
per lrclk. I think that more than 16 bits is supposed to be ok and
someone here said some of the high end audio test equipment only sends
64 bitclock per lrclock and that seems to be within the standard. I
think the I2S protocol says data bits are aligned with the lrclk, so
what should be happening is the omap slave should send 16 bits of audio
followed by 16 bits of null, then the lrclk switches and it should send
the other channel of audio followed by null.

The data being sent by the omap is actually 32 bits in the first lrclk
phase, comprising the left 16 bits and the right 16 bits. The second
lrclk phase gets null sent for all 32 bits. My 32 bits has the same data
(from the same .wav file) that was sent to the twl4030 as two 16 bit
channels.

Here is the mcbsp register dump (the same from both twl4030 and max98095
runs).

[   54.391174] omap_pcm_trigger: cmd 1
[   54.395111] omap_start_dma: lch 0
[   54.399047] omap-mcbsp omap-mcbsp.1: **** McBSP1 regs ****
[   54.404815] omap-mcbsp omap-mcbsp.1: DRR2:  0x2000100
[   54.410125] omap-mcbsp omap-mcbsp.1: DRR1:  0x0000
[   54.415130] omap-mcbsp omap-mcbsp.1: DXR2:  0x0000
[   54.420166] omap-mcbsp omap-mcbsp.1: DXR1:  0x0000
[   54.425201] omap-mcbsp omap-mcbsp.1: SPCR2: 0x0235
[   54.430206] omap-mcbsp omap-mcbsp.1: SPCR1: 0x0030
[   54.435241] omap-mcbsp omap-mcbsp.1: RCR2:  0x8041
[   54.440277] omap-mcbsp omap-mcbsp.1: RCR1:  0x0040
[   54.445281] omap-mcbsp omap-mcbsp.1: XCR2:  0x8041
[   54.450317] omap-mcbsp omap-mcbsp.1: XCR1:  0x0040
[   54.455352] omap-mcbsp omap-mcbsp.1: SRGR2: 0x001f
[   54.460388] omap-mcbsp omap-mcbsp.1: SRGR1: 0x0f00
[   54.465393] omap-mcbsp omap-mcbsp.1: PCR0:  0x000f
[   54.470428] omap-mcbsp omap-mcbsp.1: ***********************
[   54.476379] snd_pcm_post_start: state 3

My codec cannot be set to use only 16 bits per phase. Is there a way to
setup the omap so that data is sent to both channels? As you can see
above the xphase bit is one saying dual channels. Is this a dma setup
problem?

Thanks for your help.

Regards, Steve
