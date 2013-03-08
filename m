From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Fri, 8 Mar 2013 09:14:53 +0200
Message-ID: <20130308071453.GD21589@arwen.pp.htv.fi>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
 <513904A4.7040101@wwwdotorg.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <513904A4.7040101-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 07, 2013 at 02:20:36PM -0700, Stephen Warren wrote:
> On 03/07/2013 02:35 AM, Felipe Balbi wrote:
> > Hi folks,
> >=20
> > inspired by Paul's DWC2 patchset which added usb_otg_state_string()
> > (a copy of otg_state_string()) I have now renamed otg_state_string()
> > to usb_otg_state_string(), moved it to usb-common, then moved all
> > phy drivers to drivers/usb/phy/ and completely deleted the otg director=
y.
> >=20
> > We're also removing CONFIG_USB_OTG_UTILS since that has lots its
> > meaning long ago.
> >=20
> > I have compiled all patches with allyes, allno and allmod configs,
> > but please make sure to test on your platforms to make sure we're
> > not leaking any more problems to mainline.
>=20
> What branch do the patches apply to? They didn't "git am" for me on
> either next-20130305, nor
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next.

they're on top of my testing branch. There were a few other patches
touching drivers/phy which you need. Namely :

0e3b847 usb: phy: mxs: use readl(), writel() instead of the _relaxed() vers=
ions
35f0683 usb: phy: mxs-phy: register phy with framework
f6797d0 usb: phy: move bulk of otg/otg.c to phy/phy.c

It's easier to cherry-pick them all from my testing branch, or merge the
full branch which contains a bunch of other cleanups.

--=20
balbi

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROY/tAAoJEIaOsuA1yqRERagP/2DOQE1e0QtgGChXmhYjcyLY
0T8fKzQ3VIc9c1lsDqLGxDgpGQK4cSUwNAqZsBPorZoU7SdSt+bCowU8S1gJ1beG
PnWj/FWnbxaXTyq4D3Rcgir76pPW5nxH5NB4ySfP5RTAX4WeCZ9K4rer4vqkO9vH
VrMyarK4CC1V3BBr8zEehA67oWVtyx4TQ3OMwVG6xgmAwhTMXO1QhRsNHsWh0FbO
OYwMdbFZLqgAY0nyL2rkAjYYxF0372HL/7EOMYl8RQqgD5tNCgmGJhfFb7t3wCrd
ixRERZauIXuyepBxm8btrlA4l/rn7G2ijSALNUP2aIEwvZZEQwbuwDjFu3iZdfIF
GvwywgYoISzmL2XX4nNgzOK9iqYd/YeuaEBMhutMmT3iafztC56At9Cj0WFf8XKh
ihJh11MeO7OBWJzAZ3p+oXdTc09xwNK/wxc1fXCGAUe5JwjAWFDcTNa0ecr45nyZ
exFTHIG4aywH8dxkNMd728lR1lJo9I9+UJ64KjzE1blUJnFoAzJKmkLkqxBSsmwn
71LT0UrCcWZWBy33eWu6zO2ZEmlmhfFHaDaO+R0L3p7oM4+xmZtHyc+w7V7ESway
vexo+ca6AKk9+wlh8miWQV9F0Hlre6zAP5QTjUl/DIysQlQdM6Wp+DrZnkPQRz++
rOlt1yPnI3xGGxWBua12
=ar37
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
