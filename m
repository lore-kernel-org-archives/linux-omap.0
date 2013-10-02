From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Wed, 2 Oct 2013 23:52:21 +1000
Message-ID: <20131002135220.GG6506@voom.fritz.box>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com>
 <524ACB76.1010001@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <524ACB76.1010001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 08:17:42AM -0500, Rob Herring wrote:
> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
> > + more DT maintainers folks
> >=20
> > Hi all,
> >=20
> > I know this is mostly boring user space code, but I was expecting a
> > little bit of comments about at least the bindings syntax:-(
> >=20
> > I'd like to know if this is the right direction and if it worth pursuing
> > in that direction.
> >=20
> > The idea was to have at least some base for further discussion during
> > ARM KS 2013.
> >=20
> > I feel alone :-(
> >=20
> > If you have any comment, go ahead!
>=20
> Thanks for taking this on!
>=20
> This is interesting approach using the dts syntax, but I worry that the
> validation will only be as good as the schema written and the review of
> the schema. I think the schema needs to define the binding rather than
> define the checks. Then the schema can feed the validation checks. This
> format does not seem to me as easily being able to generate
> documentation from the schema which I believe is one of the goals. I for
> one don't care to review the documentation and the schema for every bindi=
ng.

Hrm.  I'm less optimistic about entirely replacing human-readable
bindings with machine-readable schemas.  But I do think the schema
language needs to be substantially more flexible than the draft
presented here.

While I think a schema syntax which mirrors dts syntax makes a lot of
sense, actually defining schemas as "device" trees doesn't seem quite
right to me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSTCUUAAoJEGw4ysog2bOSMHsQAMoEJGAKVPIsZfJm81yoBJMe
tvhZq9RwXnyIe3+0AGGrcFO9y9UXZVbk7MlZg9ufVpo82Rlh2M55IYVkuMTYM0Y7
RifhjyQ6+YN6fohqV/ASNcnSyVeBitZ39R1kn7VVa/bRk3GDUN2jcYs6PLe852Kx
w9cB1XCo5uVZgKe4kMJSHwTXjqgpT+AcdsVxCramZFoaq6RgfcFOUE5+CtbY3d9u
0rRlq6Ni0CKaxZ+IABn6zv3tQ0/g+xuA9GJtU59L5u8w0T2gAv+7117iv7qJEAJ9
stQ5sNzrk3+l0JR6zsg9VsbwioAHVBgVLNnyQuULheYKjEAXLkgVybm5QGtJnL5H
hNylrLfA2VyZ0Zim4EtgbkTI5WC2RVR4062dh7ODbIEqcWu3pZx8zJH8HJsx2ML+
5YmnrUsCiEVTbOj/aKsWLfHQgiS3mFrN1zdm7HUOLJvo9IleVkPRxgGiGFn6sybg
JpTyxCkzBeMi+E6GL4ais1xl+g5Y5alNwV0CqZdQoUUcr4Zpytzn53v+f30UvBuE
fW7qC5tfa9B+t9NyJm0StbzYW1FOIV7RsA0u7S+7SgVnnWbROxGfpEFGo+kORajq
wXIzpSmUW4U7HG5FC3r/apC82VYNyXssZIJRzGhxRhXuDm5KptPQ33/dDhVwtzsb
FQaHFEUywmiqySUwbo9J
=bQFN
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
