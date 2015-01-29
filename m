From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] dtc: parser: Add label while overriding nodes
Date: Thu, 29 Jan 2015 21:07:31 +1100
Message-ID: <20150129100731.GC10150@voom.fritz.box>
References: <1422456611-15447-1-git-send-email-nikhil.nd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:58883 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbbA2KMv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jan 2015 05:12:51 -0500
Content-Disposition: inline
In-Reply-To: <1422456611-15447-1-git-send-email-nikhil.nd@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nikhil Devshatwar <nikhil.nd@ti.com>
Cc: jdl@jdl.com, devicetree-compiler@vger.kernel.org, linux-omap@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 08:20:11PM +0530, Nikhil Devshatwar wrote:
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

Hi, sorry I didn't get around to responding to your earlier posting of
this.

The concept is good, and the implementation looks fine.

Only 2 things before I'm ready to merge:
  1) It wants a testcase
  2) I need to stare at the syntax for a while and convince myself
     it's as good as we can reasonably do.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUygZjAAoJEGw4ysog2bOS908QAMVZ+5QQubBhYbrLGTTJx1p1
NQudQMjXZwH6ZMibnHICWspFbukROT8m6VEgDD8pwmXdTSmLx0DKLM2bt4YU7D0L
vpLev+uk4rwtEh0YH8r5aH6flYGkEbXktYsL2dOFKFf3iehZWc2ez1qXdW7jnv/N
tE4bR62ZUyvdZHm3d0h3FqrnbEcMewIH/viEcbf6xoZdkIlu4RfA0CZ+HDzJJsKi
06pvUE9d0yu5YLpZdwfKzoooCSFMW6Ny4dZfqdhSweFT5xk3WfbbRJ4jIwFfm6KN
+wvVA7hGEVS8bLYsmPdrhbSS6ZqaK/rJtOr2ZMGs6qvlINqkPWFQmIXydWVyYx9S
aeRzdt8GxDb2EManur475PShPLT6V7coggvK0BSiBd/b5jVgL094M1CK4pjMIWOt
asadwzP6cvZQJ6lglKaeVIfJgU7IM1xUdq9ycYwvCnR7e8SyshdPNvGkXmW0vKrS
7LWoePtjOsigXIbgvw/ScIJtJksE9RfqWlBTvh0dQY7NYcCMRS2dhxdAVdeA4a0c
ycFA4+S7MpChOtLvYh4GzHdDiaLnxK798FSlt/yikycaLnyeGRM9WM4PZEyM3q+d
UL6lKlCBBwqvXMFgfd0DsnEIy9g86O8gmB2RCw8n0O2j25hs9sWuiWmzx6sDMYhb
YFfWY03N2oPrTol3lzaj
=dB3/
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
