From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
Date: Tue, 21 Aug 2012 19:08:47 +0100
Message-ID: <20120821180847.GC7995@opensource.wolfsonmicro.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-2-git-send-email-anilkumar@ti.com>
 <5033ADC5.4030002@wwwdotorg.org>
 <20120821163805.GW7995@opensource.wolfsonmicro.com>
 <5033CDDB.808@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8p/3hdGJBHAENZPK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56448 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758271Ab2HUSIu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 14:08:50 -0400
Content-Disposition: inline
In-Reply-To: <5033CDDB.808@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: AnilKumar Ch <anilkumar@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--8p/3hdGJBHAENZPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 12:05:15PM -0600, Stephen Warren wrote:
> On 08/21/2012 10:38 AM, Mark Brown wrote:

> > This isn't the general view for the regualtor API - we generally
> > want all regulators to be registered in order to allow us to see
> > what's going on with things even if we've not figured them out from
> > software.

> Oh, I said the above specifically because when I added the LDO
> configuration for the regulators that weren't used to the Tegra .dts
> files, you told me to remove it, based on the comment I put in there
> that they weren't used on the board.

The board shouldn't have to define the regulators, the regulator driver
really ought to be able to figure out that they're there by itself if
there's no configuration based purely on knowing which chip is there.
=46rom that point of view it's OK for the chip .dtsi to have them (though
ideally the driver wouldn't *need* that either) which was what was
happening here.

--8p/3hdGJBHAENZPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM86hAAoJEFJkBDiqVpZ4TxMP/i7dJQwQ/IbDVQa/IgbKMJ9u
r4KGZYH5IrSHaS6B3ZCkgjb3YzqPZS5JBZF5pSlezLpV62bYnh4QtggLcSrAukER
cAPCQOLcTFHqYXO8TDRKXY058mJb66yAR0zF5I6icctuZRh0Dj8+X+yc4H1Q5thH
UgI2f2Ck1OCzGjKiZUS6ot+B1cYSnQr/q70BSUO7ox9LMSeQltHWrdzc/jfZAebX
9hr1+1DuQMh6AfxWQJtLjb+IMy0GcD9a2X3u2PYx8LVOz9QrOUK+9P1eZvpyukzc
bDnXUkDSB2DwtnfpXt4+kmRf+RSYZXzYW/p6slhKuQhNPDJ2VsG5kQim6j8L49WR
i+/z+HITegzS0uRzmR8XoMUWWCd3CXMMrmpXADbRAY/SO9jHh3l3ECcV9dgNsJpD
E990Jore3y3dp8C4NSXC5JXc+9xZ8NlszjLvDRptfINV/Dcfzst/beVYr5TB/sfh
jg7lCtuSWBPIpk3QJ/tJB/Kav8wRWyyfCS3Be18XLBo9J1JFWrBETPw5Fuvwqq0M
HuV9Sm+WBylTwUVUWSl3o3Moi7fAX6MXfpTx2+1x6W5iltFrtOTWr6XJnFKLkiCi
elaGFXci2HJU0zWF8chNZ03/Cu6rFS5Og4/0QuEp0tJTcs1Kp7Xx0vNDSQwxq21H
qHyXlBi07BQKfmRomlvC
=rhFw
-----END PGP SIGNATURE-----

--8p/3hdGJBHAENZPK--
