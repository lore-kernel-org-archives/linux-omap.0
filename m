From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Tue, 10 Sep 2019 18:39:06 +0200
Message-ID: <20190910163906.ypyeaido6h4nurvv@pali>
References: <20190828150037.2640-1-aford173@gmail.com>
 <20190905230443.GA52127@atomide.com>
 <CAHCN7xL0fbr=Sv+b=0AuGB1PPhAAFdAFLEd_iBM+ZMTkUw5sHQ@mail.gmail.com>
 <CAHCN7xL-Gfxe0qF5w7BUsHnyhcNNpmCnchdKErnmiqggXfsLWw@mail.gmail.com>
 <20190909134033.s26eiurpat3iekse@pali>
 <20190909163543.GQ52127@atomide.com>
 <CAHCN7x+t-OVRE7pVM4V87_YMWpgO+_Vashfn1s5msoqC5eiwTg@mail.gmail.com>
 <CAHCN7xLaGQMM67VC-2_G8XC7UuG4c+TbbYb4z=ibJwZsQF4YVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v7pe77r44rvnt7o5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xLaGQMM67VC-2_G8XC7UuG4c+TbbYb4z=ibJwZsQF4YVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <adam.ford@logicpd.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--v7pe77r44rvnt7o5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 10 September 2019 11:21:34 Adam Ford wrote:
> According to a note in omap_hwmod_3xxx_data.c,
>=20
> /*
>  * Apparently the SHA/MD5 and AES accelerator IP blocks are
>  * only present on some AM35xx chips, and no one knows which
>  * ones.  See
>  * http://www.spinics.net/lists/arm-kernel/msg215466.html So
>  * if you need these IP blocks on an AM35xx, try uncommenting
>  * the following lines.
>  */
>=20
> I decided to uncomment the hwmod entries, and I got the following:
>=20
> [    0.263222] omap_hwmod: sham: _wait_target_ready failed: -16
> [    0.263248] omap_hwmod: sham: cannot be enabled for reset (3)
> [    0.265837] omap_hwmod: aes: _wait_target_ready failed: -16
> [    0.265851] omap_hwmod: aes: cannot be enabled for reset (3)
> [    6.208866] omap_hwmod: sham: _wait_target_ready failed: -16
> [    6.287732] omap_hwmod: aes: _wait_target_ready failed: -16

Hi! Same errors I got in qemu-n900, but not on real N900. So I guess
those errors means that IP blocks are not present.

> Based on this, I wonder if the sham and aes modules are not present.
> If this is the case, it might explain why I cannot use the rng either.

Probably this is the reason, you do not have crypto/rng HW engine.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--v7pe77r44rvnt7o5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXXfRqAAKCRCL8Mk9A+RD
UvMwAKC5PytcObjM5hlbkUO3+dfjWZwPBQCffPh8UWUkmuzDbXQs1ybxGZqap80=
=Gd7N
-----END PGP SIGNATURE-----

--v7pe77r44rvnt7o5--
