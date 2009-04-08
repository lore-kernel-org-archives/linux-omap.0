From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH] mmc: Fix compile for omap_hsmmc.c (Re: New build
 error?)
Date: Wed, 8 Apr 2009 20:41:30 +0200
Message-ID: <20090408204130.296ca789@mjolnir.ossman.eu>
References: <20090407195524.GA10619@n2100.arm.linux.org.uk>
	<20090408001325.GG23823@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-25998-1239216093-0001-2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:57344 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934840AbZDHSlh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Apr 2009 14:41:37 -0400
In-Reply-To: <20090408001325.GG23823@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-25998-1239216093-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Apr 2009 17:13:27 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090407 12:55]:
> > Caused by: 4a694dc915c9a223044ce21fc0d99e63facd1d64
> >=20
> >     omap_hsmmc: Fix response type for busy after response
> >=20
> > Error:
> >=20
> > drivers/mmc/host/omap_hsmmc.c: In function 'mmc_omap_xfer_done':
> > drivers/mmc/host/omap_hsmmc.c:301: error: implicit declaration of funct=
ion 'mmc_omap_fclk_lazy_disable'
> >=20
> > Please submit a fix to Pierre for this, thanks.
>=20
> Thanks for notifying about this. Pierre, here's a fix for this.
>=20

Queued.

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-25998-1239216093-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAknc790ACgkQ7b8eESbyJLjLsQCfV4WCmSVMuluqAgjRWhaEGMJl
eMMAniuRu3H0kcn8CKBONTIBxDFc7QKK
=oc/H
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-25998-1239216093-0001-2--
