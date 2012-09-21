From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 14:00:51 +0300
Message-ID: <20120921110050.GC16003@arwen.pp.htv.fi>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56319 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757242Ab2IULFj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Sep 2012 07:05:39 -0400
Received: by lbbgj3 with SMTP id gj3so3683731lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 04:05:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
> Overrun also causes an internal flag to be set, which disables further
> reception. Before the next frame can
> be received, the MPU must:
> =E2=80=A2 Reset the RX FIFO.
> =E2=80=A2 clear the internal flag.
>=20
> In the uart mode a dummy read is needed. Add the same.

Very nice patch but I think commit log can be a bit more verbose.

Please make the problem a little clearer. Why do we even get that
interrupt fired if BRK_ERROR_BITS aren't set ?

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - functional testing on omap4sdp
> - Verified idle and suspend path hits off on beagle.
>=20
>  drivers/tty/serial/omap-serial.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-s=
erial.c
> index a0d4460..bc22a2b 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -334,6 +334,13 @@ static unsigned int check_modem_status(struct uart_o=
map_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>  {
>  	unsigned int flag;
> +	unsigned char ch =3D 0;
> +
> +	if (!(lsr & UART_LSR_BRK_ERROR_BITS))
> +		return;
> +
> +	if (likely(lsr & UART_LSR_DR))
> +		ch =3D serial_in(up, UART_RX);

Maybe add a comment before this condition stating why this character
read is necessary ?

--=20
balbi

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXEjhAAoJEIaOsuA1yqREk98P/R+dIQBsrIe9WS/Jmg/bgrS+
I3VM0uyc0rZTwnpWpmxGuDIF3lw/U5mUWBJgdoGJZcZT61j+Mv3QkNrVoFlvn98h
oIHwl0PiLgcysEwTnaROcY6cVZ3j0HARFPp70g9Ps5KuUhx6KuAFGHtEKX416ii/
rDIj542aPnMjz33WjdE4k90yb4nb/qMMNpL5NhDiY1rkHxln01amoyrNkH4WBAmX
nnpbWxAOpM9BPaKUCtia0DTycMUNIapN5knAx5w4jozEgEVUJ/PcpwN8jhpVEp07
+ojObalP4C5yVCVaX+TzXZvdieuyXxCy/oXXTjNCHj4NJwMfZ6UjSZRY9Y6FfrwU
vtgUr3tv95JPq0qtw6mjkIabCOkU45VTCnja7CsbwHMcmHqi/lmpM/ArJigLI/vy
2IOuDYUKHC058i+OKSW23KdEnJ6gTnZqf/ddWk1HtFbWEIfrJJOF+QmRHiuxbcjI
xSguyj4Wszen185wkQ8dxDu1lrb7F2E8nlGt9eYcyp2wxe4spGyWHNH4A/Kia64x
7sbAMC6H+KT+WXS8M5rl6ikw1dq3C0SpG/2kgMhuJ6jenHg8h2Vgrjp1UODEGivc
5EfNWh7snppq/ZUO9kzOeqoljyrXl74GlxYJngTWAguc28Ca1ddpsAyUp2pU/dFE
NKdTZ4xMy6VYtbeosh9f
=YvNV
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
