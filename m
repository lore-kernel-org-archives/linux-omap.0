From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND PATCH 0/2] ARM IRQ Kconfig patches
Date: Thu, 16 Jun 2011 12:19:27 +0300
Message-ID: <20110616091926.GI12230@legolas.emea.dhcp.ti.com>
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
 <20110615151422.GA2618@n2100.arm.linux.org.uk>
 <20110615152444.GZ471@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45552 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752459Ab1FPJTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 05:19:33 -0400
Received: by fxm11 with SMTP id 11so1396273fxm.13
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 02:19:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110615152444.GZ471@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 15, 2011 at 06:24:45PM +0300, Felipe Balbi wrote:
> On Wed, Jun 15, 2011 at 04:14:22PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jun 15, 2011 at 04:02:38PM +0300, Felipe Balbi wrote:
> > > I have lost count how many times I have sent
> > > these patches. Will someone either take them
> > > in or NAK them so I stop sending ??
> >=20
> > It might help to copy the MMP and PXA people so that we get to hear
> > their side of the story.  It may be that they always require sparse
> > IRQ support to be enabled.
> >=20
> > 'cause at the moment I've no idea whether your patch is right or not.
>=20
> I'll do so... thanks, at least one reply :-D

seems like these aren't needed anymore. HAVE_SPARSE_IRQ is selected for
the entire ARM architecture. Sorry for the noise.

--=20
balbi

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN+cqeAAoJEAv8Txj19kN1lD0H/1bv6NAK0TtWFIOYRwxQpT6w
tTF3R5pUUHDAM1lG+ynnMOUxIXgE27/Fh0C5I5Lj/xV52AB0xYJa8rCuhTwK2QMK
UqLcyWV8PV6YsQ05lyQ2kmr0T0kx+T/aKUnqpLFBQ8iH60HNnw/6mP7pB//kJKWS
lfUBNht6MjGb+QqVPzFzhjUROZnC6ptcpRX+EZV9pcL0y9tbp4CU07LYrNLnSkKU
PBtdJdITi3l4Vtq2n3wDrue5Xuc/A9QrvAyVaIt6GM/3FS5pw7EzO/fXUik1DibT
dtJqEOZQIa72l/zENVXusVadrT941JDYHQFyoW7tu8QCfTErh7wVJyBr1nH0uiY=
=bnY+
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--
