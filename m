From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Wed, 21 Nov 2012 21:54:36 +0200
Message-ID: <20121121195436.GF14290@arwen.pp.htv.fi>
References: <Pine.LNX.4.44L0.1211211028200.1731-100000@iolanthe.rowland.org>
 <50ACFC5D.1090406@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38417 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883Ab2KUUBK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 15:01:10 -0500
Content-Disposition: inline
In-Reply-To: <50ACFC5D.1090406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>

--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 06:07:57PM +0200, Roger Quadros wrote:
> On 11/21/2012 05:32 PM, Alan Stern wrote:
> > On Wed, 21 Nov 2012, Roger Quadros wrote:
> >=20
> >> On 11/21/2012 04:52 PM, Alan Stern wrote:
> >>> On Wed, 21 Nov 2012, Felipe Balbi wrote:
> >>>
> >>>> On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
> >>>>> From: Andy Green <andy.green@linaro.org>
> >>>>>
> >>>>> This patch changes the management of the two GPIO for
> >>>>> "hub reset" (actually controls enable of ULPI PHY and hub reset) and
> >>>>> "hub power" (controls power to hub + eth).
> >>>>
> >>>> looks like this should be done by the hub driver. Alan, what would y=
ou
> >>>> say ? Should the hub driver know how to power itself up ?
> >>>
> >>> Not knowing the context, I'm a little confused.  What is this hub=20
> >>> you're talking about?  Is it a separate USB hub incorporated into the=
=20
> >>> IP (like Intel's "rate-matching" hubs in their later chipsets)?  Or i=
s=20
> >>> it the root hub?
> >>>
> >>
> >> This is actually a USB HUB + Ethernet combo chip (LAN9514) that is hard
> >> wired on the panda board with its Power and Reset pins controlled by 2
> >> GPIOs from the OMAP SoC.
> >>
> >> When powered, this chip can consume significant power (~0.7 W) because
> >> of the (integrated Ethernet even when suspended. I suppose the ethernet
> >> driver SMSC95XX) doesn't put it into a low enough power state on suspe=
nd.
> >>
> >> It doesn't make sense to power the chip when USB is not required on the
> >> whole (e.g. ehci_hcd module is not loaded). This is what this patch is
> >> trying to fix.
> >=20
> > Ah, okay.  Then yes, assuming you want to power this chip only when=20
> > either ehci-hcd or the ethernet driver is loaded, the right places=20
> > to manage the power GPIO are in the init and exit routines of the two=
=20
> > drivers.
> >=20
>=20
> The Ethernet function actually connects over USB within the chip. So
> managing the power only in the ehci-hcd driver should suffice.

the thing is that this could cause code duplication all over. LAN95xx is
a generic USB Hub + Ethernet combo on one of ports from SMSC. *Any*
platform could use it and could hook those power and reset pins to a
GPIO. If we handle this at ehci-omap level, we risk having to duplicate
the same piece of code for ehci-*.c

Since that's a hub driver anyway, I wonder if it would be better to play
with those gpios somewhere else ?!?

--=20
balbi

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrTF8AAoJEIaOsuA1yqRE2ZkP/jzFSEnaSicbPaKK7JEL94o5
a43LY9y9GTAnbRr5ZX2OpGecglh2vsOjkV8c7n/ZC+H49ZOaPtmci57ixx+vvL8d
4on/PXqzh8xJcAQVZs2pZgl0Rcoj7wrpbouCWIAB7Pi7hDMYXzxnplEL5BjTGcwA
UkQI0mduacGjuvZCNSg4AATrTKIzxpUnDwhhQMCbi9rLa/Vl+7o60WzmBIchOkWc
iApzHKH6Gj+t505XYZTU0RR3PUB6WWvSjF5xuPGCpZxB9AU1j6kaDn9eM5dT85xn
v47nBnkNaUYm4VuZc+djSPYVPzGnSdMwUcGd3OsnJd3L0V57VVH6OmtVdQIbHCQ2
h7+ZWiHoG+HMJdlYY8UtQKbEBxVFLZFu5UPMDmrO/TWhDdE/tV/Bky6K8UxRX02r
lV+LcGGiDOftTIT6LDj2fSbJE2M5bnnz/f6t7bEvqAn05V4prTgnO2Fas80tNIQ3
jI0Oa/Gn7aqn27c393RDZJAiE3x/I24j6Yuxb2J5CQYnZNDQYgJBJSF4IJsGkDTq
uwGO3hs0nWml0/6hBwpS4hm8P30KbKpCNqdEmJsK7kwkrCRoGQWEGa8dNF5rdyij
8/8+RciBLwwHjeuoG6UGqNXB7p6LDAZiuI1axGTYesppxkHhLa30k/kndhS2IYnA
jniJViyyL7xuuYcGKoiP
=4WB9
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
