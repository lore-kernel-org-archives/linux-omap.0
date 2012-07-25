From: NeilBrown <neilb@suse.de>
Subject: Re: bisected regression: arm: omap3: voltage: fix channel
 configuration
Date: Wed, 25 Jul 2012 11:47:42 +1000
Message-ID: <20120725114742.30e25e31@notabene.brown>
References: <20120723210635.25e0a0d8@notabene.brown>
	<1343053494.30247.22.camel@sokoban>
	<20120724113057.5f38806e@notabene.brown>
	<1343111304.30247.43.camel@sokoban>
	<20120724173453.01078466@notabene.brown>
	<1343119876.30247.49.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Qel0lP9dP=tvlD6.o1YvT0v"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47303 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326Ab2GYBr5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jul 2012 21:47:57 -0400
In-Reply-To: <1343119876.30247.49.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

--Sig_/Qel0lP9dP=tvlD6.o1YvT0v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jul 2012 11:51:16 +0300 Tero Kristo <t-kristo@ti.com> wrote:

> On Tue, 2012-07-24 at 17:34 +1000, NeilBrown wrote:
> > On Tue, 24 Jul 2012 09:28:24 +0300 Tero Kristo <t-kristo@ti.com> wrote:
> >=20
> > > On Tue, 2012-07-24 at 11:30 +1000, NeilBrown wrote:
> >=20
> > > > Might there be some way to get it to scale higher than 600MHz?
> > > > The first message from U-boot says:
> > > >=20
> > > > OMAP3630/3730-GP ES2.1, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> > > >=20
> > > > and the board manufacturer thinks it should be capable of 800MHz.
> > >=20
> > > You need to enable 800MHz OPP similarly to what is done in=20
> > > beagle_opp_init() in board-omap3beagle.c. I am not sure what your boa=
rd
> > > is detected as, depends on your boot loader (check /proc/cpuinfo.)
> >=20
> > Thanks!
> > Yes, my board identifies as cpu_is_omap3630() so that code looks releva=
nt.
> > I copied the opp_init across to my board file, it runs without complain=
ing
> > but it now gets to
> >=20
> > [ ok ] Loading cpufreq kernel modules...done (none).
> > [....] CPUFreq Utilities: Setting ondemand CPUFreq governor...CPU0...
> >=20
> >=20
> > and hangs.  magic SYSRQ doesn't respond.
> >=20
> > Any hints?
>=20
> You only enabled opp for 800MHz right? I am just wondering if the
> voltage levels for mpu / core opps are correct for your board... You may
> want to check the opp tables against the information provided by your
> board manufacturer. The trace about cpufreq enabling ondemand governor
> indicates it is switching to frequency throttling mode at that point, so
> it most likely tries to raise MPU frequency to 800MHz (CPU load is
> pretty high during boot.) You can try adding some trace to cpufreq
> driver itself to see what is happening.

Yes, just 800MHz.  I just copied the code from board-omap3beagle.c, so
it is actually 800MHz for MPU and 660MHz for IVA.

I tried running with that and with your patch reverted and it works
perfectly.  I even get 33% better speed on CPU-intensive workloads, so it
really is running at 800MHz.

>=20
> Another thing to verify would be to check the voltage rails on your
> board schematics to see how the supply voltages are delivered.

I have a basic understanding of the schematics, but I don't really know what
to look for when it comes to power routing.
If you happen to have time and interest, the schematics are in the manual
that can be downloaded from=20

    http://projects.goldelico.com/p/gta04-main/downloads/

I've got the GTA04A3, so GTA04A3-1-complete.pdf is the one you want.

Thanks,
NeilBrown

--Sig_/Qel0lP9dP=tvlD6.o1YvT0v
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBUA9QPjnsnt1WYoG5AQLy7w/+Ih2hI8IDs+X1KR3PpJTEO/WSF2d97/ld
EvvpSXyMBHPjy4f0/J9lKPeK/9pAUWPI+nz2zosKBBkBmUg2Sa9/wzBVJGBiV+WO
6GeIPVDFa1GsKLZhTLQAdH+iittt+kGlFDBO3JZp2NCVU1QGpaQNKWZbL5oB4kyk
V0xxgcQHWTO/TRN6pslyTPnKwsq6jHAs6ofMz7WV6YLoOpc73pfxH7Zo/Hw67qMo
D/3bbCEWe33Abupc0AvMrR9HH+xM1n1gZseO/6uhb/UIlmwM4gs7Dgqmj9rnnIsC
NcWXGXAFXgYwGHKEJ0+z1nNu5dyvK/T99JEbJLMtn+AmQqqosiMxkVXtKSBa5C1t
4uqgeMhSvDcIKbQgdZO4ZOrosOm/OW+R2hG/auvJ0lf//0idjGL7WS6qejc4pIqI
fBeQGToLu/MMni+G1xrCaQgfb1NJEiITntlmKqPz7Ukt8FzJPRXekwN4czQ2XLbb
K+l+RR38//ewwv3RzGFPP1n7RUsmzc5v/9g5r+gje7ysm+XmdRmKeXf/f/K6VUtc
NuMl2xzh1XPsPK1vO0nt4gFPWq78EH++ABaUY/l3fcEAXdUqbHpP766AnKIUlyPV
H+wsUV05RY24S5Y+WydA9dJpWp3KpkCs6WDYew1eRJVBtKUrla7hbp0mNll6xV9i
s48hKyM1ofE=
=Y01l
-----END PGP SIGNATURE-----

--Sig_/Qel0lP9dP=tvlD6.o1YvT0v--
