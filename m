From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm/dts: omap5-evm: Add I2C support
Date: Mon, 6 Aug 2012 11:38:45 +0300
Message-ID: <20120806083843.GA17612@arwen.pp.htv.fi>
References: <1343997486-710-1-git-send-email-sourav.poddar@ti.com>
 <1343997486-710-2-git-send-email-sourav.poddar@ti.com>
 <501C08CB.3060701@mvista.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4099113542617135657=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <501C08CB.3060701-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
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
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============4099113542617135657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 03, 2012 at 09:22:19PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 08/03/2012 04:38 PM, Sourav Poddar wrote:
>=20
> > Add I2C data node in omap5 device tree file.
>=20
> > Tested on omap5430 sdp.
>=20
> > Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> > Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> > Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/omap5.dtsi |   35 +++++++++++++++++++++++++++++++++++
> >  1 files changed, 35 insertions(+), 0 deletions(-)
>=20
> > diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> > index 57e5270..6b68dfe 100644
> > --- a/arch/arm/boot/dts/omap5.dtsi
> > +++ b/arch/arm/boot/dts/omap5.dtsi
> > @@ -145,6 +145,41 @@
> >  			#interrupt-cells =3D <1>;
> >  		};
> > =20
> > +		i2c1: i2c@48070000 {
> > +			compatible =3D "ti,omap4-i2c";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			ti,hwmods =3D "i2c1";
>=20
>    Address postfix in the node name and no "reg" property?

that's because of the ti,hwmods attribute. OMAP is still not entirely
converted to DT and there's this weird ti,hwmods attribute. OMAP's hwmod
framework will fill up register addresses, irqs, etc when the device is
created. Oh well...

--=20
balbi

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQH4KTAAoJEIaOsuA1yqREyVoQAKKkTcGy302m5Gam9wnCP0Cb
HXqBoaioUwfiXyV0sM4soLy4P1Q0yULDNzttzsYOhPMSSQx5ewbyh6sa1MJK8qvk
bILOFDE3z6cYdjZQATlo7QcvxpcjSBaD0RxlEsdZBTtNPWN2dIrLmbl1iQy/UVkx
oS4d5aKLj9LQLWjcG2d4FpbLu+oeLMIIF67tY4vr1JXscWoIX3XPZ/98CwmtTUXE
yAL2hkCrX3jFc0FgR7oCNwdfkZ8BPpp3wbN7Mec6dI0cFcmoVU7XdT6tqXnaqtju
p3I6CdDh9cBdMwte5zNFM6OB9Jhr97Xjsu7eQSmcO6O+R/6LtHRliRab52ZIw4ib
h5kfSEEweWA4ypVqpF4z5p9tydkgtNoojdfErLyiPAW1mem7cgQ9ftRHShjBqJko
hlKZH8doQe0ibLRsIXtdP3qugImbk96Fms7U/B0WZ6Ubo9CLWiJL+9/8517qmuYB
50fdoLFMucafW49zoYzpjsGmCGrAMIRHPrXDCr4Z32Us5haOFpDFkR1vdDMHPpqU
ymaFJhwNBOYzi7j3Gf9IH1FFadYOXxzRk/z7RRZ2GGEknut7bV0RoIDZtiXapZT8
Xd5qdyxhs9sNV0DD7ihzriy7RFYYzNTD4zy12oGkdhNk334pFLI3xg4Xtk9hhQxQ
HEWtrI6XeWWKmZ0Jrkp3
=h60n
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============4099113542617135657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4099113542617135657==--
