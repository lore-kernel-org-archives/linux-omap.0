From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Wed, 2 Oct 2013 23:54:50 +1000
Message-ID: <20131002135450.GH6506@voom.fritz.box>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com>
 <524A8289.3050107@baylibre.com>
 <524ACB76.1010001@gmail.com>
 <524AE4FB.4080906@baylibre.com>
 <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ31TGFJCSeSOqgee=OLVfSUTAYdF4nSn7X2DiCequVAw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 03:54:20PM -0500, Rob Herring wrote:
> On Tue, Oct 1, 2013 at 10:06 AM, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> w=
rote:
> > Hi Rob,
> >
> >
> > On 01/10/2013 15:17, Rob Herring wrote:
> >>
> >> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
> >>>
> >>> + more DT maintainers folks
> >>>
> >>> Hi all,
> >>>
> >>> I know this is mostly boring user space code, but I was expecting a
> >>> little bit of comments about at least the bindings syntax:-(
> >>>
> >>> I'd like to know if this is the right direction and if it worth pursu=
ing
> >>> in that direction.
> >>>
> >>> The idea was to have at least some base for further discussion during
> >>> ARM KS 2013.
> >>>
> >>> I feel alone :-(
> >>>
> >>> If you have any comment, go ahead!
> >>
> >>
> >> Thanks for taking this on!
> >>
> >> This is interesting approach using the dts syntax,
> >
> >
> > Well, this was discussed a little bit on the list, and it has the big
> > advantage of re-using the parser already included in DTC for free.
> > In term or readability, it avoids to re-defining a brand new syntax for
> > people who are already familiar with the DTS one.
> >
> >
> >> but I worry that the
> >> validation will only be as good as the schema written and the review of
> >> the schema.
> >
> >
> > Well, sure, but unfortunately, that will always be the case :-(
> > The bindings definition being quite open, there is no easy way to ensure
> > proper schema / bindings without careful review of the schema. There is=
 no
> > such thing as a free beer... Unfortunately :-)
> >
> >
> >> I think the schema needs to define the binding rather than
> >> define the checks. Then the schema can feed the validation checks.
> >
> >
> >> This format does not seem to me as easily being able to generate
> >> documentation from the schema which I believe is one of the goals.
> >
> >
> > Indeed, but I think is it easy to generate any kind of readable format =
for
> > the documentation purpose if needed from the actual format.
> > Otherwise, we should consider a schema format based on kerneldoc type of
> > syntax to improve readability. I'm just afraid it will become harder th=
en to
> > define complex schema.
> >
> > BTW, what kind of documentation are you expecting here? Is is a text th=
at
> > can be added on top of each schema?
>=20
> I would expect the schema to replace
> Documentation/devicetree/bindings/* over time. I think the thing that
> needs to be worked out here is how to add free form multi-line text.

I'm not convinced that's a realistic goal.  As I see it, the
fundamental difference between a binding document and a formal schema
is that a binding defines both the syntax required of a node, and its
semantics, whereas a schema defines only syntax - the semantics still
need to be defined somewhere.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSTCWqAAoJEGw4ysog2bOS5SsQALuN+AwDGqkTFTAYQ1x0crc9
PGbCaV1khnnwmfV8mvYbbqhEj7E2qVK2KxJznWgq7DUzVpiKnnmoPZFt8oH4nnTU
YgLC/5VbHG/cj6N9+ayt3Vf3riiOXseFfmtCsk9VMERKaiVwHCVJyRzpf9aNaZZQ
au1HH60WqwtVAeEs4x9hSNpjAtIy15h22jxSUxVd31RLT6h5hoOEsQeY4yb+ynj5
0GN52w4J8Ep6lT++60a4UL72a54qhwaW+K9BN+AA7SkjGKnPZWb7aWHttsrEFSv3
YfZryzTTFEqsVjilu51UaV6vp9K+QQSwGxukQPYN4xoXcLtr+0fUtkS0UQwkp+LI
3wlYp0+/hHfpICYGZv0ceDqlbx3Kqa3UFB/7kb5kjy20pVMHfztkuJo8PVxlv3mT
z4OBT0sBhEzfWAuvS7U0+N1RT6pPlpNtSdCuzdLIgcLKv10DpEDWW35TEXeDNfRu
MwFXOn2KHK9J2FPOzD1Oh3eRNWneLWwVwIraa5SvyiybkCusNOVtjH3lyRR11zPy
zQ6OQ5ti/Yfj1JypIygQDbljjHccvGCkDMjQReA8guDbI0J6cRqgnxX4luzwMrFR
JeTm1OrTvzPbdhfXvi0/5H5FCaHSxOiPLrMdh9tP7v23e+8SDn5eTS9Omzzyojk7
bqx/ovg8wfeHVFYIJuDK
=12Nr
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
