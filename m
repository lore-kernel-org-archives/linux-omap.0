From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: musb: dsps: fix build on i386 when COMPILE_TEST
 is set
Date: Fri, 3 Apr 2015 10:14:14 -0500
Message-ID: <20150403151403.GA5503@saruman.tx.rr.com>
References: <1427318317-13927-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39584 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbbDCPPT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Apr 2015 11:15:19 -0400
Content-Disposition: inline
In-Reply-To: <1427318317-13927-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Mar 25, 2015 at 02:18:37PM -0700, Tony Lindgren wrote:
> Commit 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with musb_dsps=
")
> fixed a USB error on dm816x, but introduced a new build error on i386
> when COMPILE_TEST is set:
>=20
> drivers/usb/musb/musb_dsps.c: In function =E2=80=98dsps_read_fifo32=E2=80=
=99:
> drivers/usb/musb/musb_dsps.c:624:3: error: implicit declaration of functi=
on
> =E2=80=98readsl=E2=80=99 [-Werror=3Dimplicit-function-declaration]
> readsl(fifo, dst, len >> 2);
>=20
> Let's fix this by using ioread32_rep() instead of readsl() as that's
> more portable.
>=20
> Fixes: 3e457371f436 ("usb: musb: Fix fifo reads for dm816x with musb_dsps=
")
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Bin Liu <binmlist@gmail.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Can you apply this one directly ? It fixes a build error on i386.

Signed-off-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/musb/musb_dsps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 2c0750e..8e089c1 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -661,7 +661,7 @@ static void dsps_read_fifo32(struct musb_hw_ep *hw_ep=
, u16 len, u8 *dst)
>  	void __iomem *fifo =3D hw_ep->fifo;
> =20
>  	if (len >=3D 4) {
> -		readsl(fifo, dst, len >> 2);
> +		ioread32_rep(fifo, dst, len >> 2);
>  		dst +=3D len & ~0x03;
>  		len &=3D 0x03;
>  	}
> --=20
> 2.1.4
>=20

--=20
balbi

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHq5GAAoJEIaOsuA1yqRE3zoQALWsYrrfpIFfCZ+WwaDXp0Ja
mJ55tTD8kDzVIcAw4Swx2K1jGWm7BWkVaaueLSFtgKSmk+Yey2pESc3knEOvMO9l
qPibTDaJG54LP//n1asEL7xWx4+Sji9/9DyHaFyWnFCD7FuCZzZmEadGXKmNxuTF
wTYU6ZoD3LxyrvpL+w4zOKiZg3sAyjchf8APaYA+/rUo9oF4D1F8ZoV9Pl743cIh
qSSdC+9019k76hAIher9NWuB+lrgBQYUvUQqmG8F0PDUb9SlDm1a0wnQhCK1gMtv
QrrKGdcJQYrFiD+nWBRvlSU7vsMF+ZWIQeP4t1boBkjqbL4y+pnb+vjFczXodrbl
okcIFvCAz2sYHD6wsI7vt4ghPIb8lXcIiJ5CkxNekBOB5qK9dlPow4A06A2xHsAI
d2NANU/bMUyPeVxU/2SsY+ljXa4HYVappsI4dsh9Ie8qtv1qb8CJR2QCEZ/yQtvc
6FcUq+sWEQurx+xa6mQitCS14KSnTCpfdreKY7SKAXuKo8IQYogJlOFgaGUWVXC+
OS967BkXvUfpqsULtU8pGTj64UDvdO9y3yXxQJQv2b8tQbLeEug6/k8iYr1wDl8r
ql/7ugJoKqG7oya13rxOpzJmTYchHTIjdJbb8Lr3ncLHZjdXK44FxDGCtEtnSMpo
hPiA4oo2oZ93Xmeh/Qw+
=kddj
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
