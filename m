From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Wed, 14 Oct 2015 14:54:53 +0300
Message-ID: <561E428D.4030305@ti.com>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-3-git-send-email-rogerq@ti.com>
 <20151014111939.GB14340@earth> <561E3C1F.5000406@ti.com>
 <20151014113736.GC14340@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HFrbafkpcbxjMNtDC6o3tSkNpaimdLOiL"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151014113736.GC14340@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: tony@atomide.com, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--HFrbafkpcbxjMNtDC6o3tSkNpaimdLOiL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/10/15 14:37, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Oct 14, 2015 at 02:27:27PM +0300, Roger Quadros wrote:
>> On 14/10/15 14:19, Sebastian Reichel wrote:
>>> On Wed, Oct 14, 2015 at 01:44:16PM +0300, Roger Quadros wrote:
>>>> Let's keep the SSI ports disabled in the omap3.dtsi to avoid
>>>> getting the following noise on the console for boards that don't
>>>> use the SSI ports.
>>>>
>>>> "omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (er=
r=3D-2)"
>>>>
>>>> As omap3-n900 uses one SSI port, mark it enabled there.
>>
>> Would it be preferable to disable the ssi-controller node as well in t=
he
>> omap3.dtsi file?
>=20
> If I remember it correctly, existing, but unused IP-Cores
> should not be disabled in DT, so that hwmod picks them up
> for power management.

OK.
>=20
> Note, that it actually is disabled in omap3.dtsi and then enabled in
> omap34xx/omap36xx dts files (the other variants do not have an ssi
> module).

Thanks for the info :)

cheers,
-roger


--HFrbafkpcbxjMNtDC6o3tSkNpaimdLOiL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWHkKNAAoJENJaa9O+djCTAEQP/Au9JZnJTPNJVSw3hVnwzbCq
8twlz4xDnuMJqew+AkdGVwvp3MSv4BV175Fxa0StRk7h1uu9skuY0gKcPFjCtl3j
hnVONqYg0aYHyjZmXCEjix3R7xlnVdrz+md+eN4jKW+tmt6y2Um6RjiyfA7+twLr
7sxAxq37Xd78BYUIKh/40ABcUZ+XXfZPAU7F1j7meo5WXcb7OmmxRFB6a8uLtQy0
CtCoIIIf14qJFqUiIARttkeNCu3L7rgnPIxMwC5ajjEbAS3wKT9d0L+/kGM2cRCt
tM3NZUdLFsxuGnt74p9z4HwWXC5epp0btlHTwLAjo6NBO4g0FfU4qCMOCnVa5Hp/
KYffNo5WloXf7hKOW6sCSS7PNOqqeN3Y+z37gJAaHW07+n49aa4I/DKLQjY9OlSw
6oXDjJZakm2EAAUqVzFxOo/1UQD4d2qKhRfHx2maEk1HqoF5Mrf2Eavb/uHbQ2g6
JTi5D/9/x1CeOvUJQIn8lUEfxX41XCV6zkfTMkByMdd2Yxf2fBJlX9ien1rpmdP/
kyfJeaUTTE24CBBpnOASHmWwJXOgtGMFufsDaZ3ERbxjRE4RWlnmi8sXpCLNkwPe
WwHzg5jD8W99Ft09uBpUyFiOyEFeaZdbB7x8t1EubcClTxByyiHxljfA8Q94MaU1
/S2DJdCogr+fCGFRqCqF
=WcpW
-----END PGP SIGNATURE-----

--HFrbafkpcbxjMNtDC6o3tSkNpaimdLOiL--
