From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Thu, 22 Nov 2012 22:15:49 +0200
Message-ID: <20121122201549.GA24320@arwen.pp.htv.fi>
References: <20121122175340.GA22614@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1211221318470.2255-100000@netrider.rowland.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57753 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757259Ab2KVUWY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 15:22:24 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1211221318470.2255-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, Andy Green <andy.green@linaro.org>, Roger Quadros <rogerq@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 22, 2012 at 01:32:25PM -0500, Alan Stern wrote:
> On Thu, 22 Nov 2012, Felipe Balbi wrote:
>=20
> > Hi,
>=20
> Hello.
>=20
> > > This is an interesting problem.  How should we handle devices which
> > > live on a discoverable bus but whose power is controlled by an
> > > undiscoverable platform-specific regulator?
> >=20
> > a quirk on the hub's product ID/vendor ID pair ? All you need is to put
> > a requirement on the format of the regulator name. Not the best
> > solution, I agree, but that's all we can do.
>=20
> That sounds a little too simple.  For example, what if there are two=20
> chips of the same type on the system, attached to two different=20
> regulators and two different host controllers?

hehe, good point :-)

> > > from platform data at boot time.  The suggestion that the regulator
> > > should really be associated with a port on the hub's parent is
> > > reasonable at first glance.  But what if we don't know which port that
> > > is?
> >=20
> > What do you mean ? I'd expect all ports to have a regulator. Either one
> > for each, or sharing the same supply. It all boils down to how the hub
> > is integrated.
>=20
> I wasn't clear enough.  I wasn't talking about downstream ports on that
> hub, but about where its upstream port is connected.  This hub is
> permanently wired to one of the root ports on the EHCI controller.  In
> this case, we know which port it is attached to.  In other systems we
> may not know, or it may be different on different revisions of the same
> board.

ok, makes sense now. You're right.

> > > If we can figure out a good way to set up the necessary association, I
> > > won't mind adding the appropriate calls to the USB core.  But is the
> > > hub driver the right place?  What if a similar power arrangement is
> > > used for a different kind of USB-connected chip (for example, a webcam
> > > or a fingerprint reader)?
> >=20
> > Then the camera's driver or the fingerprint reader's driver should
> > manage the regulator, no ? Or do you want to let teach the regulator to
> > struct usb_device and manage it at usbcore level ?
>=20
> The latter, more or less.  For example, maybe we can tell usbcore
> somehow that regulator X is in control of a device attached to host
> controller Y (not sure how we would express X and Y though).  Then when
> usb_add_hcd() sees that the host controller being added is Y, it will
> know to turn on regulator X.  Similarly for usb_remove_hcd().

that'd look very nice indeed. Perhaps we could even take care of such
details for the roothub, even. Maybe some systems might show up where
roothub need external regulators provided by e.g. PMIC ?!?

--=20
balbi

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrof1AAoJEIaOsuA1yqREAlIP/jOb3WTMosDGv1WM88h9QP5Q
LpYtkeQuMtWjwVe2HshdBFi1xrU+hIyjRJEqftOelSxkxPmBEtk0/aT1ESUmp/4I
lB+hQEZ2SrSr93dUCLYrIrDN3oOlHZkn8bX3Qbxtz7UpTfna26jHnLAPC2AgKQQS
xany2cHr/HgkQV5cDn4arZLqlic7WAcTndTgQbnCm7nHeiVSNnIVi+PCh8UsqTkv
gxe4mlZJXTPt+9pguuf50MHfJ+h9jLPYqa1s7GKipY8OefFyGoecaOAxpls+P7+T
W/w1XAY0dH+lxhl4e23Mpvq5uHKbeVCQ5NC6gr1+k+6fOfJ3YVFs7BLGYksfe1MA
E7gC12UHanUBLzM7bgwd6+/UNl22vqTiGnRiQmRvgRMoHwdg4tZM5ejJiC+DeNXe
2RT8nY577jbNu605aySaQxBl54tYUwrj0T5Wbtzd1bY18ItKj+Dh/ngOquAZMv7u
htsUckxx2EUlabNR4EPzmY+J0+HRpftJkwQcH53iQS7J0+OHcVB/5HDvMidTfClr
wDcnRoNTFu0ZlMwUKDPm3zB8ChbWlhyUvz+/lZE66wCwRH16O7fjWx9OmBb0AbiD
8WIv/30pD2bMTnU1pBEaB3GGYkaliVDk5TzuDJiJA1LpB0F8aywv3njaAZI3x64B
GtDXOWHi+gXYL3HMUPrW
=doT4
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
