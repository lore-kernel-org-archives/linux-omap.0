From: Felipe Balbi <balbi@ti.com>
Subject: Re: Queueing b0a688ddcc50 "usb: musb: cppi41: allow it to work
 again" for -stable
Date: Fri, 2 Oct 2015 12:24:08 -0500
Message-ID: <20151002172408.GJ5552@saruman.tx.rr.com>
References: <CAAEAJfC7z=dvw_5vgXDBWVQdKA5jDpfECYv4Jy67YaT7219uJA@mail.gmail.com>
 <20151002160902.GF5552@saruman.tx.rr.com>
 <CAAEAJfALjV2BCJwzd20TQA3CWa1VZRM5vPv6CydrBuMJc=vVAw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfALjV2BCJwzd20TQA3CWa1VZRM5vPv6CydrBuMJc=vVAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2015 at 02:16:50PM -0300, Ezequiel Garcia wrote:
> On 2 October 2015 at 13:09, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Oct 02, 2015 at 02:23:45AM -0300, Ezequiel Garcia wrote:
> >> Hello,
> >>
> >> Commit b0a688ddcc50 "usb: musb: cppi41: allow it to work again" seems
> >> to fix a regression. It applies cleanly on v4.1 and removes the
> >> "musb-hdrc musb-hdrc.1.auto: Need DT for the DMA engine." error.
> >>
> >> Any chance you can queue it for -stable?
> >
> > Have a look at Documentation/stable_kernel_rules.txt, you can do a prop=
er
> > request for Greg and he will make sure it gets there.
> >
>=20
> Sure, I will.
>=20
> Maybe next time you could add a Cc: stable to these kinds of fixes, along=
 with
> a proper Fixes tag, so the -stable folks can pick them automatically.

I usually do, in this case, nobody had complained about this board in any s=
table
kernel so I just didn't.

--=20
balbi

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDr24AAoJEIaOsuA1yqREkN4P/R0/jOmskmdSBY7W6ntztvM7
L2MY7BEGkREnk7sDbIwU5/xcaC5Iq6D6aA7irudWKuEe6ytWZaQkiWSkhMfcm4LR
EM3EY7YJENIM/Ctfk2YhZUkQL65oApZcfl+F8qGlNr1fv8YwtRplX104m2cLuHwQ
x78mUAcVPH4sNinvXsIWo/mZFz2N6Fd5NH2PRQlUnYNko/krEkSoPeB8xSKIt36a
yv7KInodRR0DBbuRxh/45zfQEQEhzyH+D47Uh9dN7CbLS/fkvILS0PBzCMDjyxJy
OzidyVHbmZMDrFZO6H3SvJeclZJfIe5HywwMUw1L3YVk+QK7H3XyYxXdgNHYFmxO
90eniEQej6xuocFCeBg82MduEJgTtXcRhl96Lsde8rVsdDVlF1ldiIAZjVJf4jnG
wiEmoCbNk4NYswq6YFYRNh2m4xQHYmPHiw47nAdl9HT4PDGvgTxYYdKaUFUyc59W
Wr6/f6j1CYndQVf9xRGRJbpg372kEY+XrrOv/JAX+PzqFYRP0PSY+5VTXggxKUz6
qZlN2oSjGfv5CcHCiph10YKP+Yq1bTPVLrG8o/JDLi1ECELoFaUH8UcrfaUCKC7l
bHCgRuM8TC7nPSDN1znPfMQulP9FYk5DUfpn+/mwU5THF8z4hkil3f7gTkq9/wXA
s+sJoa4/HO59zgztNpux
=dKwY
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--
