From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 11:04:04 -0500
Message-ID: <20140314160404.GC21379@saruman.home>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com>
 <1394701109-6721-5-git-send-email-sathyap@ti.com>
 <20140313174623.GD25870@e106331-lin.cambridge.arm.com>
 <5321F77E.9000302@ti.com>
 <20140314091002.GG25870@e106331-lin.cambridge.arm.com>
 <5322CF02.4060705@ti.com>
 <20140314101405.GI25870@e106331-lin.cambridge.arm.com>
 <5322D7A4.4090602@ti.com>
 <5322E2D9.5000509@ti.com>
 <20140314140745.GL25870@e106331-lin.cambridge.arm.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36301 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbaCNQF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2014 12:05:59 -0400
Content-Disposition: inline
In-Reply-To: <20140314140745.GL25870@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "balbi@ti.com" <balbi@ti.com>, "av.tikhomirov@samsung.com" <av.tikhomirov@samsung.com>, Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2014 at 02:07:45PM +0000, Mark Rutland wrote:
> On Fri, Mar 14, 2014 at 11:07:05AM +0000, Tomi Valkeinen wrote:
> > On 14/03/14 12:19, Tomi Valkeinen wrote:
> > > On 14/03/14 12:14, Mark Rutland wrote:
> > >=20
> > >> I can't see anything obviously wrong in platform_device_del. Do you =
have
> > >> a backtrace?
> > >=20
> > > Yes, below.
> > >=20
> > > I can see at least drivers/usb/dwc3/dwc3-exynos.c doing the exact sam=
e thing
> > > I do, so maybe I've got something wrong with the omapdss driver.
> >=20
> > Looks to me that the devices created by of_platform_populate() are not
> > unregisterable in all cases. The address resource created via
> > of_platform_populate() had NULL res->parent, which causes
> > release_resource to crash.
>=20
> Hmm. I can't see that unregistering such devices ever works as you say,
> given that __release_resource expects a non-NULL parent pointer. Either
> we should be setting the parent pointer when initialising devices from
> dt or we should teach __release_resource to not care. I'll have a go at
> fixing that.
>=20
> It looks like drivers/usb/dwc3/dwc3-exynos.c only unregisters the
> top-level device, not children. This top-level device has no
> IORESOURCE_{IO,MEM} resources judging by
> arch/arm/boot/dts/exynos5250.dtsi, which would explain why that driver
> isn't exploding: __release_resource will never get called.
>=20
> Anton, Felipe:=20
>=20
> Does unregistering the parent ensure the children get cleaned up, or
> does it leave them dangling in the dwc3-exynos driver?

you should platform_device_unregister() for each children and
dwc3-exynos does that just fine:

167 static int dwc3_exynos_remove(struct platform_device *pdev)
168 {
169         struct dwc3_exynos      *exynos =3D platform_get_drvdata(pdev);
170=20
171         device_for_each_child(&pdev->dev, NULL, dwc3_exynos_remove_chil=
d);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^

172         platform_device_unregister(exynos->usb2_phy);
173         platform_device_unregister(exynos->usb3_phy);
174=20
175         clk_disable_unprepare(exynos->clk);
176=20
177         return 0;
178 }

for each child of this device, we call dwc3_exynos_remove_child(), which
will:


94 static int dwc3_exynos_remove_child(struct device *dev, void *unused)
95 {
96         struct platform_device *pdev =3D to_platform_device(dev);
97=20
98         platform_device_unregister(pdev);
99=20
100        return 0;
101 }

--=20
balbi

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTIyhzAAoJEIaOsuA1yqREosIP/RwYpjlVMGgpdQWKU54b+ARZ
ON37J9TL97/gjImKa7otV+whGvPA7nvcV5sCu4rA4SH4oi+O+8vihu5bgeR/r2Zy
VmgSVuHYFsIDr4zp7ZZLSnLpiG0SIdgRkpskCVfk1oYczlKQ8ZkVDb9CPqVhqQXs
7wb490S8H8WLvW/hosojIZ3ptAyl1PqqLGQ154sccqrToqM8auzCo/oTvAXWRmbP
RU1W1l8aA2tBy5UED9INb8GD+YZefJqu4XLabmRO50wRiiTKEFHzcm96lHlJQIOQ
fDxYrJuhJfOMULF5BYO/XuiFFhPxDynFytTwZlpCgbtID4faqmitE9UJMRqM1dHe
4/oQhco+WyTWqzIy8neSKhpe43JOTqfCKFCAlSlfx2y2RRMnkicFrbnz1aEumQ3L
pAsxBG3dCHHE8JcBqDLo6PVrRMXNhrE//HaAqAMQeKc5qMS3kNVSE4RLiTQRiK2g
qDavJaPF9SFhXL5/f2+hhYdIMtGGduTk/MqDyhWVpXLUtp5rA0gNAE5q1QzEfWwF
Z7kWRjdC52n8is3Vn+y0lSRhhdoKdolYdL4JKTNiOsU/K8cnbQuC6VWErmOdjJCF
jnucZlhZbGuGAd6P5/iGBwtP7hT0ZjTl/IKR94Q6ksdo8blGOMTLxY7EK6F24P2g
YuK6KQKAhT9H2wtGQebn
=NZR3
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
