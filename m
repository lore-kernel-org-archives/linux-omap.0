From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS errors in linux next when booted with DTB append
Date: Tue, 5 Feb 2013 14:37:21 +0200
Message-ID: <5110FD01.7010605@ti.com>
References: <20130116190803.GG14149@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4D41AB842F1BC8A56367DBC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38538 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab3BEMhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Feb 2013 07:37:24 -0500
In-Reply-To: <20130116190803.GG14149@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

--------------enigD4D41AB842F1BC8A56367DBC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-01-16 21:08, Tony Lindgren wrote:
> Hi Tomi,
>=20
> Looks like omap_dss_init() goes crazy on panda es when booted with=20
> PANEL_TAAL and DTB append enabled, see below. Does not seem to happen w=
hen
> booted on blaze. Noticed this after enabling all the panels, my modifie=
d
> omap2plus_defconfig attached.

Hmm, looks odd. The log shows it's trying to use Taal panel, even if
Panda doesn't have such a panel. Who's adding the Taal device? Are you
booting Panda with Blaze's dtb?

That said, I have seen similar circular locking warnings related to
omapfb/omapdss, but I haven't been able to resolve them, or even to
really find out why the warning happens. I haven't seen any problems
though, it's just a warning.

So my guess is that you're seeing two unrelated problems, one related to
dtbs or such, and the other related to locks.

 Tomi



--------------enigD4D41AB842F1BC8A56367DBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJREP0BAAoJEPo9qoy8lh710BAP/ijPQ3827SpC8tG0rOwcLHGK
IxvfSGvDkdDRF54ltpUqfwWOGF7CzA5V81+TQ40NrG4bJDgdQxxcMA1+OEGZdkcE
SXr0t9uFl7Gh9UbtzpNlsYZyocX88W8mltrKOVvV8mY983Li3xXwih2DuIFV9/OL
WWatKbIhZ2WiKS7496chOr2PpX/qMMPetKSMZAs8WT/ijT3agAUYZC0NQkMvuNBr
ZZO+2T7eU0rnWVt0CMAeWeYc+d0fPApeX4X+/YMRBbF5fYPw6trqiBHxugLAXJuE
39/tpmyyIuUh87hM6KoS+ZJLloLo45z0sp6yDEECxFs5Jna1pHpq7pQ91dyAQUOI
8VHbD5SfY/TS5rjNDip0ZZVOVHdNtuEw10XTPEySfjo/o4bySTHC2tloaSkZqwri
RlGT6cnvCRhMmh+aZEYKeNlBG8QreahIQOrUVcRVhKfZlXvFNp3rTr/n1IE3EW+r
fYrCweLlJ5jP4fHn293oQEcSepn9z39G/086CTYH76SxleNBFqCv0y6UdnbvBiuW
/JHE2U89t97lhO/bs/nThQanDzdoINvhjTnisq1iW7QvtjKdCwaYxTQ2r0DuK4wy
ICy88CctJGePbbXLaet1TiR2+Ptqn6tsR2jPi16zLGtGe/AgCd6ZchSCvhJx2v6n
cl0P6++xcMvHaUUN+MeZ
=fEIk
-----END PGP SIGNATURE-----

--------------enigD4D41AB842F1BC8A56367DBC--
