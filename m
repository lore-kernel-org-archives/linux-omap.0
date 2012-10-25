From: Felipe Balbi <balbi@ti.com>
Subject: Re: Commit 4f3e8d263 breaks NFS root on Nokia N900
Date: Thu, 25 Oct 2012 21:59:00 +0300
Message-ID: <20121025185900.GA18473@arwen.pp.htv.fi>
References: <50898A82.4020403@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42725 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760100Ab2JYTEx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 15:04:53 -0400
Content-Disposition: inline
In-Reply-To: <50898A82.4020403@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Timo Kokkonen <timo.t.kokkonen@iki.fi>
Cc: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 09:52:50PM +0300, Timo Kokkonen wrote:
> Hi,
>=20
> There is something wrong with the USB since commit 4f3e8d263. I am no
> longer able to boot from an NFS root with that commit applied. The
> kernel boots fine, it appears to be able to mount the root over the NFS
> but then after that, the USB networking appears to hang. Reverting the
> commit in question makes USB networking fully operational again.
>=20
> The kernel config and boot logs are attached.

Roger, this is the second big regression because of that patch. I guess
it's best to revert that while you work on a better patch. Sounds good ?

--=20
balbi

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiYv0AAoJEIaOsuA1yqREMa0QALJgQNhtlDlGv7JSnywmTJlY
HdqMJ7mDwlk8bNVyZ6FUrXeAidpZpQzJobeVZRsAGasrTvPw9CF/7gMNykVA03z2
M/m5qXCnv+KZbDSg4NlnXxsz4lq2pq0zIKCOHiMMjjuR8gyFy9AdpcQt/yYhAZ2f
/JAh2v8UzOajyS00mubYs5f5Dany4oy6XpvgMZE/EDjVSnpZm0f2fbsRHGVK5B4U
QR2PKxWiFqmoZnWlUhyVD6gnN7SuYBbUOAWApScsQP5XTwJwQHWTswCS6OPF4vPB
Fm+Cxr9CzNyk9sqPnEiVbdDxaZhYuVak4hOJt/AJYMZrKCfbiVUcZEa1+i/ECH0v
YbV2mc5JTBraIsXE0vuVtzXJBGeFT2J1rAAmizTEyFIP8AVP2YQOqsFQlnXV8Me0
sL6eOCyhbBT42G8a43uZFcB70Z0N7RYL8rn6WZjEq4+26a8d9r9VNNb1HYr6n/CL
OqoYQnVcv4N0z7Unw1gd+kgX52xHa96sLgaLcCgCThGOa3YoqsIkzwroIGYjusmU
pkoc6i+i0IVJBxiRvOaDtcrL/E2s7+8fcZPyv7dYLGXUNKAAAHo12p9hExV/699V
drw17v1AfEy2HSf9ZMUTCJJy+k3TKBq8i8PVpx6l7gdTXNAxzYplQ1o5JzbOL2iO
cvNIWFnqotA/qi2XF19B
=iFEA
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
