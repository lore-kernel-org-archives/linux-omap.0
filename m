From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio
 support
Date: Fri, 14 Nov 2014 11:59:16 +0100
Message-ID: <20141114115916.6af5adce@armhf>
References: <cover.1415803064.git.jsarha@ti.com>
	<20141112222344.GU3815@sirena.org.uk>
	<54646648.5030807@ti.com>
	<20141113101738.6338bb1c@armhf>
	<54648149.9070104@ti.com>
	<20141113160002.7a1157a5@armhf>
	<5464D1E6.4050508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:59876 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965392AbaKNK4O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2014 05:56:14 -0500
In-Reply-To: <5464D1E6.4050508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, 13 Nov 2014 17:44:38 +0200
Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
	[snip]
> >> a) Always keep the audio device operational, no matter what is the
> >> status of the video side. How should this work if the HDMI videomo=
de or
> >> the HDMI monitor does not support audio? Is it desirable that the
> >> userspace has no idea that the audio is not actually going anywher=
e?
> >>
> >> b) Remove the audio device when audio support is not available. Th=
is
> >> kind of makes sense, as, well, there's no possibility for audio ou=
tput.
> >> But maybe this is not how linux sound devices are supposed to beha=
ve?
> >>
> >> c) Return errors when playback is attempted when audio support is =
not
> >> available. Again, this kind of makes sense, as audio playback is n=
ot
> >> possible. But maybe this is also not how audio devices generally w=
ork.
> >>
> >> Jyri, were there some other options we discussed?
> >>
> >> Currently, the OMAP HDMI version does c). It's the easiest solutio=
n for us. =20
> >=20
> > Same for me, but checking the audio capability is done on audio str=
eaming
> > start only. =20
>=20
> Hmm, I understood you have option a)? You said "I even let audio
> streaming start when the HDMI cable is
> disconnected".

The option a) is the one of the patch, but I am moving towards option c=
).

> With "audio support is not available" I mean also the case when the
> cable is not connected, as then we don't have EDID information, and t=
hus
> we don't have a HDMI monitor with audio support on the other end.

What I was saying is: when the cable is connected, all audio/video
parameters are known. Then, when the cable is disconnected, there is
no reason, a priori, to change these parameters, and audio/video
streaming may continue. The problem might be raised later when an other
monitor with different parameters will be connected.

> So to clarify, our driver only has "audio support available" if:
> - we successfully read EDID
> - EDID shows it's a HDMI monitor
> - EDID shows it has audio support for the format we support (this we
> don't actually do yet)
>=20
> Otherwise we default to DVI, which means no audio.
>=20
> If, at any point, the situation changes to "no audio support availabl=
e",
> the audio playback is aborted and starting new audio playback fails.
	[snip]

So, to summarize, you need the information 'audio support available' on
the audio side.

It should not be difficult to export a function in the generic HDMI
driver for this job. This function would have the following arguments:

- device (child device of the HDMI transmitter)
- pin (output widget name)
- status (enable/disable)

and would:

- set the pin status so that the HDMI output would be included or not
  in the audio path, and

- abort audio streaming on disabling audio.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
