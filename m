From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [alsa-devel] [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Thu, 13 Nov 2014 17:44:38 +0200
Message-ID: <5464D1E6.4050508@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <20141113101738.6338bb1c@armhf> <54648149.9070104@ti.com> <20141113160002.7a1157a5@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ilEgJkmO4JHLAQi5dKqAscXjDHBisk6bQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47704 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938AbaKMPou (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2014 10:44:50 -0500
In-Reply-To: <20141113160002.7a1157a5@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--ilEgJkmO4JHLAQi5dKqAscXjDHBisk6bQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/11/14 17:00, Jean-Francois Moine wrote:

> When the tda998x is not operational, the CODEC knows it and reports an
> error to the audio subsystem on device open. But, once the tda998x has
> been started, it always stays operational, even without HDMI connection=
=2E

What does "started" mean here? tda998x device/driver has been probed?

The reason for the above is probably to handle hotplug? I.e. tda998x
needs to be enabled always to detect HPD?

Usually for OMAP, the HPD detection happens outside the HDMI IP. Thus
the HDMI IP is turned fully off when the video is disabled.

I believe tda998x could be used the same way, if the HPD pin is
connected to a SoC GPIO instead of tda998x.

>>> and I saw only a few dependencies between the 2 subsystems:
>>>
>>> - the CODEC must know the transmitter parameters (DAIs - static -,
>>>   audio constraints - dynamic -),
>>
>> The video mode (i.e. availability of audio) or the EDID (i.e. the
>> supported audio parameters) may change at any time, so I presume in yo=
ur
>> series the video side will inform the codec of these changes at any po=
int?
>=20
> Such changes occur only when the HDMI output device (TV) is replaced by=


The user can change the video mode at any time. The audio data packets
are sent in the video blanking intervals, and if those intervals are too
short, the video mode cannot support audio.

If I'm not mistaken, officially only certain video modes defined in the
HDMI spec support audio.

> an other one (manual cable exchange or HDMI switcher). I wonder if
> these changes are correctly treated in the HDMI transmitters, DRM core,=

> DRM drivers, X11/wayland...

HPD (which usually equals to cable change, but not always) is handled.

>> a) Always keep the audio device operational, no matter what is the
>> status of the video side. How should this work if the HDMI videomode o=
r
>> the HDMI monitor does not support audio? Is it desirable that the
>> userspace has no idea that the audio is not actually going anywhere?
>>
>> b) Remove the audio device when audio support is not available. This
>> kind of makes sense, as, well, there's no possibility for audio output=
=2E
>> But maybe this is not how linux sound devices are supposed to behave?
>>
>> c) Return errors when playback is attempted when audio support is not
>> available. Again, this kind of makes sense, as audio playback is not
>> possible. But maybe this is also not how audio devices generally work.=

>>
>> Jyri, were there some other options we discussed?
>>
>> Currently, the OMAP HDMI version does c). It's the easiest solution fo=
r us.
>=20
> Same for me, but checking the audio capability is done on audio streami=
ng
> start only.

Hmm, I understood you have option a)? You said "I even let audio
streaming start when the HDMI cable is
disconnected".

With "audio support is not available" I mean also the case when the
cable is not connected, as then we don't have EDID information, and thus
we don't have a HDMI monitor with audio support on the other end.

So to clarify, our driver only has "audio support available" if:
- we successfully read EDID
- EDID shows it's a HDMI monitor
- EDID shows it has audio support for the format we support (this we
don't actually do yet)

Otherwise we default to DVI, which means no audio.

If, at any point, the situation changes to "no audio support available",
the audio playback is aborted and starting new audio playback fails.

> AFAIK, the HDMI transmitters don't know if the video or audio is
> displayed/played by the external device(s). Only the user knows.

True.

But the HDMI transmitter can know if the audio absolutely cannot be
played, because there's no cable, or because the monitor says it doesn't
support audio, or because the video mode cannot support audio, or
because the HDMI output stream is disabled.

So the question is, do we want/need to inform the userspace about those
situations? Should a HDMI transmitted always look like it can play
audio, even if it's clear it cannot?

Again, I know very little about audio, but I think it would be nice that
if I open the sound configuration window on my desktop, it'd show me
that the HDMI audio device is disabled (because there's no cable).

But perhaps that's a separate feature. We could have HDMI audio device
always there and functional, but the desktop could get the information
about HDMI cable connection some other way (DRM). And if the cable is
not there, it knows that this particular audio device is also out, and
thus doesn't show it (even if it's functional).

> BTW, you are talking about video modes without audio support. What are
> you thinking about?

This I covered above.

 Tomi



--ilEgJkmO4JHLAQi5dKqAscXjDHBisk6bQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZNHmAAoJEPo9qoy8lh71ZnsQAJ3u5vsLVQeeP3aFXi+5ImDj
AwOx15QoWcd8MuBj5iToGCRhI1OFtTXWtqLzTfiTdm6PTKSUEkKyyUkfo9SdRyjb
upb6TqbhoxSl4KAeqQHaDoXjqyIV/F8fk3hxNrnxVyQ/0sn3RP/QjCdU2ZYDHe1y
LIcoTGSNisswzUGAEHaAvgpU4Le/7MtcBEjw0x5EzMCtO8+IDiUyQ6k1xThS87m8
fXDBk0m77D6DXwWVx0QciZCY/aZkbV5C0xnwgfyEA1tIU0FRZwyAq+t+wD3QbHv0
Yde7itRljdDbpqlL6t8yUNLnBS5zaFBbEDE8/N2UKyKx7YAiu+QNomEfJCTErvx4
eWbrY2sA/4Ex0Dp1owSGKKhY7iww1FiFsY0yaKyXfKVtHj9iuUzF9C5zVD9VD3Gj
80mcQyvcCdqBgx8hfcl3GhZS23R+xD7EGs2DDBbNxg0sWWwnfPwIQFOOY6zahV2E
RgVDWKj2gE/6ee8nJmyuWGRXIbM90aM5VSqGzHXzRTA/KV25KTc+iO7srDBxxern
DHn+x/N/sdB+6kDJVv0QooIU6HTwzcgr0yp7qx5xWx3yMJVTBcEfGzCMHZHII5wy
XHnxCcnhtIr3iZi3pnPjtlEdWMZff9bwflxaQtjjPG8qRiZWl+f8JyEzjPjbbkkI
LlUaPEfX4ceg8aGGRzRQ
=sqDc
-----END PGP SIGNATURE-----

--ilEgJkmO4JHLAQi5dKqAscXjDHBisk6bQ--
