From: Charles Steinkuehler <charles@steinkuehler.net>
Subject: General-Purpose "hacker" device tree add-on
Date: Thu, 16 Jan 2014 15:57:45 -0600
Message-ID: <52D855D9.1090308@steinkuehler.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ffi3FR6dOhk86TxFv45wgIGlP9ESTcHCc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from dukecmfep03.coxmail.com ([68.99.120.38]:39318 "EHLO
	dukecmfep03.coxmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaAQAUT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jan 2014 19:20:19 -0500
Received: from dukecmimpo01.coxmail.com ([68.99.120.134])
          by dukecmmtar04.coxmail.com
          (InterMail vM.8.01.05.06 201-2260-151-112-20120208) with ESMTP
          id <20140116222905.TMSH8353.dukecmmtar04.coxmail.com@dukecmimpo01.coxmail.com>
          for <linux-omap@vger.kernel.org>; Thu, 16 Jan 2014 17:29:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ffi3FR6dOhk86TxFv45wgIGlP9ESTcHCc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am working with the BeagleBone and it's AM335x CPU and would like to
have a way to control most of the available I/O from user-space.  I am
considering making a general-purpose device tree overlay (which could be
simply added to the DT if the BeagleBone specific overlay manager is not
present).

The idea is to enable most of the useful peripherals like gpio, timers,
serial ports, I2C, SPI, etc, and create pinmux entries to allow
switching between the various functions on a per-pin bases at run-time.

This seems useful enough I figure someone might have done it already,
but I couldn't find anything similar.  I thought I'd ask here to see if
anyone knows of a project like this, or perhaps some reason why trying
to do this would be a Bad Idea.

Alternately, if this seems useful, I would appreciate any advice or help
with implementation, particularly naming conventions for the user-space
controls and anything to watch out for when setting up some of the SoC
peripherals.

--=20
Charles Steinkuehler
charles@steinkuehler.net


--Ffi3FR6dOhk86TxFv45wgIGlP9ESTcHCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLYVd8ACgkQLywbqEHdNFwI5QCcColBuB5W0NCgUyBj0zZlZZ/H
P1cAn2X6eLzHDs/jLotzrTt2lELGTxT/
=Wc+M
-----END PGP SIGNATURE-----

--Ffi3FR6dOhk86TxFv45wgIGlP9ESTcHCc--
