From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Sun, 22 Jan 2012 22:30:14 +1100
Message-ID: <20120122223014.45147577@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
	<20120114100915.01c96727@notabene.brown>
	<20120118082410.48262777@notabene.brown>
	<alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/QAGw4x/0UCJ4sllTjqZxTTl"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47622 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab2AVLaa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Jan 2012 06:30:30 -0500
In-Reply-To: <alpine.DEB.2.00.1201211704430.26641@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

--Sig_/QAGw4x/0UCJ4sllTjqZxTTl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Jan 2012 17:07:18 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> On Wed, 18 Jan 2012, NeilBrown wrote:
>=20
> > Oh - another thing.
> > Sometimes during early boot I get:
> >=20
> > [    0.158447] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_f=
ck.
> > [    0.176879] omap_hwmod: hdq: softreset failed (waited 10000 usec)
>=20
> This latter bug just got fixed, it's updated in the new HDQ series that I=
=20
> sent out:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D132719073710874&w=3D2
>=20
> BTW, if you could give that a spin for us at some point, it would be=20
> greatly appreciated; I don't think I have a board with a 1-wire device on=
=20
> it (at least, not that I know of).

I'll try them against 3.2 tomorrow.  I'll be a while longer before I move up
to 3.3-rc but when I do I'll try to test there too.

Thanks,
NeilBrown

--Sig_/QAGw4x/0UCJ4sllTjqZxTTl
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxvzRjnsnt1WYoG5AQI3VxAAuTjTUHR8/wN0KoWQI+DsVtgIJwNVB6Zy
RQHdfGm4b/llU5HoxcT6dlgYa9Uc49QoO4kqGd9MYmFGJCKbc+1tdAGvY+14MWLo
Ni8u+4K6OotMv/u7gsFgyAXotaQuPTk/H/WFbM/uooyIZpivXCVisF/TA55a/tV1
oJQj3Wu1jyB/y6tyZVYOxfQ/eYQq66zcOqkgoyDo12s5v+Z74W5sdOsMbrbB4OaM
x3NDc7/Wt6ZiXl2JoS9H6tMlYEus6PAySrdW6zFc4j+4ZSYsHmWfYu+D2VRbIhKl
FTbISNF4KPCLQhNbMTOUTFrtUNY+7BIfIX3yfxRXI4QP+G8G/NU/mxnTQ7XEIW6O
emA04Cr2YU+CSYiSubQQ9ABbAIhnFdFs/OIsHjWhrITfiDWfmUQPs9DWfIzWWTIt
IBH3nQIimbZdppGu6S4CgVW/nhpNPEsoUzQ1xRmX9j95xqBVlxPhpAUzCTKPWvpV
h0qX/vWHbTu78tD5yyoxj02XIgQsw6XQhkA4V0DiyZloeQ/sEDo5DNC1VHlsik27
WxBVgWxa0OHNAOWUNrvlC1KIhaoBam/zMhACCUO+BW9fDh2hLH+uavNssCtdobW4
ce4UTuA/acUX/Ezopq8gCY98eSS3EIHJe6GRvYmkhTJh3BwnuKTynJHLKlYpWmmb
o+FPzy7BN9c=
=eo3M
-----END PGP SIGNATURE-----

--Sig_/QAGw4x/0UCJ4sllTjqZxTTl--
