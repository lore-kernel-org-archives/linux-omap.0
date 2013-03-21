From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 5/7] usb: phy: twl4030-usb: check if vbus is driven by
 twl itself
Date: Thu, 21 Mar 2013 18:43:32 +0200
Message-ID: <20130321164332.GD15740@arwen.pp.htv.fi>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
 <1363544607-17634-6-git-send-email-notasas@gmail.com>
 <20130320130750.GR29659@arwen.pp.htv.fi>
 <CANOLnOOS6X95ijodL903zqLn3emNZ-rDX0xrxYQUXFJ1PR-PZw@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOOS6X95ijodL903zqLn3emNZ-rDX0xrxYQUXFJ1PR-PZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, kishon <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 21, 2013 at 03:42:46PM +0200, Grazvydas Ignotas wrote:
> >> At least on pandora, STS_VBUS gets set even when VBUS is driven by twl
> >> itself. Reporting VBUS in this case confuses OMAP musb glue and charger
> >> driver, so check if OTG VBUS charge pump is on before reporting VBUS
> >> event to avoid this problem.
> >>
> >> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/usb/phy/phy-twl4030-usb.c |   36 ++++++++++++++++++++++++++++=
+++-----
> >>  1 file changed, 31 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/usb/phy/phy-twl4030-usb.c b/drivers/usb/phy/phy-t=
wl4030-usb.c
> >> index 425c18a..87bf11d 100644
> >> --- a/drivers/usb/phy/phy-twl4030-usb.c
> >> +++ b/drivers/usb/phy/phy-twl4030-usb.c
> >> @@ -248,11 +248,31 @@ twl4030_usb_clear_bits(struct twl4030_usb *twl, =
u8 reg, u8 bits)
> >>
> >>  /*-------------------------------------------------------------------=
------*/
> >>
> >> +static bool twl4030_is_driving_vbus(struct twl4030_usb *twl)
> >> +{
> >> +     int ret;
> >> +
> >> +     ret =3D twl4030_usb_read(twl, PHY_CLK_CTRL_STS);
> >> +     if (ret < 0 || !(ret & PHY_DPLL_CLK))
> >> +             /*
> >> +              * if clocks are off, registers are not updated,
> >> +              * but we can assume we don't drive VBUS in this case
> >> +              */
> >> +             return false;
> >> +
> >> +     ret =3D twl4030_usb_read(twl, ULPI_OTG_CTRL);
> >> +     if (ret < 0)
> >> +             return false;
> >> +
> >> +     return (ret & (ULPI_OTG_DRVVBUS | ULPI_OTG_CHRGVBUS)) ? true : f=
alse;
> >> +}
> >> +
> >>  static enum omap_musb_vbus_id_status
> >>       twl4030_usb_linkstat(struct twl4030_usb *twl)
> >>  {
> >>       int     status;
> >>       enum omap_musb_vbus_id_status linkstat =3D OMAP_MUSB_UNKNOWN;
> >> +     bool    driving_vbus =3D false;
> >>
> >>       twl->vbus_supplied =3D false;
> >>
> >> @@ -270,20 +290,26 @@ static enum omap_musb_vbus_id_status
> >>       if (status < 0)
> >>               dev_err(twl->dev, "USB link status err %d\n", status);
> >>       else if (status & (BIT(7) | BIT(2))) {
> >> -             if (status & (BIT(7)))
> >> -                        twl->vbus_supplied =3D true;
> >> +             if (status & BIT(7)) {
> >> +                     driving_vbus =3D twl4030_is_driving_vbus(twl);
> >> +                     if (driving_vbus)
> >
> > how about just:
> >
> > if (twl4030_is_driving_vbus(twl))
> >         status &=3D ~BIT(7);
> >
> > ????
>=20
> I'm logging driving_vbus below with dev_dbg(), so that it's easier to
> see what going on..

is that really necessary ? Don't we expose it through sysfs already ?

--=20
balbi

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSzi0AAoJEIaOsuA1yqREFjsP/R7mV0kqvvPX5oOxIZKTa/Xz
kZi3X6Vrd6Cc+0t5BeU4nODPlp8tmA2JmJM63Ne5dFYvGiZXABc3GI+l2Td7m/BP
s25Ui5y6bjY9fA07tLp/QiB358CVLbVemBJPIQf5tvjQPkxQabr3P4Wp92t3Ep3w
MS+EKSCDLPHM540UxvbZ7xCGr+WHAVHstabqdZ3e+w1Bm0aVy1c3dNqo3MJakNXw
M4I7m7QMHshDgDecefDvdgHTPl+sW3gzf3NUd2hWM57I3VXZr42e6/ZNGFKFpw4N
3cqaR+QYqDsog0xI0DBv00RziMoPURrbWUKEwQe7q+icqWmf2IFzHEe4He+V5nbT
5fZd1odLwYOerK/dkUfcKHl26T4o+1cyu5PU1wuFo3bk6nAaJu+D726rbzMkxctA
VvJaHoS4FwuuOPk+w298LTzunPi6lBLvzfPegWqI9usIN5q6ToYgda1hYkOYZMPZ
Ih4/F3YyfW7ikhTOB63LB8fuxTxXHeqcC151INQI4RJpoBIXirzhKfFAR1+5Y+Fa
0ign2rBTfY7KofCOAOxOJ4h/lNXssl87uEB7HHIuh7/JCqS7Hx+tUd/YRGhbnKSp
cpnk1b9Og1zviv8i5hOnX3MMDVrT7B+4oHiI93zynd+s2V87YlHoLIAUQWDvNraA
DbPcyVw+NuqlBkTSwFhV
=ZKQt
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
