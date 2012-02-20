From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: pandora: switch clock back to internal on stop
Date: Mon, 20 Feb 2012 15:26:54 +0200
Message-ID: <4F424A1E.9000502@ti.com>
References: <1329604795-24509-1-git-send-email-notasas@gmail.com> <20120219063005.GA4517@opensource.wolfsonmicro.com> <CANOLnOO=UMKJ1CKXKzP5LC_rttxWYRo2yMe9M7PtSL7eV1+GxA@mail.gmail.com> <4F4217EC.7080806@ti.com> <CANOLnOPdDHimsiKFBVvDJcoaE2y9be=vzZj8hTQvbL2sOhgOgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:56081 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752205Ab2BTN0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Feb 2012 08:26:52 -0500
Received: by mail-lpp01m010-f50.google.com with SMTP id m13so7710366lah.23
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 05:26:51 -0800 (PST)
In-Reply-To: <CANOLnOPdDHimsiKFBVvDJcoaE2y9be=vzZj8hTQvbL2sOhgOgA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org

On 02/20/2012 12:50 PM, Grazvydas Ignotas wrote:
> Sounds good, I can wait for this I guess.

I just wonder why not just switch to twl4030 master scenario for
pandora? I know that there are products out there using this scenario (=
I
mean real consumer devices), and AFAIK they work pretty well.
What is the main reason to keep pandora in McBSP master mode? What is
the benefit for the platform? Can you send the per domain to suspend
during audio playback?

> Slightly off-topic: would you mind getting OSS emulation working on
> OMAP? We talked about it some years back.. I'm still carrying this
> hack in pandora tree:
> http://git.openpandora.org/cgi-bin/gitweb.cgi?p=3Dpandora-kernel.git;=
a=3Dcommitdiff;h=3D7717278f6e

Hrm, yes I remember. Was it so that the OSS emulation calls hw_params
several times, each with different parameter to configure, or something=
?

If you do not have duplex operation this might be OK to do, but there
are cases when we return -EINVAL if a parameter is not correct...
To be honest I have not used OSS emulation for quite a long time, and
systems tend to use PulseAudio or AudioFlinger nowdays.
If it is really important for you we can take a look, it might bring
enhancements for other users as well at the end.

We also have the same mechanism in place in omap-mcbsp.c (to not allow
reconfiguration of the mcbsp port) so 'fixing' twl4030 might not be
enough for you.

> We have found in-kernel OSS emulation to have best compatibility and
> performance, and the later is important for a games machine with an
> aging SoC..

Is it still the case?

> The other issue with pandora on mainline is frequent buffer underflow=
s
> just after the stream starts. Games tend to use tiny buffers with a
> goal to have low audio latency, and this often ends up with endless
> loop of stream start and underflow events. We used this hack on
> earlier kernels (the comment is probably not entirely correct, and
> fifo_samples should be multiplied by channels I guess):
> http://git.openpandora.org/cgi-bin/gitweb.cgi?p=3Dpandora-kernel.git;=
a=3Dcommitdiff;h=3Dd3ef3adfa

So we want to make sure that application written at least FIFO amount o=
f
data into the buffer before we start the McBSP/DMA, right?
Not sure if it is a valid thing to just override the start_threshold.
But if we do something like this it might be better to have support in
the core (ASoC, or even in ALSA)..

> This can of course be fixed in a program itself, but the idea was to
> reduce effort needed to port things to pandora, and now I'll have to
> be carrying this for compatibility, but I wonder how that looks from
> mainline point of view.

We can try to figure out something, but I have a feeling that this woul=
d
be useful for other platforms as well.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
