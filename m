From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Fri, 29 Jul 2011 12:55:13 +0300
Message-ID: <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:41583 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333Ab1G2JzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 05:55:17 -0400
Content-Disposition: inline
In-Reply-To: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 28, 2011 at 02:59:55PM +0530, Govindraj.R wrote:
> Proposal:
> --------
> 	1. For the UART, follow the current approach of locking the console in
> 	   Idle/Suspend path before cutting the clock but using pm_runtime_putsy=
nc.
> 	   That is, continue using the prepare/resume Idle calls in idle path.

I believe you should be using ->prepare() to prevent that any other
work on UART won't trigger a console_write() right now. Maybe only
queueing the work for after ->complete() or, maybe, just ignoring the
work and loosing some prints, dunno.

> 	2. Other Approach would be adding conditions to debug prints from
> 	   omap_device/ omap_hwmod/clock_framework avoid calling these debug
> 	   prints for uart.
> 	   Or Even a debug macro that would not debug prints if the context is
> 	   from uart.

yeah, that might work but then again, if we were using 8250.c, would we
have this limitation ??

I think that, maybe, your best call would be to capture console_write()
calls into an internal temporary buffer on ->prepare() and flush it once
->complete() is called ?

BTW, where are the patches ? :-)

--=20
balbi

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMoOAAAoJEAv8Txj19kN16FAH/RaPeEYhHbADkBrNm7vHHAIq
CYYUXN8jZ0IiUUUpo7Z7H98nWXuq92KeaScP6OYgDg8WcyZT3TM0wWPsznT+Raov
U9VnhNO6vhE1GbGUj2rt/jw2CeLGU8Zm7x6LG3UcL6jPACUigN69+WVlDUs8kGM/
AzmIOXjaSyWZdT9vXa0evAHLNYtDXsJzTZnXyb39abBJ8czTRsW809HdR3kFLXJ7
N+gc/oHG6WigC4R65k3Z/Kp7CeBiKgtaUdY9W2wNoGbcsb7x8oY7mSa0qU9BFrw4
p1uPU8fgC4EJ3EHJarzeu0+AdEBDNpsKwoTN/MH55Tz9cW+T3ak2FduJFhDSO7o=
=5/TQ
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
