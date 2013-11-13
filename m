From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: dts: AM437x GP EVM support
Date: Wed, 13 Nov 2013 06:44:23 -0600
Message-ID: <20131113124423.GA28192@saruman.home>
References: <1384255468-2453-1-git-send-email-afzal@ti.com>
 <20131112142206.GD31721@saruman.home> <5283247D.7010106@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1129387236546886123=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5283247D.7010106@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Afzal Mohammed <afzal@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rajendra Nayak <rnayak@ti.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <bcousson@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, balbi@ti.com, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1129387236546886123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2013 at 12:34:29PM +0530, Afzal Mohammed wrote:
> Hi Felipe,
>=20
> On Tuesday 12 November 2013 07:52 PM, Felipe Balbi wrote:
> > On Tue, Nov 12, 2013 at 04:54:26PM +0530, Afzal Mohammed wrote:
> >> From: Lokesh Vutla <lokeshvutla@ti.com>
>=20
> >> AM437x GP EVM DTS with pinmux information to make I2C on EVM usable.
> >>
> >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> >> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>=20
> > could you instead send the much more complete version we already have
> > at [1] ? It's pointless to repatch all of that in this file if we *know*
> > those are already working.
>=20
> By taking those changes and testing on mainline, I couldn't get mmc
> working and was not confident about ethernet changes, I2C changes were
> verified and boot test was done (with DT clock series). I posted only
> the changes that I felt confident.
>=20
> Basic DT file and I2C are dependency for others, it was necessary to
> remove dependencies at the earliest.

fair enough, still sounds weird not to send the full DTS considering
it won't cause regressions, it just exposes an existing failure WRT
AM437x support upstream.

--=20
balbi

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSg3QnAAoJEIaOsuA1yqREiUMQAKPxc2/8SpAHQCG2uOn+ACyC
UZkvYfkzE8hf4n/GkL1S8m/q1ytuQUm+nFw86WCID2hT+Jtlf1hRXtbNzpm92vwP
KlJXT16A5OHvr2jA4OwXVg7TklJQLCaymWUed0lKdRLy2Q4esSbdmJJ2IEjsAd0S
95TsCfX49CnXE11BG4kcnDr2M6RbUr3Xdu2CwW/NThBu0B0r7yrDfjxP9AJkXSjx
uce3arVk1df4p00RXhT75Hd8J8hGx9zrcKDU7unQViFKyJKfzYu/zmwMLCm6ttBz
qER8pzH2zV4PjfjlyKxSCxs8NCvGKumdW7Bm3JThTD9lEbJ75Z3Cvrpb/ZEoq+An
JpVtD+82uquNOyoLRmTC5GazP+5zP4RcnD8FF+q/J/d58ffvnC0sBPQleFjyoSXd
TMpSRM74hjCzY8VeX+06/TqYMcCU+bwrzxkRIdhWGiKniTOSuJjBzyjENoxVEtFf
v6aCshI8itaiXpEQbnF0GYUV+sBMT6D9d7NPjLqXTuctMjsxnbEqabieF8E8Fcye
36axIyf4WnmFmHQPg1I6pSJSmKMd/56dYx7/YdIaIgu9YcH0yb2FXv8M8bixNt7a
QRJx23qgcYpIi1FiVPpOiNJjm2Wjpfb1HfrkCHnE8qPDajlaLPv5EvH+TVvN78bt
6BlYS7dKpFON6ORoFBV4
=k3JU
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--


--===============1129387236546886123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1129387236546886123==--
