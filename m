From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC] ASoC: snd_soc_jack for HDMI audio: does it
	make sense?
Date: Tue, 21 Aug 2012 09:01:07 +0300
Message-ID: <1345528867.15491.12.camel@lappyti>
References: <5032E8A5.8070108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2690218304647117694=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5032E8A5.8070108@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>, Rob Clark <rob@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "Brown,
 Mark" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Guiriec,
 Sebastien" <s-guiriec@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============2690218304647117694==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Szot05M4txkX9DqslzbM"


--=-Szot05M4txkX9DqslzbM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-20 at 20:47 -0500, Ricardo Neri wrote:
> Hello!
>=20
> I have been working on prototypes for the ASoC OMAP HDMI audio driver to=
=20
> propagate events from the HDMI output (e.g., display getting=20
> enabled/disabled/suspended). This for the users of the driver to react=
=20
> to such events. For instance, if the display is disabled or disconected,=
=20
> audio could be stopped, rerouted or whatever other decision the user=20
> makes. This is needed because, if, for instance, the  HDMI IP goes off,=
=20
> audio will stall and the audio users will only see a "playback write=20
> error (DMA or IRQ trouble?)"
>=20
> In my prototypes I have used snd_soc_jack for this purpose and I have=20
> some questions:
>=20
> *I see snd_soc_jack is used mostly for headsets and microphones with=20
> actual external mechanical connections. Strictly, in my case I propagate=
=20
> events originated by the OMAP display driver (changes in the power=20
> state), and not from external events. Some of these events are generated=
=20
> from an actual HDMI cable connection/disconnection, though.
>=20
> *Maybe the event should be propagated by omapdss/omapdrm/drm and the=20
> entity in charge of the audio policy should listen those events instead.
>=20
> *I do see SND_JACK_VIDEOOUT and SND_JACK_AVOUT types so maybe it is=20
> feasible for an audio driver to report events from an AV output.
>=20
> I was wondering about how much sense does it make to you guys use a=20
> snd_soc_jack in this case?

How does DRM handle audio? I made a quick grep, but I see the drm
drivers only enabling the audio in the HW, nothing else.

If there's a common generic way to handle this, we should obviously use
that. But if we need to choose between doing something custom or doing
it in omapdrm driver, I think we should go for drm the only solution and
forget about audio with omapfb.

 Tomi


--=-Szot05M4txkX9DqslzbM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQMyQjAAoJEPo9qoy8lh71hwIP/iONBQLhPP9iXI7WEYU6BNUD
MGJoTFNDPZAUXtuZOssNXLRGFs/ISwZxPGXPLGixuh7N8Iod7kHntajS3JlFU9V4
5lR6kUePjabWqpLfE3inmNLfDDeOcCgoGDZBOtbPeUDZICC+ajJwy6SIFsSlGKeI
mMZbGTeuyamiaaKG56lAFHM9TwMRHrEeoSwSoDcqLg15UjQfl1GISAayzTM9dLor
YcBVrSeG+jqBYaJL3Su/u2gDMX0zdDUfqOYk5TzU7+O2MolCgzYWxUCdHq4t8cDO
Q1CdrZkNnJ5cfOtmpptf/QBLsaSqTGldpyAe0SgEK01Jrnr4QUDBzMdDUQf/Eezq
d4bg1bAYaHbvS/0DGoR74DkvtUoE8Cz0igWpyEGgyu581ADZtDLucEo8Kwl5DZqq
q9AkPt2LJZXfYFo9yUfZQ3Vta0b/OS6W7Tfh9UHRot51h+S2dHG1f4xjxEbgBfZ7
kLgmrUxpTXX9OmvXwdeNSYjAwOBJl4Q7D2cLmgmGSVj8FfmNu9RY4Lvnj9A5YBOG
DoatF1AsIW8xjsL2JiZ/xwOQo7tslqedrVDIvBPL16yf9K2eEoV2Rt66AjqVsIKW
wNP+yk0aQEp7OxKpMB1bY85u1X5hgBg+x5Dd7fV2KPLlAQkgrBjxIVoYQ57yU9r4
16icE0kjj+6gUa1yI97h
=K9TE
-----END PGP SIGNATURE-----

--=-Szot05M4txkX9DqslzbM--


--===============2690218304647117694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2690218304647117694==--
