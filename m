From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] dtc: parser: Add label while overriding nodes
Date: Mon, 23 Feb 2015 12:48:13 +1100
Message-ID: <20150223014813.GB4536@voom.redhat.com>
References: <1424378462-22105-1-git-send-email-nikhil.nd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:35587 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbbBWBsO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Feb 2015 20:48:14 -0500
Content-Disposition: inline
In-Reply-To: <1424378462-22105-1-git-send-email-nikhil.nd@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nikhil Devshatwar <nikhil.nd@ti.com>
Cc: jdl@jdl.com, devicetree-compiler@vger.kernel.org, linux-omap@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 02:11:02AM +0530, Nikhil Devshatwar wrote:
> This patch changes the dtc grammar to allow following syntax
>=20
> i2cexp: &i2c2 {
>     ...
> };
>=20
> Current device tree compiler allows to define multiple labels when defini=
ng
> the device node the first time. Typically device nodes are defined in
> DTSI files. Now these nodes can be overwritten for updating some of the
> properties. Typically, device nodes are overridden in DTS files.
>=20
> When working with adapter boards, most of the time adapter board can fit =
to
> multiple base boards. But depending on which base board it is connected t=
o,
> the devices on the adapter board would be children of different devices.
>=20
> e.g. On dra7-evm.dts, i2c2 is exported for expansion connector whereas
> on dra72-evm.dts, i2c5 is exported for expansion connector.
> This causes a problem when writing a generic device tree file for
> the adapter board. Because, you cannot know whether all the devices on
> adapter board are present on i2c or i2c5.
>=20
> The problem can be solved by adding a common label (e.g. i2cexp) in both
> of the DTS files when overriding the device nodes for i2c2 or i2c5.
> This way, generic adapter board file would override the i2cexp. And
> depending on which base board you use the adapter board, all the devices
> are automatically added for correct device nodes.
>=20
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>

Applied, thanks.

I did tweak the testcase to use dtbs_unordered_equal instead of going
through the set of tree1 tests.

The fact that you can only apply a single label by this method is a
bit of a wart, but it's something we can fix later.  I had a look at
it and (as I suspect you already discovered) it's surprisingly
complicated to do so.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU6obdAAoJEGw4ysog2bOS94QP/AnfuW9L7aBkqMNgCrfysEDl
UIsa18RrHGYpA66hpEfsVWrZGprHV2lQkkfQROE52jLgSrJJDEnAYmHldXI0wTsW
jUQYtCaLVt/u3TtaZgG4rZ0e9RfFb5VWTYw763lha29sqeyl0zshaF6pEODllG0W
nvjr/DZXqmoPwqUnaaCQKfsIux4ikXHw6gEXESt/L1Iz/wKAac1QmpPupuJbX0dB
rlfGhn9VXweaBeYwWQiy9b4T44XLvBe7mNl2ZnAwTJ4gude7TRTZ+q9fuXDDeqnZ
jDZmoAzVTME/WxChhMfsSUIAEYYxOaMgqrE1QNdJsZjw6CJxzHdMsXgMSakewZ5q
8NggjCvP5F+eSunK1OLLZl2VzmfAwisut0+K+IMfmcaQ/LQv6rW4rb0TAbH5HNZa
rD2PYjfvxdWjr3lgYLz3LKFN7V542flXXjOBT3clo0ULyKqSgUH2k+Ect0wSi75A
xFape/r0Ow5nfw5EeoBOqgyQMs/nW6Tt6S0GlY26A2647jD28HkmM/IqqLWGC0DO
kxWWKjkds6xAaGi0d2tLBfXneUEDblALDohbDrxlEHaAGNt2N/fVtDUh3sZpq+A6
j8/pHzPPCpJ8bTs62C61tZzPwl7o/y765KWCbqYppkM591N6bZsodI3AdlVc+CIM
yiZ8CsdcbStl7pSI9NT+
=0xJW
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
