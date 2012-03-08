From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 08 Mar 2012 09:47:16 +0200
Message-ID: <1331192836.2354.7.camel@deskari>
References: <1330966464-28662-1-git-send-email-rob.clark@linaro.org>
	 <1331040371.2059.113.camel@deskari>
	 <CAF6AEGs74aygOjFLKSxmZNoo1YC3yuW4aNqHLGO8bifcAwkjKg@mail.gmail.com>
	 <1331044544.2059.150.camel@deskari>
	 <CABT81PhtXsuy_XL0i+4TV=BScYV9-0nfzys5Gi_-=iiSso0bSQ@mail.gmail.com>
	 <1331121928.4348.28.camel@deskari>
	 <CABT81PiS1b7=4r_S8op9FUoWp+H2xgWYDLpuj1PfD8Ag7r_6Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8Otv5B1jIggxI/iAVrwu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52799 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371Ab2CHHrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 02:47:23 -0500
Received: by lahl5 with SMTP id l5so213325lah.29
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 23:47:20 -0800 (PST)
In-Reply-To: <CABT81PiS1b7=4r_S8op9FUoWp+H2xgWYDLpuj1PfD8Ag7r_6Hw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gross, Andy" <andy.gross@ti.com>
Cc: Rob Clark <rob.clark@linaro.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>


--=-8Otv5B1jIggxI/iAVrwu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-07 at 09:59 -0600, Gross, Andy wrote:
> On Wed, Mar 7, 2012 at 6:05 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> >
> > Does this "DMM has become synonymous" mean that people just started
> > calling TILER DMM, and thus the name has stuck, or are there technical
> > reasons to handle it as DMM in the kernel? If the former, and if TILER
> > is the technically exact name for it, perhaps it would make sense to
> > call it TILER, as that's what (at least I) would be looking for if I
> > read the TRM and try to find the code for the TILER.
> >
> >  Tomi
>=20
> Well the breakdown of the DMM/Tiler kind of goes like this.  The DMM
> defines a set of registers used to manipulate the PAT table that backs
> the address space with physical memory.  The Tiler portion of the DMM
> really just describes the address space that is exposed.  Depending on
> what address range you access, you'll get a different mode of access
> and rotation.  Management of the address space is attributed to the
> Tiler as well and that is where we have managed the address space and
> provided APIs to reserve address space and pin/unpin memory to those
> regions.
>=20
> From a hardware perspective, we need access to the resources provided
> by the DMM so that we can do the PAT programming and that can only be
> gotten from the hwmod entry.  And if you use the hwmod device entry,
> you have to match the name used for that entry.

Ok. Thanks for the detailed explanation =3D).

 Tomi


--=-8Otv5B1jIggxI/iAVrwu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWGQEAAoJEPo9qoy8lh71B+AP/31NkB3RFyg+3R4v/CFJt5K6
KMXc71E/I10Rw4S/CFzgIg+gMraKxvaaYvF0N0rr22VQJxaV8oUxeG1cpR7bWGQV
PDGSBg/oOALPlwIpWKraLN1KzB8wjwgSTiZt1QywkFLkzZp8bEYh//3pO+EdStMb
KAKkyCOGYFLBRIzAA2a9fV2bsYnB/finXF5K9LSpxVJvkSCZCoAj8AwjqHDqyjdG
HcNx2sMO4vpIgb/e/E8ThThXYJrtR7ASxjT8FEgF+4J3eK9WQO8ieslr/EfSFzJi
FjDlGJMnrP2P0OMcPLmqe/pOccskseP67xfVeyNUy1NROism6nxXHJWWwwF55DfA
x9plALp15RoBNnujyboJqiLMsuPe0pLYhvue7wdwFrGpoSDnMKBQbECK8eZJ20Cl
T1HRESOVzfdV//fe7/0YKxUeaeqr9FqOlUz17vzElzdENt0FBKpOZP93QkMn7W77
wxOgMrQJQ/QODomQEqvFL935tdMsuuOx5qlsV/E847OJMCQZjHxZcMtfYk141nvy
ZFM3kwz9Gb1ITRc9UClQyfYHF98SV4/ED+61Wa8vjv/BvIhPtDrA23H99i9vcsP3
xdb/Soj+tG6t2RtAxcGcg9w4QF3kyycP/YEWFiSydpNsFGtErFEVWX03t+bqRnAF
SuvyGYEGQvX7uvUbFdvs
=SuYt
-----END PGP SIGNATURE-----

--=-8Otv5B1jIggxI/iAVrwu--

