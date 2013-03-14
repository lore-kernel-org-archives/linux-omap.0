From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 4/4] usb: otg: twl4030: fix cold plug on OMAP3
Date: Thu, 14 Mar 2013 17:49:02 +0200
Message-ID: <20130314154901.GB3001@arwen.pp.htv.fi>
References: <1363242239-1061-1-git-send-email-kishon@ti.com>
 <1363242239-1061-5-git-send-email-kishon@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363242239-1061-5-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2013 at 11:53:59AM +0530, Kishon Vijay Abraham I wrote:
> Having twl4030_usb_phy_init() (detects if a cable is connected before
> twl4030 is probed) in twl4030 probe makes cable connect events to be
> missed by musb glue, since it gets loaded after twl4030. Having
> twl4030_usb_phy_init as a usb_phy ops lets twl4030_usb_phy_init to be
> called when glue is ready.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>

likewise. The other two I have taken

--=20
balbi

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQfFtAAoJEIaOsuA1yqRE1+8P/1t5C+bVacIIXmTgxWQycxiF
pJ0/FsY0uBSdMDA9LP3WvBtt6kqZ2FS37nnfsbf/8zpHZVG+B5Wck1K6QveHm7nm
LIKxWEvc46fE8ZICx2TR09wam/crpD0vn0eiAj06F1UR93r9iy6Ia3AWvuy4D49c
2NuMH9WOEC9+vL6mlFJS4qcIwTSnyKnv4iqhFVbaAK9/buFHXdItNbxfs45vhSwd
VsBbNKGwp/rSrU8biji+Wcr5p5GLSJ7XF5VbSB6HM2Dg25NKGoPlvYre8TWSFw6+
VxgrrO1lNbEF7t+DbveHvj5Wz6Md/dSRfzeUfD/Tl05QOHIZlgO3Ugv8xpB6eXZg
NUiH8hIhWpncXk5DuCn/JuRGCNVSNXXGZDahI17V77s/DpZTmz6s8yiFuaRlUyT+
8oqvWzvU3yPqhOVw23LtScAZZxDMS+zlCzUoaepFSBKq9D0hn1x7lWoSlNz5ZdCW
ub51Xm5iLt80qu7Yrtq3lngYL5+s5aVFKRIpM4qHvfpZ2ueD3BN0f3/2xPjyDrIc
LIhiZ8UXt5OzkjZxhTYJzuQPAdJcOy5T98Z+06DucBwrc9zYRNl4Hvs4Yew/GiHp
pJtgR27VgTUiWNvHm10+0lDSn7s4oZDr6sXemjVRy4MmIm3UBRux1kwXgCU8BPkV
VmaG7yJ99JbGNx+OlXE+
=EbxY
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
