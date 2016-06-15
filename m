From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
Date: Wed, 15 Jun 2016 15:47:42 +0200
Message-ID: <20160615134741.GA16860@earth>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <1465987689-14812-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7126865130710294585=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465987689-14812-2-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, Russell King <rmk+kernel@armlinux.org.uk>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============7126865130710294585==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 15, 2016 at 03:48:08AM -0700, Tony Lindgren wrote:
> Let's drop the last two remaining omap3 legacy boot board files.
> Let's only use the device tree based booting known to work for
> these two boards.
>=20
> We still have two omap3 boards booting in legacy mode in addition
> to device tree based booting. All the other ten or so omap2+ SoCs
> have been booting using device tree mode only for years now. This
> has allowed us to get rid of quite a bit of arch/arm/mach-omap2
> related platform init code in favor of dts and driver changes.
>=20
> Pretty much the only remaining known users for omap3 legacy boot
> board files are Kevin's and Russell's boot test systems, and N900
> kernel tree maintained by Pali and Ivaylo. And all of them are
> also supporting the device tree based booting. The legacy booting
> mode has been kept around mostly to verify against regressions.
>=20
> As there is still a slim chance of possible other uses of the
> mainline kernel for these boards, let's just drop the board
> files for v4.8, and let's not touch the related platform init
> code until around v4.9 time if no issues are found. This makes
> it trivial for us to add back the board files with a simple revert.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I don't remember when I last booted N900 without DT, must have been
a couple of years :)

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXYVx7AAoJENju1/PIO/qak+EP/1crvM1502tuvw+722afQfgy
HWqun/x0RYb11jxCoffcfh2WgkvJNRiTGLWYE9zTmRzvIjvxJXl1/m+0tBjp95PS
pyUWDDKkcsOWFBaH3NKNnxmvwumlBsWrguz/U0qUFaHwCY90aSpCU6yR5raSocbN
W1c8nL0KAsjCFtaPFUyWZvRqa894J5O/2bkrPHaEtAnRQir7KJQJic5YRnx0skCU
bPFcvTmrjrP+MeSCf0xCEr+BhVkuTlye+6HjJQ2387/ak3PQ82EgEl7ajrUZxIoM
aBGzIkcKmby+BZF/EPzWPGYwF9E+Lhszv+DuQm6BILCoQsDAuxI0HZYYMJ87mfbd
8VLdPhjOUQbFvSVIcObwy38hCXUAgJl1BG6u5S+rrj58ndy66NWvQPbq0OXbrdsz
2ad9Yc9Ysp1cnwR7dDwCYgv8XfBMEATOGS/IBdm40S11x72QRHn3wGH8imrRtUs1
6wsaBMNQybPplOKWxUqjqM0B2EKLIujBL0lZJHduS02gVFHYi6u/ljA0gx4Q9mhX
F6Ivq+VBPjIGohtgiu38WHUZjvIZNzNbN5dEBOX6kJhx8PtHc6H+u6+YtBASelPq
pARQrtQXy/qwW+KmgdM02YNoUvKuZJReTF3qGAC8bYzRv3nYWrbsSqBIIWJslgNM
JBmFIxRSQu/N5NIONts3
=DOYB
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--


--===============7126865130710294585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7126865130710294585==--
