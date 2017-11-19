From: Sebastian Reichel <sre@kernel.org>
Subject: Re: bh1770 hacks: get it to work on n950
Date: Sun, 19 Nov 2017 22:10:02 +0100
Message-ID: <20171119211002.gddsvtxbuotyyznu@earth>
References: <20171116115703.GA26735@amd>
 <20171117113540.3bapqvq6mfuovxuw@earth>
 <20171119124150.GA25154@amd>
 <20171119141213.my7dnc77xbun3gfj@lenoch>
 <20171119150730.GA2366@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v7mrnbzl4mh7hik5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171119150730.GA2366@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ladislav Michl <ladis@linux-mips.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, arnd@arndb.de, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--v7mrnbzl4mh7hik5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 19, 2017 at 04:07:30PM +0100, Pavel Machek wrote:
> On Sun 2017-11-19 15:12:13, Ladislav Michl wrote:
> > On Sun, Nov 19, 2017 at 01:41:50PM +0100, Pavel Machek wrote:
> > > On Fri 2017-11-17 12:35:40, Sebastian Reichel wrote:
> > > > Hi,
> > > >=20
> > > > On Thu, Nov 16, 2017 at 12:57:03PM +0100, Pavel Machek wrote:
> > > > > Hi!
> > > > >=20
> > > > > Ok, not for application, but I can get light sensor to work.
> > > > >=20
> > > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > >=20
> > > > There is no mainline user of this driver and it has a custom API, so
> > > > I think the driver should be dropped and an IIO based one should be
> > > > created instead.
> > >=20
> > > While I agree IIO interface might be better, and would welcome
> > > patches, I don't think that dropping the driver is right action at
> > > this point.
> >=20
> > That's the most elegant solution at all. How would you later motivate
> > people to try and test IIO driver? Let's pretend this patch have never
> > existed until someone notices and starts playing "you broke kernel ABI"
> > game.
>=20
> I'm using the driver; I'm even interested in fixing it. Please try not
> to make my job any harder than it needs to be, and I'll try to break
> ABI.
>=20
> That goes to Sebastian, too.
>=20
> If you want to convert the driver to IIO, please do so, I can test
> the patches.

Looks like I need to be more explicit, so be it:

NAKed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--v7mrnbzl4mh7hik5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloR8ycACgkQ2O7X88g7
+pqS6A//QnzxQBQ1GytJm/WMbH8xZsnAMcBZWSokANBbQvP08Ct0WHpkAQUjSgn7
K6/tWDhySFYp4EOWHJfo+5qKTKE09DHe9qLuN3tZpezVUPeDAmxpCHSsK4leHL35
cX/iqsXpw5LRMHvd+eKj96dgUZajbqYz8agEH02c3Eq64VB6ITqUPENY5Fv/z7B6
xGjmligv+dOBeAA8auPclC/IQBsvGnu2FAunA6WpPm1VQOcB2kmVIY6nGqrs4XOu
CBUx3KHUO+9rOKJJRccVCSEK5Ckr+XuU+8qOhnL1MrWzo5Fsv8w6x/vlQZVwToNQ
Zi9AVHJJTAPqIcXvWFWs5IQfujk4Y39hG8+ZYhRf1ncsuFOr6YaMMMPv1EfTibvh
H5gLC6CO7kbqQc99uMqVhpgwwyOlGO6aiEfcslCxhEKpJ4RKnpelIkr9Ysr9rSVm
BlGEr+U/TNufGRA8Bv9xpM7qiGDOqjY7RFp7Bkw2rz+tkHI1mO2fnFIsxgJL5dye
AUgjIevMIdqPQ7dWhMNaH4Bk60ElwZCgfjFH2rP0uZIRhhKG24pXnb6X6AcK00CU
rRfuoLgzyYgPa0iY+KsW+p/XxeFcIC/k93wTGhXvEyXqZYVXZAmMVAX+7kVrnPh+
vQVqltOu/BRVlltFXKKf1oczX+PQil0FSg+x8Iy0zJNIbH3QAoU=
=33oN
-----END PGP SIGNATURE-----

--v7mrnbzl4mh7hik5--
