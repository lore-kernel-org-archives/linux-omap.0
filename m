From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2 1/6] arch: Change defconfigs to point to g_mass_storage.
Date: Tue, 6 Nov 2012 22:32:26 +0200
Message-ID: <20121106203226.GB6291@arwen.pp.htv.fi>
References: <cover.1351715302.v2.git.mina86@mina86.com>
 <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.v2.git.mina86@mina86.com>
 <20121106113157.GE11931@arwen.pp.htv.fi>
 <20121106184117.GJ6801@atomide.com>
 <20121106184227.GK6801@atomide.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121106184227.GK6801-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Michal Nazarewicz <mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 10:42:27AM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [121106 10:41]:
> > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [121106 03:40]:
> > > Hi,
> > >=20
> > > On Fri, Nov 02, 2012 at 02:31:50PM +0100, Michal Nazarewicz wrote:
> > > > From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
> > > >=20
> > > > The File-backed Storage Gadget (g_file_storage) is being removed, s=
ince
> > > > it has been replaced by Mass Storage Gadget (g_mass_storage).  This=
 commit
> > > > changes defconfigs point to the new gadget.
> > > >=20
> > > > Signed-off-by: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
> > >=20
> > > I need more Acks here. Only got one from Nicolas. Anyone else ?
> >=20
> > For omaps:
> >=20
> > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>=20
> Heh I guess no omap changes there, so probably not
> worth adding then.

omap1 is old, but it's still omap :-)

 arch/arm/configs/omap1_defconfig                   |    3 +--

--=20
balbi

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmXPaAAoJEIaOsuA1yqRE9UQP/3RM3dy40elQrZz+oU6HAlOb
UDXZh26hgc1SxfhuhwrteQow9zoUndtvLD/3hRc3j1UDBdI2HK85FzKf6pqBb/WW
fPCaJN1KO9Q66NwT20jLq6ic05XQOUiYU2O0cXg8Z8YdqeYUDvTa7o6VLsDzGiaJ
xeUH9RTfw5k6yYLk7iGNqvTf6JI+Q9Zw4o5J8U0opto08CHg5gjbKUNcVYT+FSpU
dlewlDSBmbZiPb1xfaToAEfIV+24jl40xEbzQcL20MyPz9u21B6BSEXCtptH22ep
Nv+rVq+9yotbM9/KIGzfV6z1YiF5tPO+oS2hgl9PB7DbBWUHmAe8bfSaaNKRBxw3
EsugS4ZS7IL1kPbzDgp/r2aeHzJo9UTiijd49WEkPyO6uK393ZcqR4oBY/kVhWY9
uVKpNMl9Gd+JWoGdYieubBT2SCIleJFWlHPVoANvu7aKPVH/ieXJQIozvLb+faMU
bQrzEBYemAOm31yMuJTgTi4MtJNj58nJlgydhqwvsbthD7zrygGgmbyyhd/Ml4Y4
l9LEYrDYJx6gS7/OT2U1C4yDUCg9mIj2hnBdG834ozlrjDvUHff6Sbf8vW2uXJIP
QLaM+19ZCERJ1GqX5Tpw15lBYjCULTZpItXM+qEYuqeqxE5Ef0EuD0j2tebxHHdq
FBTM74u2n9bpoLjwLO7a
=/Tqm
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
