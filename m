From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Thu, 13 Nov 2014 12:00:41 +0200
Message-ID: <54648149.9070104@ti.com>
References: <cover.1415803064.git.jsarha@ti.com>	<20141112222344.GU3815@sirena.org.uk>	<54646648.5030807@ti.com>
 <20141113101738.6338bb1c@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8020647977447873078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20141113101738.6338bb1c@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============8020647977447873078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6tNelDphKtg1xfid1AIeWoQemLOpx3mbe"

--6tNelDphKtg1xfid1AIeWoQemLOpx3mbe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/11/14 11:17, Jean-Francois Moine wrote:
> On Thu, 13 Nov 2014 10:05:28 +0200
> Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 	[snip]
>> I don't have much knowledge of the asoc architecture, so I probably
>> can't comment much on the sound/ side design. For me the most importan=
t
>> things are that 1) it works 2) I can easily unload/load the modules
>> (which was broken in some of the earlier versions).
>>
>> As a more general discussion item, I'm still wondering why it feels li=
ke
>> we (OMAP) are doing something totally new here. I'd imagine that almos=
t
>> every device with HDMI would need both video and audio side support, a=
nd
>> those sides need to work together. And the audio side would need to ge=
t
>> notified of things like cable disconnect (i.e. the video stream is
>> stopped -> audio must be stopped also). But if I've understood right,
>> there was no similar existing code to be found.
>=20
> I recently posted a patch on the HDMI CODEC to interface a HDMI
> transmitter
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-October/08274=
5.html

Jyri or Peter knows this better, but I think one difference with OMAP
HDMI case and tda998x is that tda998x is an external encoder, and you
transfer audio data to it via i2s or spdif, whereas OMAP HDMI is inside
the SoC, and the HDMI IP gets the audio data via system DMA.

The system DMA transfers are triggered by the HDMI IP, and the HDMI IP
has to be enabled and properly configured for the DMA ports to function.

So, correct me if I'm wrong, but I think this is the fundamental differen=
ce:

In your case, the actual audio playback happens with the i2s or spdif
side. You can enable the playback at any time, no matter what is the
status of tda998x. If tda998x is not operational, the audio data will
just go to /dev/null.

In our case, the actual audio playback happens inside the HDMI block. We
need the whole HDMI block to be operational and correctly configured for
(fake or real) playback to be possible.

> and I saw only a few dependencies between the 2 subsystems:
>=20
> - the CODEC must know the transmitter parameters (DAIs - static -,
>   audio constraints - dynamic -),

The video mode (i.e. availability of audio) or the EDID (i.e. the
supported audio parameters) may change at any time, so I presume in your
series the video side will inform the codec of these changes at any point=
?

> - the CODEC must alert the transmitter on audio start and stop.
>=20
> I don't think that stopping audio streaming on HDMI disconnection is

And you allow audio playback also if the monitor does not support audio,
or the video mode does not supprot audio?

> useful. I even let audio streaming start when the HDMI cable is
> disconnected.

Ah, this is actually unclear thing to me: what should the audio side
behavior be when the HDMI cable is disconnected or the video is blanked?
I believe the options are:

a) Always keep the audio device operational, no matter what is the
status of the video side. How should this work if the HDMI videomode or
the HDMI monitor does not support audio? Is it desirable that the
userspace has no idea that the audio is not actually going anywhere?

b) Remove the audio device when audio support is not available. This
kind of makes sense, as, well, there's no possibility for audio output.
But maybe this is not how linux sound devices are supposed to behave?

c) Return errors when playback is attempted when audio support is not
available. Again, this kind of makes sense, as audio playback is not
possible. But maybe this is also not how audio devices generally work.

Jyri, were there some other options we discussed?

Currently, the OMAP HDMI version does c). It's the easiest solution for u=
s.

Option a) is a bit problematic for us, as it requires the HDMI IP side
to be fully operational, with the video output configured and enabled,
as that is what drives the audio DMA. If we stop the video, I believe
the audio DMA will freeze, and it'll lead to timeouts on the audio side.

I haven't tried, but I believe we could program the HDMI IP to some safe
default video mode if the cable is disconnected, and turn off the actual
HDMI PHY, so that the audio side could work even if the HDMI stream is
not going anywhere. I think it would be quite big change to how the HDMI
driver works at the moment.

But then, if the cable _is_ connected and the video mode is such that it
cannot not support audio, I wonder if we can still fake the audio
playback or will the HDMI IP get confused...

 Tomi



--6tNelDphKtg1xfid1AIeWoQemLOpx3mbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZIFJAAoJEPo9qoy8lh71O7kP+QFRbm8n4u5581zZmYtp4J1N
AdXJ2nQY+WdXi1UWLnzlQytr1UsMEXZQyZITPRFGCVQ3Y68UDXbprRHDZAyV1j4b
GbqXuF1bw5Xt1KF0BTEMmgmNb2PKx1Ejzj65E8seVr/JboGNl+VUmb7IZ48Kcg0g
CrAMayzTg5Sj+cEepVAiedtCyToLAkStw+8IBucXdml6DnRAbk5YKPinqbn5Hh3K
pCAE3TKA5XSB+Wxg4SsVYyXeAERhK6gitUL2d3eD8f+x4zye26j8WY4tW7uskm/M
K/QI01naXpRIK8RNJBvfaSIrYt6Il35Z5WSII4YP5QM13FdxvOfRY9oHDQK98CV1
NDshU7NKWYR4T8WLoNGMgaogxYl5qnKeppJzCgnZgbq/lC9rAbeh5cpc4/WjmKCo
hrkp/VV3LzcUUTW4Rw+PJ3EoanpnX7UFJYubZCRMshsNQlzBrwIOhio3mAamY5rF
Z7+0NnX50wW1U7DZjhOMJWZUfmTasK9RznPP4FsZccQusLwEvDVLDFUojKhHbAja
OxAlSxVmPe9iFKWo3KXDA0/q8pLviq0hoV4fACpqeRPeIP4maATALjk32iGO3mvY
DQ9Wii/4/NjLttY93xeuqpLq2iP2tCsbo0W8ur58uR5BQzxWiIThPY5HCxRPufIR
KE5JzpPzI6A3z8niBICK
=nnlc
-----END PGP SIGNATURE-----

--6tNelDphKtg1xfid1AIeWoQemLOpx3mbe--

--===============8020647977447873078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8020647977447873078==--
