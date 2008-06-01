From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: MMC/SD cards hotplug scenario
Date: Sun, 1 Jun 2008 12:03:13 +0200
Message-ID: <20080601120313.0100d089@mjolnir.drzeus.cx>
References: <004e01c8bb09$989fac00$538918ac@ent.ti.com>
	<20080521073017.GB23427@flint.arm.linux.org.uk>
	<005d01c8bb25$63345fe0$538918ac@ent.ti.com>
	<20080521203202.6d84a02b@mjolnir.drzeus.cx>
	<005f01c8bc11$5d12d3c0$828918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-6829-1212314358-0001-2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:55026 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752489AbYFAKD3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 1 Jun 2008 06:03:29 -0400
In-Reply-To: <005f01c8bc11$5d12d3c0$828918ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-6829-1212314358-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 May 2008 19:10:10 +0530
"Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com> wrote:

>=20
> I am attaching the output of dmesg. I captured dmesg output after I get t=
o the error phrase.
> I enabled MMC debugging as well to get some idea. It looks like upon rein=
sertion of the SD card,
> no commands are issued after CMD51. It might be the case where CMD51 (SD_=
APP_SEND_SCR) fails to read
> the SCR for some reason in this scenario.

This looks like a driver/hw bug. CMD51 is the first data command in the
init sequence, so the data engine of either the driver or hardware
seems to be wedged. So it's not something related to the MMC core.

Rgds
Pierre

--=_freyr.drzeus.cx-6829-1212314358-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhCc+sACgkQ7b8eESbyJLhbqgCfT8flCVFJzGVvTCAyUrUG0OC7
FTAAnjQ+F55DFx1v1uF8EjIWtLp7uyQJ
=MeuM
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-6829-1212314358-0001-2--
