From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Thu, 9 Jan 2014 12:43:36 -0600
Message-ID: <20140109184335.GN2417@saruman.home>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <20140109172217.GH2417@saruman.home>
 <20140109184059.GM2417@saruman.home>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0750115615047707189=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140109184059.GM2417@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0750115615047707189==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYfJCIN5rqlfy3K0"
Content-Disposition: inline

--WYfJCIN5rqlfy3K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 12:40:59PM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, Jan 09, 2014 at 11:22:17AM -0600, Felipe Balbi wrote:
> > > Changes compared to previous version:
> > > - Dropped any changes to generic clock drivers, as it seems impossible
> > >   to agree anything in short term, this means the patch set shrank in
> > >   size from 49 patches to 40 (first 9 patches were dropped).
> > > - Copy pasted implementation for clk-divider and clk-mux from drivers=
/clk
> > >   to drivers/clk/ti, and made the modifications needed to the TI vers=
ion
> > >   of the clock drivers only (based on discussions with Mike, this is =
fine)
> > > - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't co=
nflict
> > >   with any generic implementation we might have at some point, migrat=
ing
> > >   this to the generic version should be easy enough also.
> > > - Fixed trace_clk_div_div_ck for omap4, this node was broken in previ=
ous
> > >   versions and resulted into an orphan clock node
> > > - Fixed compile problem for omap5 only build reported by Felipe
> > > - Fixed a couple of sparse warnings
> > > - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
> > >   instead of __raw_readl / __raw_writel
> >=20
> > just caught a build breakage. .config attached
>=20
> forgot to give you build errors found, they're here:
> http://hastebin.com/jibuyuyoto.vbs
>=20
> Also, just caught another build breakage:
>=20
> http://hastebin.com/reravalupe.vbs
>=20
> .config attached

hmm, quite a few configs are failing, seems like have DRA7xx without
OMAP4 or OMAP5 breaks builds.

--=20
balbi

--WYfJCIN5rqlfy3K0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzu3XAAoJEIaOsuA1yqREvF8P/22zdB/Bmpwbz9AWsg37yoDy
OBhxLJUOKEZku/eek4qdTzEhDrFwSOLBd1ubkNk7S0FgpMf9xx605zSRIlL0/rBv
5lL4fXrcAkBNvjawzAaG6S85C+LKrV4xy2mbDwR71fjoMK4chuknjCsvfCQ8P7C0
7ML9REK9AC77/vxoD2YtJKDJLLM/UCBlCiDqI0z5DGFlAc2mWIOUOp8VbtJ7pEWD
5OXFe9th9T4+EPI/VMZGvQ3xT5rMH1x7T4f58S3YWKp4TuBVZGJWrxqmmCeqsqnu
Ls/q67z28l9hqBSDxEUI8O8eXBeCjgq4oqSYO5QWohBua3BP6yUzkEPSuJIyLnIO
SxXaLUYYT5gcU9kbrgYJrx7oTwY0DpnINO5MpD97Qho80iZHkkFmcFLv23a1ft/5
qTEwU7EgXwqwsFI+tzZFN8KFOmuI8Kci6kcRxZYS9lzqb+3pCzRpZ8Yufz5aovOa
sgiPz4gGdYLCTPpPQjnxNQop1qrriDOns8i2KiRkCdhp3jBvjLwql9fslRWf2GPL
ZehTwx4RbrTNXnrkKcXYPgLZT6jWrfVtnUcFwMkqE3MQuJz69qWYFAC3FT5T853r
VP0hgq7mQNPLNGOlMMQWhEdCC+1JR4Q7laD+2yvPvImjMpUqknwMSf71azF+GahT
aMD1yshFgdx886cpNr3l
=byWs
-----END PGP SIGNATURE-----

--WYfJCIN5rqlfy3K0--


--===============0750115615047707189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0750115615047707189==--
