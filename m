From: NeilBrown <neilb@suse.de>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sun, 22 Jan 2012 07:46:20 +1100
Message-ID: <20120122074620.2715ce7f@notabene.brown>
References: <1327055619.1921.57.camel@deskari>
	<alpine.DEB.2.00.1201210042030.28153@utopia.booyaka.com>
	<1327161427.1863.5.camel@lappy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/VYo/5+xsl4rkyWod=2g64+5"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56018 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab2AUUqj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Jan 2012 15:46:39 -0500
In-Reply-To: <1327161427.1863.5.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, Joe Woodward <jw@terrafix.co.uk>

--Sig_/VYo/5+xsl4rkyWod=2g64+5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Jan 2012 17:57:07 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
wrote:

> On Sat, 2012-01-21 at 00:47 -0700, Paul Walmsley wrote:
> > On Fri, 20 Jan 2012, Tomi Valkeinen wrote:
> >=20
> > > Third, when I load the DSS modules, I see only ON state increasing for
> > > dss_pwrdm, as it should be. However, I'm getting constant stream of s=
ync
> > > losts from DSS, and the display doesn't basically work at all.
> > >=20
> > > I can see MPU pwrdm going into RET a lot, and if I do "while true; do
> > > echo foo; done", which I presume basically prevents RET for MPU, the
> > > display becomes stable.
> >=20
> > If this particular problem persists after you apply the patch set that =
I=20
> > sent earlier, it suggests that something in the DSS is sensitive to the=
=20
> > amount of time it takes the MPU to wake up and service an interrupt whe=
n=20
> > the MPU powerdomain is in a low-power state.  Total guess, but perhaps =
=20
> > omap_dispc_irq_handler() is getting called after each frame and needs t=
o=20
> > run within a certain bounded time when that happens?
>=20
> No. After the DSS has been configured and started (by the MPU), it runs
> by itself, reading the pixels from the memory displaying them on the
> screen. Only when the user wants to change the configs or the frame, the
> MPU does something. And interrupts are only needed to handle the
> changing of configs or frame data using VSYNCs as the interval. The user
> probably doesn't like it if the VSYNC irq is handled a few seconds
> later, but the DSS HW doesn't care, and functions normally.
>=20
> In this case something is affecting the DSS (clocks? powers?), or the
> memory, or the process of reading the pixels. I really don't see the MPU
> or IRQs affecting this problem, except indirectly.

Which clocks, exactly, are important?

I collected some clock.c tracing while dss was repeatedly complaining about
losing SYNC, and notice that omap_96m_fck was being enabled and disabled in
hardware.
omap_96m_fck is upstream for dss_96m_fck which provides the tv_dac_clk.

Could it be this clock turning on and off which causes the problem?

Thanks,
NeilBrown

--Sig_/VYo/5+xsl4rkyWod=2g64+5
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxskHDnsnt1WYoG5AQLQuhAAmTdtLTAvWdtBTHjTO+t2PVG1OfuA/Hnn
MgI2olOXSnflFCxllJ8Un7z6L0MeHeBVlyQNEnYA4psjr68efHNQgXwL9FznMzxZ
yY94G1Tkdpf1Knli4B2PUtukHpkvQrAgCvpiw+5BToVASdreDhMGbDyq6RNj6+xg
/Hwg2/SDET7RP6oxkp3Ebb8vvjHhx+7S6UR1yPuH/n6HROcx4sK4WPsAOnUP4jWD
Y5NJAXGmKw+9PtwE7W6MCXiKBL/kFOl8fjUEJklkAtE1swRbhTlkT9MEUeaIVsNd
Wh9UfW06kmDtEopi6s+W2wj3ujlFD5o3KMUnpvvvbddVP04JqRy6nstlP3OMTIek
658WdRP+QMAa008OvImBTjkmdBfyCLPjSro7fB6ZFP5Gb9mMMv4KVQo+fkTEurgd
6z9Xamjl5SOrSAKV00Nycgi6OWUvFQ6Fgz/gQlselmZ+4MN4RMWbR2gH31YqeiHO
kVLi62fw89nfpFv6e3Q71ruD3Q4s+likSMKJ7WntXA66nuZhIwHQ9e5nGuUipFpS
91iL0gqGh5Rm0dJNzHKhUlWHcPe2bFymdoGEsuZ0sQfIyBIHeMd7PNdrswxAZI6F
UUZXEUSpYuLrpkZI3u7FuwfvpatkE5J/u1xdlhYADuu4FxfDBLLeigUGPZFE8rNj
t8oHqAwhLBY=
=zhdY
-----END PGP SIGNATURE-----

--Sig_/VYo/5+xsl4rkyWod=2g64+5--
