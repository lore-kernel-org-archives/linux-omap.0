From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 19:53:40 +0200
Message-ID: <20121122175340.GA22614@arwen.pp.htv.fi>
References: <20121122135603.GA20066@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1211221226360.2255-100000@netrider.rowland.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55497 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168Ab2KVScL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 13:32:11 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1211221226360.2255-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2012 at 12:36:43PM -0500, Alan Stern wrote:
> On Thu, 22 Nov 2012, Felipe Balbi wrote:
>=20
> > > If you mean change the regulator managing code from living in
> > > omap-hsusb to ehci-hcd, it sounds like a good idea.
> >=20
> > I mean that drivers/usb/core/hub.c should manage it, since that's what
> > actually manages the HUB entity.
>=20
> This is an interesting problem.  How should we handle devices which
> live on a discoverable bus but whose power is controlled by an
> undiscoverable platform-specific regulator?

a quirk on the hub's product ID/vendor ID pair ? All you need is to put
a requirement on the format of the regulator name. Not the best
solution, I agree, but that's all we can do.

> Has this sort of thing come up in the past with other types of
> devices?

I'm not sure.

> A big part of the problem is associating the hub, which is created
> dynamically by the USB core code, with the regulator, which is known
> from platform data at boot time.  The suggestion that the regulator

It doesn't matter, IMO, when do we know the regulator exists. As long as
the regulator is registered early enough (or we rely on -EPROBE_DEFER to
synchronize things) and we have a known naming format (perhaps something
like usb_hub_port%d_supply, or something), we should be able to request
the regulator and toggle it at any time.

> should really be associated with a port on the hub's parent is
> reasonable at first glance.  But what if we don't know which port that
> is?

What do you mean ? I'd expect all ports to have a regulator. Either one
for each, or sharing the same supply. It all boils down to how the hub
is integrated.

I'm guessing the the problem here is that this hub can't control the
external Hub when its port gets a PORT_POWER feature cleared or set.
That's what I'm assuming.

> Once we can solve this part of the problem, I think the rest of it
> will fall into place.

I agree with you.

> > as long as Alan is ok and it comes in the same series, I'd be really,
> > really glad to see such a patch and would happily review it.
>=20
> If we can figure out a good way to set up the necessary association, I
> won't mind adding the appropriate calls to the USB core.  But is the
> hub driver the right place?  What if a similar power arrangement is
> used for a different kind of USB-connected chip (for example, a webcam
> or a fingerprint reader)?

Then the camera's driver or the fingerprint reader's driver should
manage the regulator, no ? Or do you want to let teach the regulator to
struct usb_device and manage it at usbcore level ?

--=20
balbi

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrmakAAoJEIaOsuA1yqREvLQP+QFa1/n/jesJyVNi8k9F26bz
3wbPIVBFK5Lcnbwz+xcDbHKzkEY2/zqbG6YELoTEGdyMJURM0ikeToeTtfXcjROt
sfSqlF2hfUobrmiqZO5Kr3hJK8O0MmPiFIS4dHgw3ECK6a9Xk6UN+liZzYNyAfKG
5eDFRvTLJD4+6SMRFEOtb0OvHZinkDQx7XB6Gh61oaGYz22d0dLCTbOweTM1gZqr
u75/7FDYyU3NzhJuNIPpHC7PLUAaBeWkynXJr9hnCZg4wMiWTMPYQMOJzSaLs6dj
7xm+EsI6zq1ofnOpfxnQMYRDwAcfGV6+Z61rNDyec9FyvO+E+9OnhYWJ6nL9ozCg
onZ0bBAU/GZ5qQ+psjdkEnYW+gjnXzI2aO9PwNe9tkq4xZ/XcC41EMkgmL2+zu27
jnZ1dkfn459QSSQRq7oVtmsHUvwkpZUhUC4CuNalvgLSnYQhz+7oRjkSHFsodFE6
x4Z0jNIS2ztSb55XD9ugHSng9l6x3wHvPfc3TJfz1TX/lFqh6CVfkK+rfGXGix/g
9bcdgMQ+AtUp6lfwHW6JZwKOTlM/smV6YByOoZBYy7qghz7GzgOhn4vAcvDIyF/6
bjBujPdNs5s5CAnZtLVKs74XZqr/nN9ZCPBD4g5dEjFqAvMlJ253ByjfwWGNZRbT
GWgvu4yF/Zc6mlpnAq3E
=033p
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
