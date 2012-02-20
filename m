From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] ASoC: pandora: switch clock back to internal on stop
Date: Mon, 20 Feb 2012 17:34:20 +0200
Message-ID: <CANOLnOPCtPX5nOpDV-YCjVpv42kiHWsd3=0NcKaUKmH3wZSekA@mail.gmail.com>
References: <1329604795-24509-1-git-send-email-notasas@gmail.com>
	<20120219063005.GA4517@opensource.wolfsonmicro.com>
	<CANOLnOO=UMKJ1CKXKzP5LC_rttxWYRo2yMe9M7PtSL7eV1+GxA@mail.gmail.com>
	<4F4217EC.7080806@ti.com>
	<CANOLnOPdDHimsiKFBVvDJcoaE2y9be=vzZj8hTQvbL2sOhgOgA@mail.gmail.com>
	<4F424A1E.9000502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42425 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab2BTPeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 10:34:20 -0500
Received: by iacb35 with SMTP id b35so7625414iac.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 07:34:20 -0800 (PST)
In-Reply-To: <4F424A1E.9000502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org

On Mon, Feb 20, 2012 at 3:26 PM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
> On 02/20/2012 12:50 PM, Grazvydas Ignotas wrote:
>> Sounds good, I can wait for this I guess.
>
> I just wonder why not just switch to twl4030 master scenario for
> pandora? I know that there are products out there using this scenario=
 (I
> mean real consumer devices), and AFAIK they work pretty well.
> What is the main reason to keep pandora in McBSP master mode? What is
> the benefit for the platform?

Pandora uses 256*fs clock for it's external DAC, which was added for
improved audio quality (mcbsp2 is connected there instead of twl).
twl4030 can only provide 256*fs clock in slave mode. So twl4030 is not
used for playback, but is still used for audio in.

Speaking of which, there is crazy amount of twl4030 audio controls
available that are not relevant to pandora, since these things are not
connected, confusing the users. I think there were plans to hide
snd_soc_dapm_nc_pin() marked things, but that never materialized?

> Can you send the per domain to suspend
> during audio playback?

I suppose not, pm_debug counters are not increasing while audio is
playing. Is that supposed to be possible?

>> Slightly off-topic: would you mind getting OSS emulation working on
>> OMAP? We talked about it some years back.. I'm still carrying this
>> hack in pandora tree:
>> http://git.openpandora.org/cgi-bin/gitweb.cgi?p=3Dpandora-kernel.git=
;a=3Dcommitdiff;h=3D7717278f6e
>
> Hrm, yes I remember. Was it so that the OSS emulation calls hw_params
> several times, each with different parameter to configure, or somethi=
ng?

Yes, OSS has separate ioctl's for setting rate, channels, etc, each of
which translates separate hw_params call, and twl4030 only accepts
first one, so most things end up unconfigured. What's worse the
program isn't even told some parameters were not set because there is
no error returned.

> If you do not have duplex operation this might be OK to do, but there
> are cases when we return -EINVAL if a parameter is not correct...
> To be honest I have not used OSS emulation for quite a long time, and
> systems tend to use PulseAudio or AudioFlinger nowdays.
> If it is really important for you we can take a look, it might bring
> enhancements for other users as well at the end.

At least for now we are using kernel OSS emulation, so it would be
nice to have it working. PulseAudio was problematic some time back,
maybe it's good now, but it's hard to imagine adding another audio
layer would not affect performance. Additional latency or CPU use is
not good for a games console, even if it's small.

> We also have the same mechanism in place in omap-mcbsp.c (to not allo=
w
> reconfiguration of the mcbsp port) so 'fixing' twl4030 might not be
> enough for you.

True, it seems first hw_params matches all others in most cases so it
was not an issue.

>> We have found in-kernel OSS emulation to have best compatibility and
>> performance, and the later is important for a games machine with an
>> aging SoC..
>
> Is it still the case?

Well at least for performance I think it still is, and pandora is
stuck with OMAP3s at least for a while more.

>> The other issue with pandora on mainline is frequent buffer underflo=
ws
>> just after the stream starts. Games tend to use tiny buffers with a
>> goal to have low audio latency, and this often ends up with endless
>> loop of stream start and underflow events. We used this hack on
>> earlier kernels (the comment is probably not entirely correct, and
>> fifo_samples should be multiplied by channels I guess):
>> http://git.openpandora.org/cgi-bin/gitweb.cgi?p=3Dpandora-kernel.git=
;a=3Dcommitdiff;h=3Dd3ef3adfa
>
> So we want to make sure that application written at least FIFO amount=
 of
> data into the buffer before we start the McBSP/DMA, right?

I think it should be at least 2x fifo as IIRC underflow condition is
triggered when there is nothing left to DMA.

Some retro console emulators work like this:
while (1) {
  emulate the 'guest' CPU for 1 video frame
  generate 1 video frame's worth of audio data and send to host hardwar=
e
  draw video frame, read controls, etc
  sleep if there is time left
}

So in this case host audio hardware is always kept very close to
underflow condition, but has very low audio latency. This doesn't work
well with current mainline.

> Not sure if it is a valid thing to just override the start_threshold.
> But if we do something like this it might be better to have support i=
n
> the core (ASoC, or even in ALSA)..

Sure, that would work for us too.

>> This can of course be fixed in a program itself, but the idea was to
>> reduce effort needed to port things to pandora, and now I'll have to
>> be carrying this for compatibility, but I wonder how that looks from
>> mainline point of view.
>
> We can try to figure out something, but I have a feeling that this wo=
uld
> be useful for other platforms as well.

Sounds promising.

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
