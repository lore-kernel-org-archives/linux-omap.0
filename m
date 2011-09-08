From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: omap2+: save and restore OTG_INTERFSEL
Date: Thu, 8 Sep 2011 11:02:59 +0300
Message-ID: <20110908080258.GE7707@legolas.emea.dhcp.ti.com>
References: <1315356573-1057-1-git-send-email-vikram.pandita@ti.com>
 <1315356573-1057-3-git-send-email-vikram.pandita@ti.com>
 <4E674CD2.6050800@ru.mvista.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4E674CD2.6050800-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 07, 2011 at 02:52:02PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 07-09-2011 4:49, Vikram Pandita wrote:
>=20
> >From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>=20
> >we need to save and restore OTG_INTERFSEL register
> >else we will be unable to function on resume after
> >OFF mode.
>=20
> >Change-Id: I6c29c69596d5f47e00cf74ab0e32bb44ef71dda9
>=20
>    Remove this, please.
>=20
> >Reported-by: Devaraj Rangasamy<dev-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
> >---
> >  drivers/usb/musb/musb_core.h |    1 +
> >  drivers/usb/musb/omap2430.c  |    6 ++++++
> >  2 files changed, 7 insertions(+), 0 deletions(-)
>=20
> >diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> >index b3c065a..3259a6b 100644
> >--- a/drivers/usb/musb/musb_core.h
> >+++ b/drivers/usb/musb/musb_core.h
> >@@ -311,6 +311,7 @@ struct musb_context_registers {
> >  	u8 index, testmode;
> >
> >  	u8 devctl, busctl, misc;
> >+	u32 otg_interfsel;
>=20
>    Shouldn't this be encosed in #ifdef?

Actually, this is part of the OMAP wrapper, so it would be better if you
would, instead, take care of this in omap2430.c.

--=20
balbi

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOaHayAAoJEAv8Txj19kN1oFoH/iGgE0zJX6K4kLgImBKM1V71
NJ+GugN4KIRGAZMkOu9Wsuos92N83vL0Mt98ha7/Ndo4nunbeHEwCYc6XPu/6JJn
3LzZlqgNAd+dTUhi4sq12LpC2ihcYCmGudPVIKD7hhtHW9HN7m2MCGxmIukQ8Ii8
xrOujelnmhX6nFlKkFcIn7ZAUdLKoWoZYigHyepaonNPOEGVit1jOVhIWiVCf4PL
n/Co7W0migzv8E9D9F1GdADEIk/E2judLhug1p/90Nh+18D63psXWCBMXEQ5qgqb
JkddB5Ptwo8oI1cQUyPLggotvLGYHz/sKnfB2jC8hML2oP6s4tHKgeR/T1NxbsQ=
=QEV0
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
