From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange
 platform devices for ASoC drivers
Date: Fri, 16 Nov 2012 09:52:05 +0200
Message-ID: <50A5F0A5.2010105@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
 <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4559663329684096168=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, broonie@opensource.wolfsonmicro.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

--===============4559663329684096168==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9BED397FBD5D5CC4E992E186"

--------------enig9BED397FBD5D5CC4E992E186
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 03:36, Ricardo Neri wrote:
> This relocates and renames the platform devices for ASoC HDMI drivers
> to give them a more logical structure.
>=20
> The previous omap-hdmi-audio device is renamed as omap-hdmi-audio-card
> and is relocated to the SDP4430 and Pandaboard board files. This is to
> better illustrate the fact that it describes the whole HDMI audio
> functionality on such boards, including the companion chip.
>=20
> The previous omap-hdmi-audio-dai is renamed as omap-hdmi-audio. The -da=
i
> part is removed to not have references to ASoC concepts in the OMAPDSS
> HDMI driver. Also, as it will be used by the ASoC HDMI CPU DAI driver,
> the name refers only to OMAP HDMI audio functionality, irrespective of =
the
> board.
>=20
> The names of the ASoC drivers are also updated accordingly.

And same thing here as with the previous patch. Do the move and rename
in separate patches for clarity.

> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c    |    6 ++++++
>  arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
>  arch/arm/mach-omap2/devices.c          |   17 -----------------
>  drivers/video/omap2/dss/hdmi.c         |    2 +-
>  sound/soc/omap/omap-hdmi-card.c        |    4 ++--
>  sound/soc/omap/omap-hdmi.c             |    2 +-
>  6 files changed, 16 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/=
board-4430sdp.c
> index 3669c12..97bdff3 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -388,6 +388,11 @@ static struct platform_device sdp4430_hdmi_audio_c=
odec =3D {
>  	.id	=3D -1,
>  };
> =20
> +static struct platform_device sdp4430_hdmi_audio_card =3D {
> +	.name	=3D "omap-hdmi-audio-card",
> +	.id	=3D -1,
> +};
> +
>  static struct omap_abe_twl6040_data sdp4430_abe_audio_data =3D {
>  	.card_name =3D "SDP4430",
>  	.has_hs		=3D ABE_TWL6040_LEFT | ABE_TWL6040_RIGHT,
> @@ -423,6 +428,7 @@ static struct platform_device *sdp4430_devices[] __=
initdata =3D {
>  	&sdp4430_dmic_codec,
>  	&sdp4430_abe_audio,
>  	&sdp4430_hdmi_audio_codec,
> +	&sdp4430_hdmi_audio_card,
>  };

I don't know anything at all about the audio drivers, but this doesn't
feel good to me. The HDMI audio is tied to the HDMI video, both of which
are parts of OMAP SoC. So if you have two boards with HDMI video (and
thus audio), the device data related to HDMI video and audio are
identical except for a few HW details like the GPIOs for the TPD chip.

So is there any reason to add hdmi audio devices in each board file? It
sounds to me that a common place to add the device for all boards would
make more sense. This could, perhaps, be arch/arm/mach-omap2/display.c
which handles adding the HDMI device, or some other similar file
(although you just removed it from such a file, the devices.c...).

And actually, why isn't the card driver added in the hdmi video driver,
like the omap-hdmi-audio-dai?

You say the omap-hdmi-audio-card covers also the TPD chip, but why does
HDMI audio even need to cover that chip? It has no relevance to the
audio side, as long as the video driver enables it properly, right?

Perhaps I'm missing something here, as I don't have any knowledge of the
audio side, though. What do the different audio devices represent?

So I'm not saying your approach is wrong, I just don't understand it =3D)=
=2E

 Tomi



--------------enig9BED397FBD5D5CC4E992E186
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpfClAAoJEPo9qoy8lh717CcP/2y8GqvO9rSE8bG/EMAwLtcG
4HgD+gHpWAXJ09E6Y4yceyxGzbuaSgc2zRqkvCU0Gnhn+sv0wlGSyZAPv3lQQqeh
8jF2t0Co4SHXnr85IALYx8RSzeESkQxiuKJtBaH/e3waax3jPU7agIt71ce2kgPF
vralVWMbfVOhuKNdtLGbep5lNLic4KA2a0ha7jgZQ1opwb/hN3m7ErHxMyCIaUlg
eagNdsCpUk/JpYU/jSMJ9uzUQcg03FESoB5fcO7U08GQEPJkuuwiy3+YcL2Sw/Nz
nplnPkc0VhXIuUdTznJQhBXYAU8B+YI/vI+OYqC+nYcbqW9gDzREmI8PrvEMqIkg
7Kcva6yWrMhSHBNMPx3hl7dT62mVaMbadqperKDgL5PgrgaHvwEbmvWodODSagGF
w+56ZE+drWbOHkZ2HtqxTtMT4J2IEure4cwHKDklo3lRV7qMh+iBkq+q3jz/0xtJ
nChIoPGqIOHNpbHMPEJLjiUdX4ZFwEBgtHzunksM3xtc/h21NFD9gqDjdjM/f+B2
+5R4sjIe/mql8pynr5vmbTOjnr59StqJ1AVUzgR5Aw9Q3NAQzKaXZWi31QbDFB19
T0XQXiY/vO2J8CmawbcG8FamD8gvbet/+13Rica0Rc6IuxhYHwcwoj+fvM4BOh1I
zWtp0ttcKdR09w/Igp0e
=FgVf
-----END PGP SIGNATURE-----

--------------enig9BED397FBD5D5CC4E992E186--

--===============4559663329684096168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4559663329684096168==--
