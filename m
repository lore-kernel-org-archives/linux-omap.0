From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: devicetree: add support for loopback mode
Date: Sat, 15 Dec 2012 16:55:46 +0200
Message-ID: <20121215145546.GA15606@arwen.pp.htv.fi>
References: <1355301960-21523-1-git-send-email-balbi@ti.com>
 <1355301960-21523-2-git-send-email-balbi@ti.com>
 <20121215003224.CBFD93E0BEC@localhost>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7087357056491129637=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121215003224.CBFD93E0BEC@localhost>
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
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--===============7087357056491129637==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 15, 2012 at 12:32:24AM +0000, Grant Likely wrote:
> On Wed, 12 Dec 2012 10:46:00 +0200, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > there are a few spi master drivers which make
> > use of that flag but there is no way to pass it
> > through devicetree.
> >=20
> > This patch just creates a way to pass SPI_LOOP
> > via devicetree.
>=20
> I don't understand how this would be useful since loopback mode is
> really just a test feature. Is there any reason to do loopback for
> something other than test?
>=20
> I think it would be better to add a sysfs or debugfs property to
> manipulate the SPI_LOOP flag from userspace. What do you think?

might be nicer in the long run, indeed. Want me to look into it, or do
you wanna do it yourself ?

--=20
balbi

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQzI9xAAoJEIaOsuA1yqREwFgP/RdGkkiBhtfeNQAHXMa/bNxI
9dUPXPLjMtMLDj0eEgqUOsJWSFhhq7Sh+yenElWQAfyKjtNMqDsm3ZPLb9VRRHue
a2G1NuD9T86+7NY6FjxglY9XAIqOosIQ3NlwKHnDkNbpwDdVwwQPw8Cw9UJWH/2q
PM3UHHIWifXqXADKlBiznY5rNnpQVEfY2/zm5U5jcUZDPq4cqfdFMxVneEZOgqtD
DJpuskr2Udflw17l1rSVDXmNKfGftavMpMTxVN60deZdlNBwkFt/cyfMB8nFewFJ
RTtKEZNstCkH7AHa/V0fp8s1bB2Zd2zuF00ofGABXx2T7sjqnW082yhFZXPzOgON
xNRnFThKcF6KkEzO/C/Kl8yXoHC2T1QONDV/quL73xk+5T3eXP723l2U6Qb4d+tf
hlxPMEIE8HAsspKK6FcYuaNxnKOHLB9pJe1tTEaLIlWFvHL90uzTJz/dEksM+URO
xFXmEVyN7LDgpDErHUL01daCnHAKF8XiUwa12FEA2Uvn5qw83gTTO0ou3lBjlRaN
3P6OTxrEvVNaElWW29FRpmjDQ4P7WWzjr6ftIbKtN0SS5BgH81XcLN40XlPx95LK
mc4jwtxqlcplXOIOks2xfTsTSitJ9aqSwn4mKT00+CWopLXdc7p8NYtX8zOM+05G
A6cIfq/os96qVbMrQeyI
=SeZs
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============7087357056491129637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7087357056491129637==--
