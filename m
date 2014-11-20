From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 01/15] clk: divider: replace bitfield width with mask
Date: Thu, 20 Nov 2014 11:59:51 +0000
Message-ID: <546DD7B7.3070408@imgtec.com>
References: <1416438943-11429-1-git-send-email-james.hogan@imgtec.com> <1416438943-11429-2-git-send-email-james.hogan@imgtec.com> <546DCE53.8020004@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3ECPGSX0RDXLFldwTNVnnLIWWLTDQlT6G"
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <546DCE53.8020004-l0cyMroinI0@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--3ECPGSX0RDXLFldwTNVnnLIWWLTDQlT6G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20/11/14 11:19, Tero Kristo wrote:
> On 11/20/2014 01:15 AM, James Hogan wrote:
>> - Updated assignment of clk_divider::width in imx, rockchip, st, sunxi=
,
>>    ti clock components to use mask instead (not tested), using the
>>    following semantic patch:
>=20
> Hi James/Mike,
>=20
> This patch currently causes a build breakage with omap2plus_defconfig.
> Reason being you are modifying the clk_divider struct, but not touching=

> the code under drivers/clk/ti/divider.c which uses it. The fixes are
> basically the same you have done for clk-divider.c, the contents of thi=
s
> file are mostly just copied under TI clock driver.

Thanks for pointing that out! I'll fix and improve my grep-fu to find
other such cases.

Cheers
James


--3ECPGSX0RDXLFldwTNVnnLIWWLTDQlT6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUbde+AAoJEGwLaZPeOHZ6MuUQAJxW+C52BeSeukxmk6+p+CJG
z/ww0Y3o6b/XUJnQARxHvkkDX/Kh/YKAtQSoySSgTOceeZHHPsDD7mHMZvCk9Av3
yV9p8agyWUZ756OA9KFYBODaE8whAxExZBOEG550ZWlbeHXQpyqdYTWGyY6NaITC
9jc8zq+2BomJaYhCWO29X+GW/xcetAYhtOBpf2IPw17E3JNSS2KTizvvzjzZz+17
z2LV8LyaYhzMgeSiZcFh7z6QZMI+qY8ZArgZRP95KW91l2oeFjzmhWzO3gZUqg4o
/f8qWD+Z9zV2coKZvPPiie0r3s8mzxA6pxq/OUtrDaSX2sghuugWY7fGnHjOwH7c
MYztsc9UDIGNp3JEhUOps5gKM0slauvavDCzrY3Y9+5HGlwplGZkAJJAZEGn9Ln1
dm4CkEeTC8oKgaJYD6zgS0k9squZZZY1cL+XgMxX6vywitsL6JIpHYwJzs3/a1JA
wZIOl589UNoOLYt0JRtJ8ANG8JIylEhuLPwePJ5CrvD6x9A49my/pp9VwoRtyEiM
ouiDlL4ZVAHisX2VYFO/hKJ61OGXr52Oiw1lhkBaDGHc9ZRwS4KSbYvBJoBr1E36
671Vms+ggm3gGgmtgcdwUMla9WtLGLl8txOCMT862SA/GY/uuxKUmwzx1dxf2cjY
vd8AXLD4GY7fpDhcqg5W
=QhCs
-----END PGP SIGNATURE-----

--3ECPGSX0RDXLFldwTNVnnLIWWLTDQlT6G--
--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
