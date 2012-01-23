From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Mon, 23 Jan 2012 12:48:36 +0200
Message-ID: <1327315716.1916.34.camel@deskari>
References: <1327055619.1921.57.camel@deskari>
	 <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	 <1327060886.1921.63.camel@deskari>
	 <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
	 <1327063256.1921.68.camel@deskari>
	 <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
	 <1327071609.1921.82.camel@deskari> <20120122221132.32bd4d44@notabene.brown>
	 <1327308790.1916.30.camel@deskari>
	 <alpine.DEB.2.00.1201230154430.29673@utopia.booyaka.com>
	 <1327310656.1916.31.camel@deskari>
	 <alpine.DEB.2.00.1201230229220.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-wRtsNBMLEepyKlN8IFLp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39974 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753008Ab2AWKsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 05:48:42 -0500
Received: by lags15 with SMTP id s15so1563188lag.20
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 02:48:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201230229220.29673@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>


--=-wRtsNBMLEepyKlN8IFLp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-23 at 02:31 -0700, Paul Walmsley wrote:
> On Mon, 23 Jan 2012, Tomi Valkeinen wrote:
>=20
> > On Mon, 2012-01-23 at 02:04 -0700, Paul Walmsley wrote:
> > > On Mon, 23 Jan 2012, Tomi Valkeinen wrote:
> > >=20
> > > > Then I noticed that the DISPC's ENWAKEUP is not set. Setting ENWAKE=
UP
> > > > (with SIDLEMODE/IDLEMODE in smart mode) also removes the problem.
> > >=20
> > > Sounds like you've nailed it.
> > >=20
> > > What is perplexing is that the hwmod code should be setting this by=
=20
> > > default in omap_hwmod.c:_enable_sysc().  I wonder why that is not=20
> > > happening.
> >=20
> > It seems the omap2_dispc_sysc is missing SYSC_HAS_ENAWAKEUP. I wonder i=
f
> > that's a mistake or by purpose...
>=20
> That's almost certainly a mistake.  It's documented in the 34xx vZR TRM=
=20
> and so far I don't know of any reason for omitting any of those bits.
>=20
> I just searched my linux-omap folder for the original patch for this.  It=
=20
> seems to be
>=20
> Date: Mon, 3 Jan 2011 18:20:53 +0530
> From: Guruswamy Senthilvadivu <svadivu@ti.com>
> Subject: [PATCH v3 01/17] OMAP2420: hwmod data: add DSS DISPC RFBI VENC
>=20
> and it was missing in that patch.  Guess I missed it when I reviewed this=
=20
> patch.  Sigh...
>=20
> Want to spin a quick patch for v3.3-rc1 to add it?

I think there are other bits missing also. CLOCKACTIVITY is missing for
DISPC. And DSI doesn't have any SYSC flags defined... I'll try to go
through them all.

 Tomi


--=-wRtsNBMLEepyKlN8IFLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPHTsEAAoJEPo9qoy8lh71oNcP/iGWulrhTxf20ERazG50nwP9
W9JQfyFDf8MzuytMoPSpypI87oRPJfL/tgw0ajVq8xJq258+QGpYfRUxwEY/8BOs
gb5lc6fHW+z8fexKfl4mkNXE23Q2eD6mg3mfv/MeOOv1IezTJa2v1lF1U1aSh4y8
fjqvh3/OYBfyBl3qf3YW0aTa57W0okY8wz+bqS/Yrfsufq/DAuEvPb84uoJaVpyL
9IsJmq15te4T32fXFMVM6h8rH9BLOakB7kEh/HRdGXnKq7x+2Ceg71AisCBnqWDV
Z1cEDe4GJqdJDRjEQjGkrOvukphKOCxFIQS+laCXM6640rS9uT9efKr76geQZV4j
BASkjj8F5OMXhW3OKGJ8VxCH8a6hwi2DZYgwDt1N/jlSRGfx0iTNGUKFH7BnqVoS
VBFz1S/I3KL9yWuxt7Or/zN1nvEOBl6UQhmtLrzbajEu/o5QiCSZs1njO6StZBMj
x4v04Uj3a1YZCaCUK2L38gu2GC/zD5YfwuHevJJkkyTEIzjMI+8UWWUSUtZL2HiQ
3xdR3A5/Y7hkepviDAk0FFTG7qhhGzDzwHT4M3XP2XRLdLQUDBl3tUYeAbzfe7Ra
6uRlDYw9CCrmCubDgkkhfUEnvXMrneuArawG7TwkMCqXmtKu6lr1zWbFFxdHJp+2
swL/roF1D+kP1sQ8jOXr
=8xZY
-----END PGP SIGNATURE-----

--=-wRtsNBMLEepyKlN8IFLp--

