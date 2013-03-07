From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Thu, 7 Mar 2013 18:41:49 +0200
Message-ID: <20130307164149.GA16548@arwen.pp.htv.fi>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
 <Pine.LNX.4.44L0.1303071101190.1646-100000@iolanthe.rowland.org>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1303071101190.1646-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 11:01:47AM -0500, Alan Stern wrote:
> On Thu, 7 Mar 2013, Felipe Balbi wrote:
>=20
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
> Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
>=20
> for the EHCI changes.

thanks, added your ack to the patches.

--=20
balbi

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROMNNAAoJEIaOsuA1yqREbyQQAIFYccU0inPdvI5GN2p4t1VO
M9oexdwowW22Ogcw/CMYTFUcIYgZz+6SWYIFiCZpu5lKxdsWxPGjQxlWx97DQQNu
Ad8HGEMu29/ghlW+J4Ajhf3ATLcJjZI3lny1U1R98vMs6GIO8MgCsoApnoiXcvGG
fgxI4D8uW61ImIhIX4fwCH33mXn/b759sFP7V2TeGRCuFb2tVFvL/Wa11mtCF9bL
5to1srypqlmtZUEVpeVL2XyPK4S/5IY5D+d0chRU2n9qvAAicOE2YFtCy+JOLUw4
Pz+9FViVVfpvMOGqHNPOh4qzxE4TjydYhTmB/2i59ABEozfpBK2xqxEsS0SEKeLk
ejZRjBu2ffSgY7EAzijwznUo2Aa+zX6fQoTzQ3nLM972IWt0vmkbpjcYSa6tN9WZ
+yHHsSHqT+WdQNIIZx2FirlP/Jld8DNftDHoiRK+jQ8rrTZEKY0XhPpIFFFdgcbS
i1KOZed7pXkAXKTQLg6MUaFgxFPg9iTk0X0cN7Fo+w7lPERicyqCvtaSXEFgqGSY
rRkVCF7rxyxKTSjmDPSrvheEO+BE57TuxREPspTMSVyrZIuVLcrH6p/Ymhhpunf7
HJPsGfAJ61cs0e0Ks5yDyZOxiwK1iFblgGLt0VDFgseJhk5kOF1ZfuYbebh/U3ha
3V1KVzBpxdV7UWuK8vSx
=6z/b
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
