From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for
 DRA7xx based SoCs'
Date: Tue, 30 Jul 2013 18:32:58 +0300
Message-ID: <20130730153138.GA5978@radagast>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast>
 <51F7CB2F.6070705@ti.com>
 <20130730142353.GL28162@radagast>
 <51F7CF6F.6050702@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53795 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab3G3Pde (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 11:33:34 -0400
Content-Disposition: inline
In-Reply-To: <51F7CF6F.6050702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: balbi@ti.com, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, ambresh@ti.com, sourav.poddar@ti.com

--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 30, 2013 at 08:06:31PM +0530, Sricharan R wrote:
> On Tuesday 30 July 2013 07:53 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Tue, Jul 30, 2013 at 07:48:23PM +0530, Sricharan R wrote:
> >> On Tuesday 30 July 2013 06:40 PM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
> >>>> @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
> >>>>  # define soc_is_omap543x()		is_omap543x()
> >>>>  #endif
> >>>> =20
> >>>> +# if defined(CONFIG_SOC_DRA7XX)
> >>>> +# undef soc_is_dra7xx
> >>>> +# undef soc_is_dra75x
> >>>> +# define soc_is_dra7xx()		is_dra7xx()
> >>>> +# define soc_is_dra75x()		is_dra75x()
> >>> since this platform is DT-only, couldn't we just believe DT-data to be
> >>> correct of_machine_is_compatible() ? 2/3 of this patch would be remov=
ed.
> >>>
> >>> I patched this for OMAP5 (compile-tested only, no boards available) a=
nd
> >>> came out with the patch below (still needs to be split):
> >>>
> >>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/oma=
p5-uevm.dts
> >>> index 08b7267..b3136e5 100644
> >>> --- a/arch/arm/boot/dts/omap5-uevm.dts
> >>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> >>> @@ -13,7 +13,7 @@
> >>> =20
> >>>  / {
> >>>  	model =3D "TI OMAP5 uEVM board";
> >>> -	compatible =3D "ti,omap5-uevm", "ti,omap5";
> >>> +	compatible =3D "ti,omap5-uevm", "ti,omap5432-es2.0", "ti,omap5";
> >>> =20
> >>  ok, nice and simpler way.
> >>  But would this make different revisions, to appear the same ?
> > well omap5-uevm is omap5432 es2.0 only, right ? If a new board comes up,
> > it should be treated as such, then you can pass a different string to
> > that new board's compatible attribute.
> >
>  Yes for OMAP5. I was thinking in general about this approach.
>  For example, for OMAP4 we have same board and
>  different revisions can be socketed there.
>=20
>  For OMAP5, this is good.

do we really production socketed boards? Well, at least Blaze has such
thing. But do we have too many differences that need to be trated at
arch/arm or should/could those be handled by reading IP's revision
register (e.g. usb host erratas)

--=20
balbi

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR99yqAAoJEIaOsuA1yqREEm8P/1T2MG8TfBU3XY5XzcFgsaks
Y81+3KmJpon7kBIZqVvfMmjHZRNMOJ291Pm9qehr6s9Hl3KuMC1xORCMG+hCgxiX
7V+yDxlH/iaCDU3emNbv5rEJ4Ly+c2QF63QprJlyu5XDNJxXtas2CLLF5/OmqWE6
1AopSAf1NVOO39JHto2kNr5md5gVyNkQ2+vkVE/Kwmevs43TvORGdLfuxGj0pA5V
52RgDYwSlCEEiqjVGBdX4RVGute0/jeYaL4fwhDyNUpWfA7FOFklHd3zwIfEoTvi
WfL9hVK1xX5yDrqgSFZD9tstbwDJuFhgUnyzgDR2lRm54LfkvUoQBX28flq4X5O+
qjgvOKBjSx0T3EeBht/xaJ5QSD8EqyfFNCYPXNW/hPrZn2usPwRQqi/cSVbgiJJk
sj6OC4xpiJb1I1z2yaNRsi7gXm5c9lPl/gw/YxP6cSVTm5v+WWoqeGHlHbU1btBT
7OdDoxzDYGY17ZotSsojzUYYzgBnQnRMAdi8XJBlil9tf9Vt7PrhcrltpemnniyX
xFyINhWeOoGNATrgNhM2v05hn8euE/G9rpc7JgujxgLrUUSc6RdtxTfpCv4UlLpG
aUTbGde+c/Eb9890EmfnetaEK1U/9nkKWwi40dps1cFo2uePllqepYdmVj02ktB7
mx0gUfe4NWRD/w8DwmBJ
=6QsI
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
