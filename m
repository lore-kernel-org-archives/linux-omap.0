From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/4] drivers: usb: phy: add a new driver for usb part
 of control module
Date: Fri, 25 Jan 2013 10:45:01 +0200
Message-ID: <20130125084501.GI15886@arwen.pp.htv.fi>
References: <1359080391-5120-1-git-send-email-kishon@ti.com>
 <1359080391-5120-2-git-send-email-kishon@ti.com>
 <510218FE.8080606@wwwdotorg.org>
 <20130125074818.GF15886@arwen.pp.htv.fi>
 <51024581.6020301@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51024581.6020301-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Fri, Jan 25, 2013 at 02:12:41PM +0530, kishon wrote:
> On Friday 25 January 2013 01:18 PM, Felipe Balbi wrote:
> >On Thu, Jan 24, 2013 at 09:32:46PM -0800, Stephen Warren wrote:
> >>On 01/24/2013 06:19 PM, Kishon Vijay Abraham I wrote:
> >>>Added a new driver for the usb part of control module. This has an API
> >>>to power on the USB2 phy and an API to write to the mailbox depending =
on
> >>>whether MUSB has to act in host mode or in device mode.
> >>>
> >>>Writing to control module registers for doing the above task which was
> >>>previously done in omap glue and in omap-usb2 phy will be removed.
> >>
> >>>diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Docum=
entation/devicetree/bindings/usb/usb-phy.txt
> >>
> >>This file seems to be specific to the TI USB PHYs, not all USB PHYs;
> >>shouldn't it be renamed ti-usb-phy.txt, or even better renamed to match
> >>the compatible value it documents, giving ti,omap-usb2.txt?
> >
> >could be, but that can be done as a separate patch. It's not part of
> >$SUBJECT.
> >
> >>>  add the address of control module dev conf register until a driver f=
or
> >>>  control module is added
> >>>
> >>>+Optional properties:
> >>>+ - ctrl_module : phandle of the control module used by PHY driver to =
power on
> >>>+   the PHY.
> >>
> >>DT property names generally use - not _ as the word separator.
> >
> >fair enough, Kishon, can you fix this up ?
>=20
> Sure. Will post a patch..

Great, notice that I've already applied some of your patches to my tree.

cheers

--=20
balbi

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRAkYNAAoJEIaOsuA1yqRETN8P/RwW++QD2qrz3hsfMWWY7ADt
VmBXAmAxE96ie8ZbLRLCtyvDpnfyWEJ6VyMYNJOUmEHXBssCAylk2XKnXOJV3fPV
bS1AoMMDfEAOVGYlovbTfaGRb09g2WiVP+1/8r/UXS/b/pP26qB85hFr+h1GFuqK
JMhyd6vZz0AyJvVPJ7StkPixbEF3p+emx6WuwGMn/xWp2O/4XsXiSj5qHuC2YCwk
hxoWFpCDP8ZdIOaVa+AAeMv1zueIV91t9RP6e9BRhGhSnkUiUbNNIpKOE9INgozS
v5EYPVUvbiaL1yGI2mUVP5hpANFyiVrwI4OA78exxrN6Mk7lKutnJzeq8WOf/C6a
7JvFn/yoDZlNDl6kfa18vRZ6vl4/qVKrw/m4T7+PjSnQru46ELq/l1KYNiuzgQ+Z
BOaRX+I8irxTGqcqLtjZag48UVH0FwSlp57gQsw2mfP2JIHsYz2mmTv5F/Fjg9m5
xToCqbRsGGFMwoaXXVfv0xo5Lxi9iZc6h0hlWkDT+cFkOvyrT+Npa6wyzJ6KIWjE
nDVKbnbotRVsH3hjepp9iWZK4zd81XqBUnlGzwdTKkzahjge1yYA9Wm1+PlCPOE7
HBiQ9YSc006AshFKseU9KLUKHA2qTb3vtbxTqKsxnX/lI7a8uq+dvjej/aEG+Lw5
XkBzuSkLatL29vvtyvNt
=DZtf
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
