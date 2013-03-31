From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] OMAP3 ROM Random Number Generator support
Date: Sun, 31 Mar 2013 14:43:11 +0200
Message-ID: <201303311443.12125@pali>
References: <2059303614.30062.1364731542427.JavaMail.apache@mail83.abv.bg>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2831846.TbbXrWxZaK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2059303614.30062.1364731542427.JavaMail.apache@mail83.abv.bg>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?b?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>
Cc: tony@atomide.com, juha.yrjola@solidboot.com, linux@arm.linux.org.uk, mpm@selenic.com, herbert@gondor.apana.org.au, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart2831846.TbbXrWxZaK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 31 March 2013 14:05:42 =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=
=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
> Hi Pali,
>=20
> Yep, the code looks almost identical, I guess with some tweaks
> all SMC code from that patch could be removed and instead
> used the one from SMC PPA API.
>=20
> What I don't get, is why one needs to disable/enable
> fiqs/irqs:
>=20
> +static int call_sec_rom(u32 appl_id, u32 proc_id, u32 flag,
> ...) +{
> +	va_list ap;
> +	u32 ret;
> +	u32 val;
> +
> +	va_start(ap, flag);
> +	val =3D *(u32 *) &ap;
> +	local_irq_disable();
> +	local_fiq_disable();
> +	ret =3D omap3_rom_rng_call(appl_id, proc_id, flag,
> +				 (u32) virt_to_phys((void *) val));
> +	local_fiq_enable();
> +	local_irq_enable();
> +	va_end(ap);
> +
> +	return ret;
> +}
>=20
> Do you have any idea why is that needed? Any other code I've
> ever seen to call SM, does not disable fiqs/irqs, is RNG SMC
> somehow special? I know this is Nokia's code, but still, if
> we can get some understanding...
>=20
> Regards,
> Ivo

This driver is written by Juha Yrjola and is part of maemo 2.6.28 kernel.

Juha Yrjola, are you still around?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2831846.TbbXrWxZaK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlFYL2AACgkQi/DJPQPkQ1K7KACeOf+zrmtEzeyQsJr8BUcjdwWp
q9sAnRFago104DcxSKZBQtsZaHqgUXin
=fiqf
-----END PGP SIGNATURE-----

--nextPart2831846.TbbXrWxZaK--
