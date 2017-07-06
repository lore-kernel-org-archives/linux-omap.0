From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v4.13-rc0 on nokia n900: spinlock bad magic
Date: Thu, 6 Jul 2017 20:15:54 +0200
Message-ID: <201707062015.54343@pali>
References: <20170706180337.GA26875@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1948780.juZk481xnO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170706180337.GA26875@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

--nextPart1948780.juZk481xnO
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 06 July 2017 20:03:37 Pavel Machek wrote:
> Hi!
>=20
> I don't think this is new in v4.13, but perhaps someone knows how to
> debug it?
>=20
> [ 5611.801147] g_ether gadget: packet filter 0e
> [ 5611.801177] g_ether gadget: ecm req21.43 v000e i0000 l0
> [ 5668.771453] BUG: spinlock bad magic on CPU#0, kworker/u2:3/9745
> [ 5668.771850]  lock: 0xce63ef20, .magic: 00000000, .owner:
> <none>/-1, .owner_cpu: 0
> [ 5668.772277] CPU: 0 PID: 9745 Comm: kworker/u2:3 Tainted: G      =20
> W 4.12.0-03002-gec979a4-dirty #40
> [ 5668.772796] Hardware name: Nokia RX-51 board
> [ 5668.773071] Workqueue: phy1 wl1251_irq_work

I do not remember that I saw this problem.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1948780.juZk481xnO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllefloACgkQi/DJPQPkQ1J7CwCfTlajsB2bb+OPsx7kX85BS5Xi
N8UAoIMqgQ3aF5agjZYP6ViAtXGfXd9A
=gGzs
-----END PGP SIGNATURE-----

--nextPart1948780.juZk481xnO--
