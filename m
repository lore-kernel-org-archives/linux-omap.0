From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 5/6] HSI: omap_ssi: built omap_ssi and omap_ssi_port into
 one module
Date: Mon, 9 May 2016 22:43:04 +0200
Message-ID: <20160509204304.GA1129@earth>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
 <1461982153-19139-6-git-send-email-sre@kernel.org>
 <20160503173239.GO5995@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160503173239.GO5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 03, 2016 at 10:32:39AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [160429 19:11]:
> > Merge omap_ssi and omap_ssi_port into one module. This
> > fixes problems with module cycle dependencies introduced
> > by future patches.
>=20
> Can you please check against the hardware for the split?

This only merges the kernel modules. There are still
multiple devices.

> For reference, below is what I dumped out from dm3730 for the
> modules on the L4 interconnect:
>=20
> 0x48000000 + 0x40000 + 0x18000 =3D 0x48058000, size 0x1000, parent with s=
ysc
>  0x48000000 + 0x40000 + 0x19000 =3D 0x48059000, size 0x1000, gdd
>  0x48000000 + 0x40000 + 0x1a000 =3D 0x4805a000, size 0x1000, ssi_port1
>  0x48000000 + 0x40000 + 0x1b000 =3D 0x4805b000, size 0x1000, ssi_port2
>=20
> 0x48000000 + 0x40000 + 0x1c000 =3D 0x4805c000, size 0x1000, target agent
>=20
> So the parent target module at 0x48058000 controls everything
> with the sysc register. The gdd, ssi_port1 and ssi_port2 are
> children of the parent target module at 0x48058000 and should
> not have any sysc related registers.
>=20
> Can you please check if gdd, ssi_port1 and ssi_port2 have any
> sysc related registers too? :) If they do, then they too can
> idle on their own but most likely still depend on the parent
> module.

The original driver from Nokia (I don't have proper documentation
[the SSI related parts are censored in the public OMAP TRM]) does
not give hints about any port related SYSC registers. Also it used
just one platform device for the whole ssi module. I'm pretty sure,
that the SSI stuff shares one set of SYSC registers.

> The target agent above is a separate module with the interconnect
> related registers, no need to do anything with that AFAIK.

The target agent is not referenced at all in Nokia's driver.

> I believe this is the same for 34xx too but have not dumped it
> out of the hardware. I can do that if the above does not match
> what you're seeing.

Parent with sysc/gdd/port1/port2 looks familiar.

> If we want to have separate driver modules, you can do this:
>=20
> 1. Have the parent target module at 0x4805800 do PM runtime
>    calls, they then propagate to the hwmod code properly for
>    the ti,hwmods =3D "ssi" entry. This module can be minimal,
>    and can also have child devices within it's first 0x1000
>    sized range if needed.
>
> 2. Have the parent target module probe the child device
>    drivers as needed with of_platform_populate() at the end
>    of it's probe. The children can't be pm_runtime_irq_safe
>    as it permanently blocks the idling of the parent.
>=20
> 3. Have the the parent target module at 0x4805800 implement
>    PM runtime for it's children by registering
>    struct dev_pm_ops for them.
>
> If you really want to have them all as a single module then
> that should work too as long as there's only one set of sysc
> related registers.

AFAIK there is only one set of sysc registers for the whole SSI
module, which must be active if any of the SSI related registers is
accessed. I think we should keep the current structure (ports being
sub-devices of the core), so runtime PM API will just work.

At the moment it does not work because of pm_runtime_irq_safe. I'm
currently working on that (my work-in-progress branch is [0]). With
the changes from this branch runtime PM status looks fine in sysfs
(I have not yet checked if SoC goes to idle if I enable runtime pm
for tty e.t.c.) also there are most likely still some "sleeping
function call from atomic context" bugs.

[0] https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=
=3Druntime-pm-fixes

-- Sebastian

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXMPZVAAoJENju1/PIO/qaJjoP/3I70+rIn+rw3Bl62fpycXzz
KEPbX/JWWtD0yfm8/2zXyF7B41V37PR68Xzpq4SvpZDtbQhzSKWCQWPs6Sw4jmvE
v8rohVzIGhsuzno1LrLaXsARphZWOxavdTORRe/cHi6fQR+8+8vyULWE2GDlKnBD
29sh5UHV8yqOpn7x4CGiVPNecJEGxOr48fPA0GJ6t5udPOQCHNriKlV9dIB3j71Z
weXeRTe9RofpR2CAWzH/ZoLR+GRtrDGv8FXG9iYlfwAOzXSWp/4mx6yN8AQs0q++
tHi86lEsUg9NOlxhGCWjIQlFrcp0fiuyXh/BZYKKI30BqrG+fdgAGNXBZwQnd1d9
L98ZgKkzqXsZ9rZq/f/Ki9WDn3MTAz5oo6WDSnM0Yvd8SdfMCTaFYwzyOUD/v7Vl
fihs42C9ZBSEZ41Dkxm+Zir2/VObnjMoXUOncVHJ3mDRaPZYRg/Up2WBSEnwApxF
xJC5fntXqjKiKSZTvw7+CeymftcgWtZAJW7egQmYmtIS4v6qqW0FKBUE9ipKxyyf
K47d/fSp2ZoDUhQeWtR1Uk4YW/BnF/1DbST5aOf/jeRo4OqPtVQ4garTvLsXY23V
QvWlOVNU52TN6N55ZLChzqB1Vr/RGYz6bl1adzi3ulza5bQmJka0L7P3y9wKJzp0
/0oGy1J8ScchR6E8+RBr
=H40o
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
