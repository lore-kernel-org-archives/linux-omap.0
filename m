From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: ensure writes to dev->buf_len are ordered
Date: Thu, 25 Oct 2012 21:03:40 +0300
Message-ID: <20121025180339.GA18046@arwen.pp.htv.fi>
References: <1351155648-20429-1-git-send-email-balbi@ti.com>
 <8739124idt.fsf@deeprootsystems.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8739124idt.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 09:38:06AM -0700, Kevin Hilman wrote:
> +Paul
>=20
> Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>=20
> > if we allow compiler reorder our writes, we could
> > fall into a situation where dev->buf_len is reset
> > for no apparent reason.
>=20
> Any chance this would help with the bug Paul found with I2C timeouts on
> beagle userspace startup?

I replied to the original thread asking the same ;-)

--=20
balbi

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiX77AAoJEIaOsuA1yqREutMP/2Tj9wYE/fMBxyjsqaLF52T8
2srE5EjiScGGe8hmy8jC8OoRw2MBunyDNGwxwP1To0/gHjZWZHaP9fl+RUt5G7+S
aQCOV8rTBr6lPsxFQIa95BeMiEOmtBHf9diuskwadRjuXfemIKfFTUIFf4vwa9F+
jKLuT6cj3x0H6SCb+lKiBlCojiyrQG5SiILaMe3k9ny8w9VVBenrlb26zL61UAWI
mPiXHYpzLQp9Atx+yv1OMyfHxwCwH/AIyptzxeuZdKpz1kI8QjRXptXbhnBd4FRn
RHzXoUO9pHsye2XQAYhiWCRiWoA4iW5EcprAz78jXSbbzjzvxNzqgO1kP7Oaeja4
TqSLM4SylY5g+HZaZVoZzPyzg/rK6G/aQrnpLUKPcQQou9emO/AKi+UPhHdcbQA/
RDj3+/UqZUe4aiFCGUN0nDaf+XmGT/h40Kt5n6mi2erGA+PqEuNlqHXUJYNILEx4
9U+YfKccmnafVfG+i+gSbIa1mYZ1LQp1sAyWs0PmL0byusEL3AgCsrHWMrUHPlxb
cmFabM7cjqh7MNfE7zbm//hyLwq5xZhutyBOVrfjcPbyAHZYYgEC675XC+1FJ/2F
7pfxc8gIQnF/JaFMAI1BIWNms8ofe/TaTFEuIxQP1VMg2rWcdwiQE+MuHGnD+3Uk
IMVtQzOWrF0TP/3EL4aw
=NhV/
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
