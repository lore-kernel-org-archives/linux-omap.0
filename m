From: Felipe Balbi <balbi@ti.com>
Subject: [RFC] possible removal of omap-serial
Date: Thu, 20 Mar 2014 18:52:10 -0500
Message-ID: <20140320235210.GB26964@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38175 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759695AbaCTXyW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2014 19:54:22 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've been toying with the idea of removing
drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
ungly copy of 8250 driver.

The original concern was wrt suspend/resume but I think it'd be a far
better approach to implement runtime PM in 8250 and write a rather small
8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
OMAP-specific details out of the way.

The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
instead of ttyS\d so removing omap-serial.c would have a direct impact
in userland. I wonder if it's an acceptable "regression" considering
we'd be able to reuse 8250 gaining proper Flow Control support, proper
DMA support, years and years of bug-fixes, etc.

What do you guys say ?

--=20
balbi

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTK38qAAoJEIaOsuA1yqREM5EP/imgzFE0tq1ilxQ7qDO4W+Lw
jJnRVXBbLzMTKxDy1MCKXQF68ABbux7lIPfkx9PmXCPBH0B4fCnBzKzRr3E81WCe
oI+HEv/cdmP5IxE4/qor90Zr6BlaEsHE8CUP+rehkv72YdFyYBL7lOIC9zyLjoqv
FwukpZFwbiiqFcarmspHZKTWXEbwDEaZGds14PgF3c0BR7PbLNkO7nHLujS7oi6i
eLDxJKkwv23AwSYPtQ7WRpj4Hi0l4eX4pb/Q58PCTg6kaTFTa1A7ZoTx5OXSrNPp
hamnbTlivloOqdLz+uKdedbxJxzC3eoB/ZKstvVtUnoncZ6Q0bmCxpYaBu0riUlh
hvUv3yt4CNh8Vda05vy7l34k3n//j9rEfXgQhgVP3I+dOHfoz//ua+Atjac7C+qd
Rnpvk5OVz20hwGbJdE/UrlS5Gtc8HlMWLtawiroWgrSxfqpoXsmO7reTSVQvzJdd
1OuQT/phIvbWpKvVtwCdbsbyiWme1k0wQIoVU6lMMCP6XwI8xsas2NQVyfK/xend
YWJmRTS/5UMRm1kptsq0Y+FWwa/G+9STOBw1UzNLflPTVULdPP24UGqoX47khpgG
nA98IO9EqJLx2QsQIAy3jsXrDyOqtcYROQMCCUKMxonuYR09UhQbNH6WfbI38zgW
ddQzQjLbtioFCkhcIzt5
=dGik
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
