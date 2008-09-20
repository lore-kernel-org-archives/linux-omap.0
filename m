From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Sat, 20 Sep 2008 12:02:33 +0200
Message-ID: <20080920120233.6a3ad80c@mjolnir.drzeus.cx>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com>
	<20080910235646.GV21163@atomide.com>
	<20080911084828.GC26078@flint.arm.linux.org.uk>
	<20080911112315.GA10002@angel.research.nokia.com>
	<20080911113504.GD16796@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-10498-1221904962-0001-2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:47092 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751344AbYITKCn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Sep 2008 06:02:43 -0400
In-Reply-To: <20080911113504.GD16796@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Jarkko Lavinen <jarkko.lavinen@nokia.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-10498-1221904962-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2008 14:35:04 +0300
Felipe Balbi <felipe.balbi@nokia.com> wrote:

>=20
> Maybe Pierre should be watching this patch as well. I'm putting him in
> the loop.
>=20

Thanks ;)

When/if you want to submit this, put the core stuff in a separate patch.

> > @@ -111,11 +112,12 @@ struct mmc_host {
> >  	unsigned long		caps;		/* Host capabilities */
> > =20
> >  #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers=
 */
> > -#define MMC_CAP_MMC_HIGHSPEED	(1 << 1)	/* Can do MMC high-speed timing=
 */
> > -#define MMC_CAP_SD_HIGHSPEED	(1 << 2)	/* Can do SD high-speed timing */
> > -#define MMC_CAP_SDIO_IRQ	(1 << 3)	/* Can signal pending SDIO IRQs */
> > -#define MMC_CAP_SPI		(1 << 4)	/* Talks only SPI protocols */
> > -#define MMC_CAP_NEEDS_POLL	(1 << 5)	/* Needs polling for card-detectio=
n */
> > +#define MMC_CAP_8_BIT_DATA	(1 << 1)	/* Can the host do 8 bit transfers=
 */
> > +#define MMC_CAP_MMC_HIGHSPEED	(1 << 2)	/* Can do MMC high-speed timing=
 */
> > +#define MMC_CAP_SD_HIGHSPEED	(1 << 3)	/* Can do SD high-speed timing */
> > +#define MMC_CAP_SDIO_IRQ	(1 << 4)	/* Can signal pending SDIO IRQs */
> > +#define MMC_CAP_SPI		(1 << 5)	/* Talks only SPI protocols */
> > +#define MMC_CAP_NEEDS_POLL	(1 << 6)	/* Needs polling for card-detectio=
n */
>=20
> This would require changes to all other mmc host drivers, right ?
> How about:
>=20
> +#define MMC_CAP_8_BIT_DATA	(1 << 6)	/* Can the host do 8 bit transfers */
>=20

This is not an exposed ABI so this kind of fiddling it not a problem.

Rgds
--=20
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-10498-1221904962-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkjUyj8ACgkQ7b8eESbyJLg/+ACgy614BxLCYbELpvIEj+CyYVyl
7UgAnAoqYEkB3x+lLTebHERf3QUAPTrK
=F+CY
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-10498-1221904962-0001-2--
