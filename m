From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 06/16] mfd: omap-usb-host: cleanup clock management code
Date: Mon, 26 Nov 2012 22:02:42 +0200
Message-ID: <20121126200242.GA15259@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-7-git-send-email-rogerq@ti.com>
 <20121121133913.GH10216@arwen.pp.htv.fi>
 <50B38765.5070901@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50B38765.5070901-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 26, 2012 at 05:14:45PM +0200, Roger Quadros wrote:
> Felipe,
>=20
> On 11/21/2012 03:39 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Nov 15, 2012 at 04:34:04PM +0200, Roger Quadros wrote:
> >> All ports have similarly named port clocks so we can
> >> bunch them into a port data structure and use for loop
> >> to enable/disable the clocks.
> >>
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >> ---
> >>  drivers/mfd/omap-usb-host.c |  208 +++++++++++++++++++++-------------=
---------
> >>  1 files changed, 101 insertions(+), 107 deletions(-)
> >>
> >> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> >> index 23cec57..7303c41 100644
> >> --- a/drivers/mfd/omap-usb-host.c
> >> +++ b/drivers/mfd/omap-usb-host.c
> >> @@ -76,6 +76,8 @@
> >> =20
> >>  #define	OMAP_UHH_DEBUG_CSR				(0x44)
> >> =20
> >> +#define MAX_HS_USB_PORTS	3	/* Increase this if any chip has more */
> >> +
> >>  /* Values of UHH_REVISION - Note: these are not given in the TRM */
> >>  #define OMAP_USBHS_REV1		0x00000010	/* OMAP3 */
> >>  #define OMAP_USBHS_REV2		0x50700100	/* OMAP4 */
> >> @@ -87,14 +89,15 @@
> >>  #define is_ehci_tll_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_TLL)
> >>  #define is_ehci_hsic_mode(x)	(x =3D=3D OMAP_EHCI_PORT_MODE_HSIC)
> >> =20
> >> +struct usbhs_port {
> >> +	struct clk	*utmi_clk;
> >> +};
> >=20
> > I rather not since this will make it a lot more difficult to use
> > pm_clk_add() :-s Also, this sort of thing should be dynamically
> > allocated anyway ;-)
> >=20
>=20
> Why do you say so? The whole point of this patch is to group similarly
> named clocks so that we can use a for loop and set number of ports (or
> clocks) dynamically. I suppose it would be just a matter of replacing
> clk_enable/disable() with pm_clk_add() later, right?
>=20
> If you see patch 11, we are adding 2 HSIC related clocks to this
> structure. This means 9 clocks (i.e. 3 clocks for 3 ports) can be
> managed using a simple for loop instead of coding each clock name by hand.

that's usually not what you want, actually. You want clock management to
be explicit so you can have micro-power optimizations. I fear that the
time omap-usb-host.c gets *truly* stabilized and we move to more
aggressive PM, we will undo these changes just to have a more granular
control of the clocks, at which point your patch would be rendered
useless.

--=20
balbi

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQs8riAAoJEIaOsuA1yqREVvsP/16bJdMSbejQjecQgihHp1/d
KqkVENxqZreUKiN0m71Ju4aZqUOM+oEPCvGw9lbhPuRcxrqC7Cc/TkLMHZU10owD
66q8/CW7eo/fpdeGaOcSmZB7MN9mHg0HvNOMPBi87KH08vaCOzZFC4hssrPPqTKC
wC+EFiDRmsa/AQBvKcV3G85HaLfUUtIA6oSyRzBoAn5MdeLmeSrf9WzGrH67NbF/
Ak1+AGdt9U8UR6aJzrh+OfEKFN46in4NEd8UNOLbrChY3dNr9SWDKqEueWbSDLf4
/eMNFMK/MU4dZbbw3HxIkv9szLrFLgWncvDNg8Zu9D7i2bmHccedi3mTOyAYRd0F
KRwq3tTT43lWWGlCydhZoMOXFslsatnBPtIzgEn0RD5/3Ebzj+ShBNvDWYaOvsxV
yTxBevEf+v8ipYeL1wWqDB8qt8uieLMHgfzCll/uCpD5MfKZ6qNyXzu0vQY3zIZM
NF2iNNOI3U12VXlBQ8t0pMzf93K6UFGrStvsiYtgchyEXV3nBKrkPoWW9Zj5422z
qWHbg2T20TAZ38ZomuqqWguMeLZCTlNgbgTs61j1YMtMdiBPMRCiWgM7XzI40uQL
4oklvAPeHYRzGRsz6KgOcy4YF0Me3y/qgd+1EEeZ9f8GHrjCjE51axyw6GjBIBkl
I7SzneNOeiUToVJmmRY/
=Q9Ry
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
