From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 0/9] Generic PHY Framework
Date: Mon, 24 Jun 2013 22:34:03 +0300
Message-ID: <20130624193403.GB11815@arwen.pp.htv.fi>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <51BEE203.6090103@samsung.com>
 <20130618094942.GY5461@arwen.pp.htv.fi>
 <51C89D98.1070806@samsung.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5839195001746415401=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51C89D98.1070806-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============5839195001746415401==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline

--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2013 at 09:27:20PM +0200, Sylwester Nawrocki wrote:
> Hi,
>=20
> On 06/18/2013 11:49 AM, Felipe Balbi wrote:
> > On Mon, Jun 17, 2013 at 12:16:35PM +0200, Sylwester Nawrocki wrote:
> >> I have already used this API for our MIPI CSI-2/DSIM DPHYs driver,
> >> the RFC patch series can be found at [1].
> >>
> >> Thanks,
> >> Sylwester
> >>
> >> [1] http://www.spinics.net/lists/arm-kernel/msg251666.html
> >=20
> > one comment to that series:
> >=20
> > let's make the phy names standardized, how about phy-exynos-video-mipi.c
> > or phy-mipi-csi-dsim.c ?
>=20
> Yes, I have been thinking about that, wasn't sure exactly what pattern to
> chose. I would make it phy-exynos-mipi-video.c, phy-exynos-dsim-csis.c fe=
els
> a bit odd. phy-mipi-csis-dsim.c might be to generic as MIPI CSIS stands f=
or
> MIPI CSI Slave and MIPI DSIM - MIPI DSI Master. And there might be (actua=
lly
> are) IP blocks in an SoC that use the other MIPI Aliance standards.
> For the HDMI PHY I guess just phy-exynos-hdmi.c could be used.

sounds good to me :-)

--=20
balbi

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyJ8rAAoJEIaOsuA1yqREkSYP/2qexP8Dx9H7/V27jpH0HX9E
8MvETKnha0gPPT7aIp4wRK5ym1or1ZfWODJipaRvhgeG31JSFD+i3FHib8M2M08j
ba01L45w6C9exijHIbFZ0kBpt/+bxnjeb1s5m/ieR8SxAiyocnlNEmRlSEXajzO8
yFk7IzQUxslewCmFhkuuo68bp5xkH7G0yE278RfZQnBqMefdEGdCJr9CPKoS3NUI
srYt3rWWeLcAzF6VNR9fY+5YhRSoP3goLPMrLHSgD3w1Pg80kSJtArnAeReHYcHN
jsWt+gS7LU6c/WzGfR9Nm3CqvPNNXs++nepvNCFwGQGJCFrS/vSxOQQg7NMELNfX
dN1NpgBn7JiYi3XVNJEWx/8+Mm6GcVKD6WCpP99Mh955urXAdrbNniVd3W7+SiVc
0jPMDK6uf5HPPevdC0g4Lnz1AgdE1qjzEP77xx+MnrWFb0lzQPBtHIpdiqBli2Dq
HwkWYDIMmQGtcSpxg44nPnv/IAecQ7V5QvHZSqL3TbAF48bgWKAJyOiaJE9XZyUa
u1yJwrqJ4VSB9mXw9BcIgsTm0O5HS0bf0U8tF0jKaQGlcXXgpN1BdWal9pY4ilGn
gKjDAQdHCULoh4A7PPyfGwNkT36kaFQULa7J8b8IMI06CIm/iUjbNUuK/IlgRQ3y
QfQA5Ycvr0WFgethw3YO
=Ny+s
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--

--===============5839195001746415401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5839195001746415401==--
