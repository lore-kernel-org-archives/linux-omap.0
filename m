From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Fri, 20 May 2011 09:56:56 +0300
Message-ID: <201105200956.56507.peter.ujfalusi@ti.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105191428.10115.peter.ujfalusi@ti.com> <4DD5AEA6.6020907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33618 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab1ETG47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 02:56:59 -0400
In-Reply-To: <4DD5AEA6.6020907@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, Peter Hsiang <cdefgab1288@gmail.com>

On Friday 20 May 2011 02:58:30 Steve Calfee wrote:
> On 05/19/11 04:28, Peter Ujfalusi wrote:
> Correct, I can set bit clock to 64*lrclk, 48*lrclk, 128*lrclk, 17*lrc=
lk,
> and 18*lrclk.

Strange, that there is no option for 32*lrclk.

> The audio folks here think that it is normal to send more
> than required bit clocks, data is sent first so just ignore the rest.

Yes, it is allowed. The rest should be ignored.
But I'm afraid, OMAP McBSP can not handle this in a way you (and me) wa=
nted=20
to.

> It would appear that the mcbsp doesn't really use the lrclk (I think
> called FSX), it just uses a positive transition to start the bit
> shifting for all the requested bits. The falling edge does not start =
the
> right channel, the shifter keeps going until all requested l/r counts
> have been sent.

Yeah, McBSP only cares about the start condition, it does not care abou=
t the=20
right channel FSX transition.
This is the reason it is not possible to handle the scenario you are ai=
ming=20
for.
At start condition, it just start to send the data stream (frame1 follo=
wed by=20
frame2 in dual-phase mode - in single phase mode it can send up to 128=20
frames).
Having said that, there might be a way to actually work this around wit=
h=20
McBSP's multichannel mode. Configuring it for 4 slots, and only shift d=
ata for=20
slot 0, and 2 in case of your setup (16bit data within 32 bitclocks).
It is a long shot, I can not promise that I can take a look right away,=
 but if=20
you have time.... ;)

> > You should have full stereo sound now.
>=20
> I do, thanks.

Cool :D

> I am truly amazed that I was able to follow your
> instructions and get it to work first time. You must really know your
> alsa machine implementation.

Thanks, I try.

> The problem is that now I cannot run 44.1Khz audio, I get underruns. =
I
> am guessing that software is expanding the samples from 16 bits to 32=
?
> Without your hack 44.1Khz audio works fine (but only audible in the
> first channel).

Hmm. I have used similar mode with twl4030, and tlv320dac33 (S32_LE wit=
h=20
24msbits) without issues with underrun. Let's see.
Can you check /sys/devices/platform/omap-mcbsp.X/dma_op_mode, max_tx_th=
res for=20
your McBSP port?
I would suggest to switch the dma_op_mode to threshold mode in any port=
=2E

When you play audio try to use bigger periods, something like 10ms:
aplay -Dplughw:0,0 --period-time=3D10000 -v <your sample>

Replace the -Dplughw:0,0 to point to the wm98095 PCM.

Could you post the output of aplay?

> I talk to Peter every day. He brought up the codec, I am trying to us=
e
> the Beagleboardxm as a generic Linux platform for new codec bringups =
and
> for following kernel and alsa cutting edge software.

Make sense..

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
