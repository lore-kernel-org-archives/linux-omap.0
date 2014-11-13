From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio
 support
Date: Thu, 13 Nov 2014 16:00:02 +0100
Message-ID: <20141113160002.7a1157a5@armhf>
References: <cover.1415803064.git.jsarha@ti.com>
 <20141112222344.GU3815@sirena.org.uk>
 <54646648.5030807@ti.com>
 <20141113101738.6338bb1c@armhf>
 <54648149.9070104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:38232 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbaKMO5B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2014 09:57:01 -0500
In-Reply-To: <54648149.9070104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, 13 Nov 2014 12:00:41 +0200
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

	[snip]
> Jyri or Peter knows this better, but I think one difference with OMAP
> HDMI case and tda998x is that tda998x is an external encoder, and you
> transfer audio data to it via i2s or spdif, whereas OMAP HDMI is insi=
de
> the SoC, and the HDMI IP gets the audio data via system DMA.
>=20
> The system DMA transfers are triggered by the HDMI IP, and the HDMI I=
P
> has to be enabled and properly configured for the DMA ports to functi=
on.
>=20
> So, correct me if I'm wrong, but I think this is the fundamental diff=
erence:
>=20
> In your case, the actual audio playback happens with the i2s or spdif
> side. You can enable the playback at any time, no matter what is the
> status of tda998x. If tda998x is not operational, the audio data will
> just go to /dev/null.
>=20
> In our case, the actual audio playback happens inside the HDMI block.=
 We
> need the whole HDMI block to be operational and correctly configured =
for
> (fake or real) playback to be possible.

When the tda998x is not operational, the CODEC knows it and reports an
error to the audio subsystem on device open. But, once the tda998x has
been started, it always stays operational, even without HDMI connection=
=2E

> > and I saw only a few dependencies between the 2 subsystems:
> >=20
> > - the CODEC must know the transmitter parameters (DAIs - static -,
> >   audio constraints - dynamic -),
>=20
> The video mode (i.e. availability of audio) or the EDID (i.e. the
> supported audio parameters) may change at any time, so I presume in y=
our
> series the video side will inform the codec of these changes at any p=
oint?

Such changes occur only when the HDMI output device (TV) is replaced by
an other one (manual cable exchange or HDMI switcher). I wonder if
these changes are correctly treated in the HDMI transmitters, DRM core,
DRM drivers, X11/wayland...

So, no, actually, once streaming is started, no information go from the
HDMI transmitter to the CODEC.

> > - the CODEC must alert the transmitter on audio start and stop.
> >=20
> > I don't think that stopping audio streaming on HDMI disconnection i=
s
>=20
> And you allow audio playback also if the monitor does not support aud=
io,
> or the video mode does not supprot audio?

Bug in my patch: audio playback will be rejected if there will be no
audio support.

> > useful. I even let audio streaming start when the HDMI cable is
> > disconnected.
>=20
> Ah, this is actually unclear thing to me: what should the audio side
> behavior be when the HDMI cable is disconnected or the video is blank=
ed?
> I believe the options are:
>=20
> a) Always keep the audio device operational, no matter what is the
> status of the video side. How should this work if the HDMI videomode =
or
> the HDMI monitor does not support audio? Is it desirable that the
> userspace has no idea that the audio is not actually going anywhere?
>=20
> b) Remove the audio device when audio support is not available. This
> kind of makes sense, as, well, there's no possibility for audio outpu=
t.
> But maybe this is not how linux sound devices are supposed to behave?
>=20
> c) Return errors when playback is attempted when audio support is not
> available. Again, this kind of makes sense, as audio playback is not
> possible. But maybe this is also not how audio devices generally work=
=2E
>=20
> Jyri, were there some other options we discussed?
>=20
> Currently, the OMAP HDMI version does c). It's the easiest solution f=
or us.

Same for me, but checking the audio capability is done on audio streami=
ng
start only.

When the HDMI output device is disconnected, the video and audio output=
s
don't need to be changed. I often switch off my TV set when I will not
use my computer for a while, letting the computer itself running. When
I get back and switch on back the TV set, video and audio are still
there.

> Option a) is a bit problematic for us, as it requires the HDMI IP sid=
e
> to be fully operational, with the video output configured and enabled=
,
> as that is what drives the audio DMA. If we stop the video, I believe
> the audio DMA will freeze, and it'll lead to timeouts on the audio si=
de.
>=20
> I haven't tried, but I believe we could program the HDMI IP to some s=
afe
> default video mode if the cable is disconnected, and turn off the act=
ual
> HDMI PHY, so that the audio side could work even if the HDMI stream i=
s
> not going anywhere. I think it would be quite big change to how the H=
DMI
> driver works at the moment.
>=20
> But then, if the cable _is_ connected and the video mode is such that=
 it
> cannot not support audio, I wonder if we can still fake the audio
> playback or will the HDMI IP get confused...

AFAIK, the HDMI transmitters don't know if the video or audio is
displayed/played by the external device(s). Only the user knows.

BTW, you are talking about video modes without audio support. What are
you thinking about?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
