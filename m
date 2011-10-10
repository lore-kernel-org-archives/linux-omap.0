From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: musb: enable support for am335x
Date: Mon, 10 Oct 2011 08:45:12 +0300
Message-ID: <20111010054510.GB31653@legolas.emea.dhcp.ti.com>
References: <1317031393-9333-1-git-send-email-ajay.gupta@ti.com>
 <1317031393-9333-3-git-send-email-ajay.gupta@ti.com>
 <4E80582F.6030803@ru.mvista.com>
 <20111007094123.GL10910@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECB6B707@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404ECB6B707-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2011 at 10:35:15AM +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > On Mon, Sep 26, 2011 at 02:47:11PM +0400, Sergei Shtylyov wrote:
> > > Hello.
> > >
> > > On 26-09-2011 14:03, Ajay Kumar Gupta wrote:
> > >
> > > >Enabled the flag so that musb_dsps glue file can be used for am335x
> > >
> > > >Signed-off-by: Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org>
> > > >---
> > > >  drivers/usb/musb/Kconfig |    6 +++---
> > > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > >diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > > >index d6abdec..4e21aee 100644
> > > >--- a/drivers/usb/musb/Kconfig
> > > >+++ b/drivers/usb/musb/Kconfig
> > > >@@ -8,7 +8,7 @@ config USB_MUSB_HDRC
> > > >  	depends on USB&&  USB_GADGET
> > > >  	depends on (ARM || (BF54x&&  !BF544) || (BF52x&&  !BF522&&
> > !BF523))
> > > >  	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM ||
> > BLACKFIN)
> > > >-	select NOP_USB_XCEIV if SOC_OMAPTI81XX
> > > >+	select NOP_USB_XCEIV if (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
> > > >  	select TWL4030_USB if MACH_OMAP_3430SDP
> > > >  	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
> > > >  	select USB_OTG_UTILS
> > > >@@ -57,7 +57,7 @@ config USB_MUSB_AM35X
> > > >
> > > >  config USB_MUSB_DSPS
> > > >  	tristate "TI DSPS platforms"
> > > >-	depends on SOC_OMAPTI81XX
> > > >+	depends on (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
> > >
> > >    Parens not needed here and above.
> >=20
> > are we getting a revised version ?
>=20
> Yes, I will send the revised version with earlier set fixing your
> comment.

sounds great, tks

--=20
balbi

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOkoZmAAoJEAv8Txj19kN1DdkH/AmnYMEbAor2ov+UwTRhT1B1
V0caqsP1+nF2otbEtlpWW72UDxS9zlgGea54RiyYl+G+tmdFEhEGww2FZn8GtZ+A
0KQhszjGH0czaAFCpjXmElD95rxINudO6R6pUgyysoqm8uvOfaJAb+Bb9fAsRcqn
gHoz1kRNl/RuQs0gZZvNoRH9yRHopf+AgBOskPc+77d6nn0fZKskVl6GBEBHdOYy
bP4tq3GmM0RuG/NonO+G3zqNwd9D7tMGWNDkZrxcHoe1PicwDxzvxcXjg5jY1AC3
H8IVhPRPHt5pxbvCfiV16COP+LpkoWp+J0jspMgv5TP1aUSNKAvgRTKT8e9IyzE=
=/vvK
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
