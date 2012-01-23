From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Mon, 23 Jan 2012 13:06:27 +0200
Message-ID: <1327316787.1916.38.camel@deskari>
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
	 <1327315716.1916.34.camel@deskari>
	 <alpine.DEB.2.00.1201230401170.29673@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-4MhSYcE2grYYhff816id"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:33596 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752363Ab2AWLGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 06:06:32 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id p5so1486800lag.38
        for <linux-omap@vger.kernel.org>; Mon, 23 Jan 2012 03:06:31 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201230401170.29673@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>


--=-4MhSYcE2grYYhff816id
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-23 at 04:02 -0700, Paul Walmsley wrote:
> On Mon, 23 Jan 2012, Tomi Valkeinen wrote:
>=20
> > On Mon, 2012-01-23 at 02:31 -0700, Paul Walmsley wrote:
> >
> > > Want to spin a quick patch for v3.3-rc1 to add it?
> >=20
> > I think there are other bits missing also. CLOCKACTIVITY is missing for
> > DISPC. And DSI doesn't have any SYSC flags defined... I'll try to go
> > through them all.
>=20
> Might be best to do a minimal patch for the 3.3-rc series and stable tree=
s=20
> that just sets the SYSC_HAS_ENAWAKEUP flag?  Then we can queue up a=20
> larger patch to fix the rest of the bits for the 3.4 merge window...

True. But the patch will be slightly larger than just trivial flag
addition, as OMAP2 doesn't have ENWAKEUP, and the current dispc
hwmod_class is shared between OMAP2 and OMAP3.

So I guess I'll split that and add ENWAKEUP to OMAP3's hwmod data.

And regarding clock activity, it seems a flag HWMOD_SET_DEFAULT_CLOCKACT
is also needed before the clockactivity is set to HW. But there's a XXX
comment above it, and I'm not sure what that's about.

 Tomi


--=-4MhSYcE2grYYhff816id
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPHT8zAAoJEPo9qoy8lh71JAwP/2HHEk+jjVJM8UaagO4dyg5D
maZW0hPamgp9hj0OM4v4F5lbPjIWxWR3Q+U2L1Bcx1R7KcexaVhMl9t2sa7Gysy+
TNUvN1ayV8y/7uoCZrmhCWMMn4t7CpddGYYQDQMQH1Pvdfj438TRi+pWYTNv92Qt
Zo9VXnkey+HopSox1n2bo+Yk2DxAEo8DCK4eQbFKjaJ9pVpemJpBw5LOjUtEiV7z
/QwWIj5dEV+RzR/9nk5kPajIEVrYwdNlWGGUlw8G18dqeYNHsbL1zJ1W5qHqQVoh
gigZBEAyBLwErX7kzpYGNJ8cj56e2TRjGElnqalnwAA+b0R0zrt7FKucj+cNri/u
m6TZ3e8cZdNObHwrrLEUSSR/DPaQCTvoqNeaR53qB2ljlKtn7p7Rp9u7clXtHlch
hb6lgDpif0feplXo/L4lsAwhL+dlpy1Q3txcj4g6LKzLHjPA6Nh9g0NJGHqPiILi
NRQB8ZI57imoltECL4HUaCB8S+jRZtzGoA1yUkJNFTRvwOyGxtcRZd7AUrxfkSV2
XqZToYmHR5Zm2Xyl7l9feHF8nucxyMPnHH1IZ6mXyucpUIDZsu8zMkP7JIvVYsT+
Z4Nq/F3wO6RoF4/YMEILWAAhk6ifs3n7fbKqlBBc5g42x+DPrnNI/pRjWaeRN3FX
e3NX9z6djv/HJxIdbbP3
=Z44v
-----END PGP SIGNATURE-----

--=-4MhSYcE2grYYhff816id--

