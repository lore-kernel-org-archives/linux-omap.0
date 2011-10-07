From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: musb: enable support for am335x
Date: Fri, 7 Oct 2011 12:41:24 +0300
Message-ID: <20111007094123.GL10910@legolas.emea.dhcp.ti.com>
References: <1317031393-9333-1-git-send-email-ajay.gupta@ti.com>
 <1317031393-9333-3-git-send-email-ajay.gupta@ti.com>
 <4E80582F.6030803@ru.mvista.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8cpS+6Cx+xtICsjy"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E80582F.6030803-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--8cpS+6Cx+xtICsjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 26, 2011 at 02:47:11PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 26-09-2011 14:03, Ajay Kumar Gupta wrote:
>=20
> >Enabled the flag so that musb_dsps glue file can be used for am335x
>=20
> >Signed-off-by: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
> >---
> >  drivers/usb/musb/Kconfig |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> >diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> >index d6abdec..4e21aee 100644
> >--- a/drivers/usb/musb/Kconfig
> >+++ b/drivers/usb/musb/Kconfig
> >@@ -8,7 +8,7 @@ config USB_MUSB_HDRC
> >  	depends on USB&&  USB_GADGET
> >  	depends on (ARM || (BF54x&&  !BF544) || (BF52x&&  !BF522&&  !BF523))
> >  	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
> >-	select NOP_USB_XCEIV if SOC_OMAPTI81XX
> >+	select NOP_USB_XCEIV if (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
> >  	select TWL4030_USB if MACH_OMAP_3430SDP
> >  	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
> >  	select USB_OTG_UTILS
> >@@ -57,7 +57,7 @@ config USB_MUSB_AM35X
> >
> >  config USB_MUSB_DSPS
> >  	tristate "TI DSPS platforms"
> >-	depends on SOC_OMAPTI81XX
> >+	depends on (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
>=20
>    Parens not needed here and above.

are we getting a revised version ?

--=20
balbi

--8cpS+6Cx+xtICsjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOjslDAAoJEAv8Txj19kN1T/8H/jLqrzxJYQTfi6ScDcqXlMp1
7fnZ+AtrOo++iQPWgio8S7NyO4QBTVQhiNs8m2cBgEUvVZvJhsQdpPgly3wzJSl8
vLL2fzGwpP2iXPrZzequHmlLsSsY3kcNKQA6ZvsJPrbNq3QW3BVMXZYcspoj9Rzf
y/YLcZ56KwXcQ3hw+U9aTu2mvEjQQuU7r62n28vtekv77tD3rYhLEDWKiWcjH1yB
f2wbRm2qpBBp8jP0qx81epzn/jfgE9jIAngg4yDwKRHfCGVrgDBfWdQs5A5vQUwz
9bJY3c02fN169Bj7nLUaTlzvha5sCvp6mkvfQsYMnMMRGwuHut4qWzY6tfgYQao=
=VB3O
-----END PGP SIGNATURE-----

--8cpS+6Cx+xtICsjy--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
