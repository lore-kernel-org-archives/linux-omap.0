From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
Date: Mon, 30 Apr 2018 11:29:47 +0200
Message-ID: <20180430092947.GC2270@ulmo>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Michal Simek <michal.simek@xilinx.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 11:03:25AM +0200, Linus Walleij wrote:
> On Thu, Apr 19, 2018 at 5:14 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> > On 04/19/2018 09:05 AM, Wolfram Sang wrote:
> >>
> >> We should get drvdata from struct device directly. Going via
> >> platform_device is an unneeded step back and forth.
> >>
> >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> ---
> >>
> >> Build tested only. buildbot is happy. Please apply individually.
> >
> >
> > for gpio-omap.c:
> > Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
>=20
> Hm I only see the responses not the actual patch, I guess I will find it
> sooner or later.
>=20
> Wolfram: if I don't find it, poke me with something sharp so I get to app=
ly it.

I had the same problem, turned out this got classified as spam by Google
for some reason. Maybe try your spam folder?

Thierry

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm4gsACgkQ3SOs138+
s6E+/Q/9EjphqdxUrnsFSD+/mR1PWKT+wgaYut4Zt8pP0aPfTRABNwbDutpCoz/w
PTdquuAzoziVhHWLZFYyqEfug3/gB/4rHfl9UspVMirZlLjL/CJCGag79Df2oENl
C6Q43ql8C5GfosbgL17xjZ5YkboZbPWmbaiODae3XOTRc3EDwCPiw1yn5xFiQxRG
h16gu6kwhXDoipAXN5ljenWF2QkL1av5/7lY01n6NVtIOMg5ercIfx50NofCPpoi
eniMXrWziPcryMq2u8e6rZKERXq+iZAMfZSr9s+NDsVrESPDkRM2PiCtRtCKH34g
UYKK1pG7BikpaQmZKmBllMQ3fPKzsWVdhirioYwv5igTBJ4egwgmnjdjhHq8MOOd
TV1YAjxFen0gAUTCo2MPUEvN3khqUY3xi0dnOgZOF64Q6D+ZHGltdCZcB5PdL2xE
qLJ2CDGPxCk9fWI2oCVsZXjzc9T4l06baKF2dcxLdTyoCgB4ru3R4eV7V2CuRnnu
/0IqZ1wRTWH9GW2VrmD+/CWJqSgknhWRwBVPQaZT87hfWMZC7xmRqAC+cK/OdBX/
uadYQvwvLJBc3BsjtljiqzvvV8FwoXlhkVt0OPIARKCnBJtenbJfOMwewdVKjvVW
42PBcd6qBelFBrohpOO3eQ967KJG+Z8c/NkrZ6t0JF8i4GaBT4o=
=odoW
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
