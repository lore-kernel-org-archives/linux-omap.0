From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: [PATCH 9/9] omap mmc host: Use disable_irq_nosync() from within
 irq handlers.
Date: Fri, 22 May 2009 14:00:40 +0200
Message-ID: <20090522140040.49bad92f@mjolnir.ossman.eu>
References: <1239861321.29831.130.camel@linux-51e8.site>
	<20090426212118.19526712@mjolnir.ossman.eu>
	<20090514172226.GK5593@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-27075-1242993646-0001-2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-117-125-11.tcdsl.calypso.net ([82.117.125.11]:38498 "EHLO
	smtp.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbZEVMAr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 May 2009 08:00:47 -0400
In-Reply-To: <20090514172226.GK5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>, Anderson Briglia <briglia.anderson@gmail.com>, "Syed Mohammed, Khasim" <x0khasim@ti.com>, Ben Nizette <bn@niasdigital.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-27075-1242993646-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2009 10:22:26 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Pierre Ossman <pierre@ossman.eu> [090426 12:22]:
> > Should I queue this up or do you want to do something differently for
> > this?
>=20
> Looks like a valid fix to me.
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>
> =20

Applied.

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.ossman.eu-27075-1242993646-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkoWk+wACgkQ7b8eESbyJLg2pgCeIYmTg9hqDN/kcgd6ZP7L7PHU
WN0An0swv+dx+sau9SojZdZN7kaBVGF+
=N90I
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-27075-1242993646-0001-2--
