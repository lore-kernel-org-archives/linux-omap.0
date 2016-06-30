From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] usb: host: Allow EHCI_OMAP to be built-in when USB_GADGET is 'm'
Date: Thu, 30 Jun 2016 13:14:39 +0300
Message-ID: <8760srgf00.fsf@linux.intel.com>
References: <1467276056-19357-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467276056-19357-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: stern@rowland.harvard.edu, sre@kernel.org, peter.chen@nxp.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> NOP_USB_XCEIV is used not only by gadget drivers but by
> host drivers as well e.g. EHCI_OMAP.
>
> commit 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-core")
> made it so that NOP_USB_XCEIV can't be built-in if USB_GADGET is 'm'.
> But this prevents EHCI_OMAP to be built-in if USB_GADGET is 'm'.
>
> Fix this undesired behaviour by moving usb_gadget_vbus_connect/disconnect=
()
> to usb/gadget.h so that NOP_USB_XCEIV has no build dependency
> on USB_GADGET.
>
> Retain the original Kconfig behaviour i.e. NOP_USB_XCEIV is selected
> by drivers that need it.

no, this is the wrong way to fix this. NOP _has_ a dependency on the
Gadget API if it calls Gadget API functions. Dependencies are proper.

Maybe the reason for the problem is that we ended up adding far too much
code to phy-generic.c itself. Maybe it shouldn't know about clks and
interrupts. The original idea of that driver was to simply satisfy a
requirement to have a valid transceiver by some platforms. Maybe we
should fix that instead. Moving functions around to workaround a problem
is not the way to go, sorry.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXdPEPAAoJEIaOsuA1yqREfxMQAIO7v0ws+pGhxC5VO4GccsS3
GDn8hoYUrGAjkADAuXgYnIKc4w9+Aoz0B0uHLU1yYisw9cablS09GXs0BvncVX33
Fe0CFkaOMXCwm5G81GTNhi/q+W8PrVNvc15nXQCex1TxZQbcDFXnu/ujb8Jl+XIV
XLGh/r2BYa6iWHLoUXsWl6lAMclfyPTW8tyfoIZNa+O5lmftPE1CSN52acdr1Bgq
PUYvd/scigZk/SemSl+qs20aYTG3qX9SLTD49JTHjUJa99Ne5zgaKEbnUmJzu2JL
3sytEfZ5dQZdU7k2/3focE5M0hARWppKKmdulJaK6JW3nhkEyEKbwJ0iVBhGYeDk
xLaPz9ZWuP7CSrpSsoBw6/c3W8Sz6IlA1nH5PBSgTtLrGxeU/IIqkJNr/K6SIsY4
SCnTsJThTWVfs23jpC4lWDzhF9I+c/Dyh+wRHD/hlQzDhQZ10yo+wbebAlApCkeZ
biOXfIVC/f4S6l43+2jK1b7sSDEiVzFIFct10vppVxq7SPn1f4bKYlxe/HIIFAlB
Ee87FCguJXxghTbndr4/uWncBpH498SPjqrgokCEFyyap5F2uNAm2DJ7fWmjG+F5
SV9OAJboYt2+8DKRdOVFl/jmoR6jQjy7iED9HEMJDdmI1IKolbWQigQLsJz8fed5
opcujT5IzXuuMryYfZ+y
=UfgK
-----END PGP SIGNATURE-----
--=-=-=--
