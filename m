From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Thu, 19 May 2011 14:28:09 +0300
Message-ID: <201105191428.10115.peter.ujfalusi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105171342.35056.peter.ujfalusi@ti.com> <4DD464BB.3050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34297 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab1ESL2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 07:28:14 -0400
In-Reply-To: <4DD464BB.3050708@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, Peter Hsiang <cdefgab1288@gmail.com>

Hi,

On Thursday 19 May 2011 03:30:51 Steve Calfee wrote:
> On 05/17/11 03:42, Peter Ujfalusi wrote:
> Good suggestion. After switching to my codec as master, I could see t=
he
> clocks. But one problem was the beagleboardxm trainer has level
> shifters, but they are one directional, and not correct for my use. S=
o I
> reconnected to the expansion port pins (and re-did the voltage
> requirement of the codec to 1.8 volts). Now I get some sound.

Great, we are getting closer.

=2E..

> My codec cannot be set to use only 16 bits per phase. Is there a way =
to
> setup the omap so that data is sent to both channels? As you can see
> above the xphase bit is one saying dual channels. Is this a dma setup
> problem?

I can not find datasheet for the max98095...
So you can not configure the codec to use 2x16 number of bit clocks. wh=
en it=20
is configured to receive/send 16bit stereo samples?
Is this the case (that the codec all the time have 32 clock cycles per=20
channel)?=20

If this is the case, than it is kind of tricky to get around this, but =
you can=20
try the following (warning: hack):

In the codec driver:
create/add a startup callback function for the dais (snd_soc_dai_ops):

static int max98095_startup(struct snd_pcm_substream *substream,
			   struct snd_soc_dai *dai)
{
	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 16);

	return 0;
}

Modify the MAX98095_FORMATS to only support S32_LE (remove the other fo=
rmats=20
for now)

In the hw_params calls handle the S32_LE in a same way as you handle th=
e=20
S16_LE.

To explain what we are doing:
Configure the codec to support only S32_LE format, but tell ALSA, that =
out of=20
the 32 bit only the first 16bit is valid.
So the driver will be opened with S32_LE mode, but only the first 16 bi=
ts will=20
have audio data:
0-15: Left audio
16-31: zero (padding on left channel)
32-47: Right audio
48-63: zero (padding on right channel)

Use aplay -Dplughw:0,0 -v <some sample> to play audio, and see, if the =
HW has=20
been opened with S32_LE.

You should have full stereo sound now.

I have CC-d the author of the wm98095 codec driver, hi might be able to=
 help=20
you with the codec setup...

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
