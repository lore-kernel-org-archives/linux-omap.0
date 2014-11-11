From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: phy: fix twl4030 build regression
Date: Tue, 11 Nov 2014 08:52:17 -0600
Message-ID: <20141111145217.GB25615@saruman>
References: <7831012.jlbEUURqIo@wuerfel>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7831012.jlbEUURqIo@wuerfel>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2014 at 10:36:09AM +0100, Arnd Bergmann wrote:
> Recent changes to the common OTG handling broke building the twl4030
> OTG driver as found during an allmodconfig build of linux-next:
>=20
> drivers/phy/phy-twl4030-usb.c: In function 'twl4030_set_peripheral':
> drivers/phy/phy-twl4030-usb.c:609:11: error: 'struct phy' has no member n=
amed 'state'
> drivers/phy/phy-twl4030-usb.c: In function 'twl4030_usb_probe':
> drivers/phy/phy-twl4030-usb.c:679:12: warning: assignment from incompatib=
le pointer type
>=20
> This applies the same changes that were done to the other phy drivers
> to get it to build cleanly.
>=20
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Fixes: 19c1eac2685b6 ("usb: rename phy to usb_phy in OTG")
> Fixes: e47d92545c297 ("usb: move the OTG state from the USB PHY to the OT=
G structure")

on my testing/next already:

commit 7e1bbeb4292783dcc079156b8fa08d66d17219e0
Author: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Date:   Fri Nov 7 19:43:45 2014 -0600

    usb: host: ohci: omap: fix build breakage
   =20
    commit e47d925 (usb: move the OTG state
    from the USB PHY to the OTG structure) moved
    the OTG state field from struct usb_phy to
    struct usb_otg but, even though I fixed many
    other build breakages, I still missed one
    on ohci-omap.c.
   =20
    Fix the build breakage now.
   =20
    drivers/usb/host/ohci-omap.c: In function =E2=80=98start_hnp=E2=80=99:
    drivers/usb/host/ohci-omap.c:186:19: error: request for member =E2=80=
=98state=E2=80=99 in something not a structure or union
      hcd->usb_phy->otg.state =3D OTG_STATE_A_SUSPEND;
   =20
    Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index cf89b4b1..3e5df5a 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -183,7 +183,7 @@ static void start_hnp(struct ohci_hcd *ohci)
 	otg_start_hnp(hcd->usb_phy->otg);
=20
 	local_irq_save(flags);
-	hcd->usb_phy->otg.state =3D OTG_STATE_A_SUSPEND;
+	hcd->usb_phy->otg->state =3D OTG_STATE_A_SUSPEND;
 	writel (RH_PS_PSS, &ohci->regs->roothub.portstatus [port]);
 	l =3D omap_readl(OTG_CTRL);
 	l &=3D ~OTG_A_BUSREQ;

--=20
balbi

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYiKhAAoJEIaOsuA1yqRErsYQAI02xqcwGFiZIF3qz/ArzPYg
IS+A6LwpVZ3VbC8cOH0fXztv+N7rPsX1C0L5KZEnsK9c+N9+dTJa1ctY9XqYtYOy
hAunR9spwEu/6wgevg6ATa6Pe5smkaLd+3n/ewa3x0ZSVUylKA12C8eI9WAmzV3O
sm7cX624AWe9427O+Zg3HSDSXZyxYEbnhRRJ6ZfcETGvdc5VSQZHxCSYPDnF2hAh
alnxNze0p2biWcVkk7hzFFf4KheZJUlR/VcRFIrmQs3isw0IOMLP6pEWbvzMIXwA
gPAWztVgOpok3jtsr7JpJC0TxN7EU/Lvk6xg1fFaTTzKuqOPnf2l+0c5IXiSDJVE
/BGRO9dWESfS3FxiRmkwQOl4/nPW68Lk4AC4AjDGI3rzyNYvyX88s2Nze0oZCy44
Stj/4HBIklBlwS1DXfkGglLtrwvTzyd/YvL89FXaNuXkEGgf+0Ri2TAI9Plbaf0L
uJH9a//R9ET8XglT+lL3/Wea3fjNuPfqojQpjXX7HvUO3uHuMhcIZltabaYJzmw3
bcgh2dX2xxsf990BJ8CF8cU9N3yDnbmu6THTZqqdzRYhgjfGxQAS7cWKUFoQKRaZ
JCRnQUnF0AwBwIZM/cWnZUw0MWRWz/62lQHOHMMHRNJFm/+PoOujnYBBKudjKzbs
eoSZ8pNbdhiI6Y76dHf6
=jxoo
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
