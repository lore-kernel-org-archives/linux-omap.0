From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Wed, 14 Oct 2015 13:37:36 +0200
Message-ID: <20151014113736.GC14340@earth>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-3-git-send-email-rogerq@ti.com>
 <20151014111939.GB14340@earth>
 <561E3C1F.5000406@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <561E3C1F.5000406@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Oct 14, 2015 at 02:27:27PM +0300, Roger Quadros wrote:
> On 14/10/15 14:19, Sebastian Reichel wrote:
> > On Wed, Oct 14, 2015 at 01:44:16PM +0300, Roger Quadros wrote:
> >> Let's keep the SSI ports disabled in the omap3.dtsi to avoid
> >> getting the following noise on the console for boards that don't
> >> use the SSI ports.
> >>
> >> "omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (err=-2)"
> >>
> >> As omap3-n900 uses one SSI port, mark it enabled there.
>
> Would it be preferable to disable the ssi-controller node as well in the
> omap3.dtsi file?

If I remember it correctly, existing, but unused IP-Cores
should not be disabled in DT, so that hwmod picks them up
for power management.

Note, that it actually is disabled in omap3.dtsi and then enabled in
omap34xx/omap36xx dts files (the other variants do not have an ssi
module).

-- Sebastian

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWHj59AAoJENju1/PIO/qaLssP+wXsidTzLx59MqAxfNnl0Z6D
1ctBIelecp98W7yy9hPJ6UtsXWVgUSERVhsg5tYlhxMAvIFhi0lYLXjbnqX5EzW/
hcdzQ0cGxIsfmVOizBRP/LWl4kq/J8cMP+ncQJeQOp93vsxUT8eaEG9vIcABp7tQ
JLjy9pF6Bt18xqQ4AOjJdn0HE7JyxQNMLiaE6i1p2MgXxtqXtYB0OMFRqN4Q13Q+
X6kWU+uXlHg8zYJCP+Ph4elnj5JBNLlO1MX15/NtT9UEYQkHXnhRBz1ls7907TjF
adAipcGn71Ux5fQdvy984o3Q6R+SuXNl8Tz7QT3gdUHhGzfWLVBWb1ITd2+bS06W
40JWUDznptxAuGhbopAhoU+2bNkSZlzHM77SREomHFrn1nt+NJVBloQmBm+RxGf4
vFQFFI4IcoxTN8nW1udct16xHpCYUWUPMyCbvIc8OjnxXDALpeLxHP0lftynWbLp
lqtb3A9wpCgn/r12letCuul9SAg87X0/29cOLQhDooEatTpBdqizVSEvE5Hg3vIY
7hqX6bcJVYQxyKW8cikKLO/s7JTQb2Yy66O2yjWOme8ODLjoDUemS2XiQSzVvKOC
IsugvOrjOK0KGRQcDjIPYrgbzJFPYg8vhTwyY1C7Cgs+bkS+BS5g6ggUr/ESEi1J
UeQuPthzq7ml2raWmtfu
=xnFE
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
