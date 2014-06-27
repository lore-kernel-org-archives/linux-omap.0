From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC DAI component
 driver implementation
Date: Fri, 27 Jun 2014 14:57:28 +0300
Message-ID: <53AD5C28.6000009@ti.com>
References: <cover.1403807781.git.jsarha@ti.com> <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KHqoidoJmj00O3sRCGQbcfaEMCIOqxVQx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56808 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754AbaF0L5x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 07:57:53 -0400
In-Reply-To: <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

--KHqoidoJmj00O3sRCGQbcfaEMCIOqxVQx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/14 22:20, Jyri Sarha wrote:
> Integrate ASoC DAI component driver in to the OMAP hdmi driver. The
> patch also updates the relevant entry in ti,omap5-dss DT binding
> document. The driver registers a dummy hdmi codec driver and a
> simple-card driver to produce a fully functional ALSA device. The DAI
> driver is implemented in hdmi_audio.c, but it still needs to be
> registered from hdmi4.c or hdmi5.c.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/Makefile     |    2 +
>  drivers/video/fbdev/omap2/dss/hdmi.h       |   38 +++-
>  drivers/video/fbdev/omap2/dss/hdmi_audio.c |  317 ++++++++++++++++++++=
++++++++
>  3 files changed, 355 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/video/fbdev/omap2/dss/hdmi_audio.c
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbd=
ev/omap2/dss/Makefile
> index 245f933..8260987 100644
> --- a/drivers/video/fbdev/omap2/dss/Makefile
> +++ b/drivers/video/fbdev/omap2/dss/Makefile
> @@ -14,5 +14,7 @@ omapdss-$(CONFIG_OMAP2_DSS_DSI) +=3D dsi.o
>  omapdss-$(CONFIG_OMAP2_DSS_HDMI_COMMON) +=3D hdmi_common.o hdmi_wp.o h=
dmi_pll.o \
>  	hdmi_phy.o
>  omapdss-$(CONFIG_OMAP4_DSS_HDMI) +=3D hdmi4.o hdmi4_core.o
> +omapdss-$(CONFIG_OMAP4_DSS_HDMI_AUDIO) +=3D hdmi_audio.o
>  omapdss-$(CONFIG_OMAP5_DSS_HDMI) +=3D hdmi5.o hdmi5_core.o
> +omapdss-$(CONFIG_OMAP5_DSS_HDMI_AUDIO) +=3D hdmi_audio.o

This adds the hdmi_audio.o twice. I'm not sure what the linker does, but
I don't think that's correct.

Maybe have a internal CONFIG_OMAP_DSS_HDMI_AUDIO option, which is
selected if OMAP4 or OMAP5 HDMI AUDIO is selected by the user.

That same internal option could be used in the code also (where is
applies), instead of "if OMAP4_AUDIO || OMAP5_AUDIO".

 Tomi



--KHqoidoJmj00O3sRCGQbcfaEMCIOqxVQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrVwtAAoJEPo9qoy8lh71C48QAIa7G0+IrrRWToT81cqP2S1R
zCXhZpmED7tCYg8ikvVz+wxhaoKeswhuWZkWDFQilLHXil7nJXfH5XjeeuhT0Lj0
gSYWRTDlHVKcS57ge38tdKJYBTs/4DW7PXB16eHTqCDp+dQDkP2KwXN6Sb1OXkMU
ZfnGDC/C6+tzvYL8c7moalmnUd2kE0gAKrsWZ96zM6h78KCrtyh+G7nFYF7pt5W/
iNRciVmpeTygqE6aXKTBBURnIh0vc95IRwDeznRJMCGLBaE4YN16MKPrnojgpIMu
omrOS8EsSyXL0CrV9lYhKTboeLWgrRLYzsCDuMB+9IKcLkHWLgfNt5Q6SOEq4151
U53stdcxQj9qDeIs2jR2+K7ivIUgN8q7vC96fckD6mZqjWeGtr647wKuP9ORrGgz
fKUdIlODSHioz3fcqw3o+Rbx7eMItpPFgwbOxMTG8j/RBj12W7NsDa5z9gd3wD1g
6neBee+/hyjOh9YhW6DllYA5Z6owM7pkI+zuCKLRIIWPES0Jwm2njichgECRV0tY
5+n5wCDI73ginN/VaU4fOFQscApkakKAqZiyz2rG2XorEjaPF+pIBGqs2s20nlED
oKwhKzkuU2Ibv92wfHY6nLvBmnsPGC/BZqPw4hIVuz6AXMZjlqSwlw89AzZiXXl4
VQ/sOTqi+aMJOoHv5jMa
=EQTL
-----END PGP SIGNATURE-----

--KHqoidoJmj00O3sRCGQbcfaEMCIOqxVQx--
