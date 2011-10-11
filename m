From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
Date: Tue, 11 Oct 2011 12:10:56 +0300
Message-ID: <20111011091055.GE10155@legolas.emea.dhcp.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-2-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E739404ECA545E3@dbde02.ent.ti.com>
 <20111007085614.GD10910@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECB6B70F@dbde02.ent.ti.com>
 <20111010054435.GA31653@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404ECCE551F@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404ECCE551F-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 11, 2011 at 02:13:07PM +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > On Mon, Oct 10, 2011 at 10:40:55AM +0530, Gupta, Ajay Kumar wrote:
> > > Hi,
> > > > On Mon, Sep 26, 2011 at 03:21:07PM +0530, Gupta, Ajay Kumar wrote:
> > > > > > To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > > Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Balbi, Felipe; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org;
> > > > > > B, Ravi; Cousson, Benoit; Gupta, Ajay Kumar
> > > > > > Subject: [PATCH 1/6 v3] omap: musb: Adding hwmod data for ti81xx
> > > > >
> > > > > Felipe,
> > > > > I am planning to send patch 1/6 along with next revision of ti81xx
> > > > > hwmod baseport patch from Hemant so that all hwmod data gets
> > > > > reviewed at one place.
> > > > >
> > > > > So now only rest 5 (2/6 to 6/6) patches needs to be queued for
> > usb.
> > > > >
> > > > > I hope this will be fine with you. Let me know if you want me to
> > > > > post Same 5 patches separately.
> > > >
> > > > I guess it's better to queue them separately. I will only take
> > > > whatever lies in drivers/usb/musb
> > >
> > > Ok fine so usb hwmod patch will come from Hemant in his hwmod baseport
> > > Series. I will resubmit the one patch fixing your comment.
> >=20
> > ok cool, tks.
> >=20
> > For you platform_data stuff (if you have any), you can add a header to
> > include/linux/platform_data/musb-dsps.h
>=20
> I need to access "struct omap_musb_board_data" and so would add
> "#include <plat/usb.h>" in new file drivers/usb/musb/musb_dsps.h.
>=20
> Any comment ?

It would be nice to move that platform_data from <plat> to
<linux/platform_data>

--=20
balbi

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOlAgfAAoJEIaOsuA1yqREKRkP/Re6HiM2qUZuyeJ9mEg9ZXKy
DS/t25CQoHsCH+//06GLNKeTVFGa/oLYck7KGQ0/MTrUyz5q/LUwg1rSe0zVkEb9
2aDFQOe9K5wwDXV+IYKg2CqySStR92cWPNkUuFdZrTiFy/9IpoLKPOFLA7mv2QQW
TzRjHHFYtKKkGgPcOxF1tSbjjSJb06jkGK0ZKdWVKtMw0K14yjn5ylAZMbN/kSyC
98afA8FapmUNeW1cj0fWqSICxLq8ZNzezrOJsat7A8/oMIwi6JQ/wMUlEXH21h7T
uxGjfrZi/XWS7Ew91FGt1wHBwWRZ32nhWdbp7cmAghGs+eumdjI1cobN5UlEQQ3a
snHDIwe01z57Lpc897wOOXuMhBc4ARoy3YQAh2tYGWyUcuO26wt7vJbZCRcALD1c
DzicnjZTUUuTGmUJCudC5zicpxU6gFcawmeDiNghV1gvTMHVArWAhMGBfPnvVtha
1vvUvxPrM6W2Sscg+EbfXrJvSf8WiuaB8/PLq6dQf9Ffgrv81MBH2CXyLoFBEx8C
pQiBquxWjZcBBH2TXXg7VfODqJO2CU+NOvod5mxQvuVqCQyJrBd2GUE6JYKGCemI
Ldu/mF5QkLCLrMvxhz7kcIUS+0VMgXapkOGOHj7VWDIAHEIKlb8S3su02VSCuYo6
UZ5B9uZ7tqOlAgZ+pIQh
=R4qI
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
