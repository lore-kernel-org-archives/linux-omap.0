From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] usb: host: Allow EHCI_OMAP to be built-in when USB_GADGET is 'm'
Date: Fri, 01 Jul 2016 10:57:43 +0300
Message-ID: <878txloknc.fsf@linux.intel.com>
References: <1467276056-19357-1-git-send-email-rogerq@ti.com> <8760srgf00.fsf@linux.intel.com> <577525BF.3060509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <577525BF.3060509-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peter.chen-3arQi8VN3Tc@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> NOP_USB_XCEIV is used not only by gadget drivers but by
>>> host drivers as well e.g. EHCI_OMAP.
>>>
>>> commit 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-cor=
e")
>>> made it so that NOP_USB_XCEIV can't be built-in if USB_GADGET is 'm'.
>>> But this prevents EHCI_OMAP to be built-in if USB_GADGET is 'm'.
>>>
>>> Fix this undesired behaviour by moving usb_gadget_vbus_connect/disconne=
ct()
>>> to usb/gadget.h so that NOP_USB_XCEIV has no build dependency
>>> on USB_GADGET.
>>>
>>> Retain the original Kconfig behaviour i.e. NOP_USB_XCEIV is selected
>>> by drivers that need it.
>>=20
>> no, this is the wrong way to fix this. NOP _has_ a dependency on the
>> Gadget API if it calls Gadget API functions. Dependencies are proper.
>>=20
>> Maybe the reason for the problem is that we ended up adding far too much
>> code to phy-generic.c itself. Maybe it shouldn't know about clks and
>> interrupts. The original idea of that driver was to simply satisfy a
>> requirement to have a valid transceiver by some platforms. Maybe we
>> should fix that instead. Moving functions around to workaround a problem
>> is not the way to go, sorry.
>>=20
> OK but something that was working all these years is broken by your
> patch.
> Do you mind fixing it please? Or at least let me know how you want to
> get it fixed.

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2e710a4cca52..89fd095ca33d 100644
=2D-- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -180,7 +180,7 @@ config USB_EHCI_MXC
 config USB_EHCI_HCD_OMAP
        tristate "EHCI support for OMAP3 and later chips"
        depends on ARCH_OMAP
=2D       depends on NOP_USB_XCEIV
+       depends on USB_PHY
        default y
        ---help---
          Enables support for the on-chip EHCI controller on


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXdiJ3AAoJEIaOsuA1yqRE2wgP/jGOPEHYngwsszx06gk84ooE
OmSkP8oYjeFm+5Y/O3EOUuntIFG5KFN8TpSvIjR4wEXy2k8VY/N6yutn1uPDyCYi
Bu86/WLZ60jt+JsXZs31Zcaj7zuQd63bXL9Uss3Bz2dwn/o9bzCaWT/EqwWFplg3
ZyOsYMeUuY08JnUOWSGfQ5S5hdvEveegUrQcgetFEVT2CrNH7vVslDuuWKWcoPGq
Z5mDsq3mL6Ypj+ifeIEwxbyPrF/7dm4s4J+xd7/+nohx4r8SP996ryQaKtNFw2pf
oszSs4nMVeSJQaEPVwPebk5fKXSSdFm5vlpUzuOESYBQooJEpU7db95hNtYi/Wny
BMJR5x+eA51oNDPLASgDEUsBg3A4cHBioMJ2rFJfF3Nj9Kkmngz1dIdFuIlTKsQ8
VxtCsoicwIs+Y+JZoyimUJ6xS7hux+tGOoIqh2fZhO+kFDZtrVNgezOA7rxAND7S
RzvyrKBg1VmTszpAq6GqToijEohuOMLiXMnJKsIyEBlGtrwzNaxOQJnQ9ZELDNTO
Hxopunc6dH2IM8p25LdZtPs3zbra+InZ9l6kqOnhl7DX0wi5qz0cYxKSN8rSvVtG
feQVv2H8/kGvWyB1WvsrYfoZ4dwYvXujnItH5bnE0W+nS7C4ugiv+HU1CtRUas4T
b74jPECRKcXXqXptKYvR
=P87c
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
