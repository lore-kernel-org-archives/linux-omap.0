From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP34xx
Date: Tue, 14 Feb 2012 10:48:57 +0200
Message-ID: <20120214084854.GB24201@legolas.emea.dhcp.ti.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk>
 <20120209183624.GJ1426@atomide.com>
 <20120209193442.GA1767@rexfeany.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40155 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330Ab2BNItD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 03:49:03 -0500
Received: by lbbgg6 with SMTP id gg6so3591657lbb.0
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 00:49:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120209193442.GA1767@rexfeany.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rex Feany <rfeany@laeos.net>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Alan Stern <stern@rowland.harvard.edu>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 09, 2012 at 11:34:42AM -0800, Rex Feany wrote:
> I also get these warnings when compiling:
>=20
>   CC      arch/arm/mach-omap2/usb-host.o
> arch/arm/mach-omap2/usb-host.c: In function 'usbhs_init':
> arch/arm/mach-omap2/usb-host.c:528: warning: assignment from incompatible=
 pointer type

yeah, I'll send a patch for that.

>   CC      drivers/usb/host/ehci-hcd.o
> drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' defined=
 but not used
> drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' define=
d but not used

This can't really be "fixed" without some extra trickery. The fact is
that OMAP can't handle port handoff (go figure) and if we use those
functions, we might end up in a situation where USB doesn't work just
because you connected a full speed device.

By not using those functions, we guarantee that the full speed device
won't get enumerated but USB will still be functional after you
disconnect such device.

We could add a bunch of __maybe_unused annotation to all those ehci_*
functions. What do you say Alan ?

--=20
balbi

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOh/2AAoJEIaOsuA1yqREqYsP/2Qhrxs7szHK7vuA7ajQZ9nd
ZKGW4YBm+gLoXmOD/A8Fe12iuKbmNsphZvB5tJCScpI73yN6FUGDxYvWGwuGN8+4
SfVed0Q4HTRpHkvzv4EcNyOmOOLGskwoxQ89lAWS8vAqNML9Vxtpn8JZsGe1eptp
PB93aD6vzyWB3JByb0Tv+qh5qhVQdXUTMQu0tPRIRJ8fcFtbYjRJmmzwiuZgtFgJ
9nIxh092narMp0K8KCjS4YnbDFVBccXs2FH40TFEt7bMgn1ilYulS+rNgJ8GotGQ
s5YMpJWwbj4ZYwWjIM97cSx/t7RyJB2KYa9XCOX9WZi2nj+xbXslz9xQvG7MPUVz
bxRfM1dZlPXwjZ12UpelxnwyXvh8fhrLZuUcRhdVKBTIzxw7iJF/6avjP3G17b/X
skaG9DxdRwz+X9RwFr0I2hJdzvzmuOCnuq7Fyf9RV6QsYCbmhCIUhz8MCPZN5slI
aAvhiH+2Hv5tlouwBrS1VQ9TVWxiK24RXEOfqkrPgABv2Qf/5+dgf6aV6QtxJ3OT
LgTNZE0kq10dIyesDU+yp+akZ7D1Z6BdFbqyCm0a/DFwgCTm3WVgZVEumu1RYTl7
NaxTeGk2xHV0PtmykU6kKFAZkXzEwS7iY39LsSiWlHvxpMlJWhfvekp27Z2VmAVs
3Epa5Wp1+/w05tBFYYq2
=eYpS
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
