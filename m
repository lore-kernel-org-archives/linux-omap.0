From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] serial: omap: fix the reciever line error case
Date: Fri, 21 Sep 2012 19:01:00 +0300
Message-ID: <20120921160059.GA9886@arwen.pp.htv.fi>
References: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348238239-18510-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2012 at 08:07:19PM +0530, Shubhrajyoti D wrote:
> This patch does the following
> - In case of errors if there least one data character in the RX FIFO
> read it otherwise it may stall the receiver.
>=20
> This is recommended in the interrupt reset method in the table 23-246 of
> the omap4 TRM.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> - Tested on omap4sdp.
> - pm tested hitting off in idle and suspend.
> - v2 changes update the changelogs.
> - Also remove the dummy check as FE , PE , BI and OE are the only
> receiver errors.
>=20
>  drivers/tty/serial/omap-serial.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-s=
erial.c
> index a0d4460..4fea16b 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -334,6 +334,10 @@ static unsigned int check_modem_status(struct uart_o=
map_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
>  {
>  	unsigned int flag;
> +	unsigned char ch =3D 0;
> +
> +	if (likely(lsr & UART_LSR_DR))
> +		ch =3D serial_in(up, UART_RX);
> =20
>  	up->port.icount.rx++;
>  	flag =3D TTY_NORMAL;
> --=20
> 1.7.5.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXI87AAoJEIaOsuA1yqREPz8P/1txQoZjbQsA1X2hPr+2yInx
/qvK8pCisKPt9PM3I4ArYT2eufVKmmCtbe/pg3NtpzxCGMAIF3tVEU4PMvc0ZUgg
XcDmY+b0LeIuFOiJTJAGqGmBmHb2ksNAqfqOV6ZxmisgcgDaTDHe9U80GxI7qaE3
ypDk0GFng9ExJ4yy+RyAQ36G9BPQ66qkLGTzF+JVVCsw8lC9oPkTVUCeMv8Uo0+2
JveF77E+5L3rKjQyhS8Xfcf1iZAVfOfOYmMrofDc6iNydQBSPGMPlKxNlFGvK5pd
lIOMYFd1xYS6mhbHXLaW5k/7erD3AUVH+XuYMN+7MjgnkatUzninpLupmE6k4tDT
u+b0o5C9F5x8tp9BNVVOY05O4aXT/3NIV1EPET4YR4e8vz1k4q1kjZqGlCaYimSR
RaShDQzNaLofFVMYbHp7MbtJjHGgiEwP9EfceCziEssAVn+H7o8qU03QzAFyyAQD
9RMZJ93SkV7lo6Qif/jF66rrfHayqOip3YHrOJryMQn3qEOk+mG5k4GD0bbS9gqC
eYcULuMvrV8ze6JmZT7a1+2LKEK9NXXXGmmt7sVT8HO43BCSCH3x6k3Ln6vXK9ov
lg209vDN3rD22SLdX9cV5g3JI8QkeQKVpTkcF2KeuCmUNIs1eO1N7u5Oe7UnhhjV
uZ1zPiGhdH2jOgrUK8qc
=qT+m
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
