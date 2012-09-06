From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/5] omap-serial: Request pins using pinctrl framework
Date: Thu, 6 Sep 2012 22:56:06 +0300
Message-ID: <20120906195605.GA32145@arwen.pp.htv.fi>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185832.1172.31013.stgit@muffinssi.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:59830 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758131Ab2IFUAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 16:00:31 -0400
Received: by lbbgj3 with SMTP id gj3so1406664lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 13:00:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120906185832.1172.31013.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 06, 2012 at 11:58:32AM -0700, Tony Lindgren wrote:
> Request pins using pinctrl framework. Only show a warning
> on error as some boards set the pins in the bootloader
> even if CONFIG_PINCTRL is enabled.
>=20
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
>  drivers/tty/serial/omap-serial.c              |   10 ++++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/pla=
t-omap/include/plat/omap-serial.h
> index 1a52725..0f4de14 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -106,6 +106,7 @@ struct uart_omap_port {
>  	struct uart_port	port;
>  	struct uart_omap_dma	uart_dma;
>  	struct platform_device	*pdev;
> +	struct pinctrl		*pins;

this won't apply to Greg's tty-next as I moved this structure to the C
file :-s

--=20
balbi

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSP/VAAoJEIaOsuA1yqRE1noP/ieocy6FemKw5oRNhgs6bfLq
sNjHjxjg77yVuwW2lWJv6IWa3J/9mqM5XaLwxbhFRwHQF6TWp3pyr3QsyfPrznT0
QtzwLrWoxJ7bFzJWanAmwF6DrJ9lZBDuk+PCN42mwGWVt54EerUjGZ+qKVPmVJOr
3meMMC86NVoaBXvQZLGCfZeA/I1cQcAVmC+m26r24Ft5MU5jeJPxYS4TjvWzOdKU
uARWZjQgVsl55yBnJmcTp5eL8AccnAqQhnjznp9PV1DTTuU7Rti671zsY3NcTuBP
5PPDfwuGWFCy0nc0mUaTabOAfo2nFZ0j9EWl6yKf1EP2AHs2VxF6PqJ3Xh0XVF88
RWZP8gE6Q2+xcnTnJ8pjdIPJ9IHG4AAm7ReL9I0S80/LksSLHxX2qEC+O6ITDPSM
RCObTiulN0E/xmP0wiiX0yweO/onu5msjGLeAXgtVGuQ0wh9Q3PeCnycCST7JLHP
sWYqSXLrtb6nf//Rs6W60Wokw5ewy3PBgaaTG0QjEXw8zJ6Z2xhYwwxy1UBzvp0D
12rBLRVhHFmcS3fpx4b1ngPLoRHeBEPHWCVHMCxPYi/nrRQJPjO/lfmnQ/edOfbT
kECW0x/Einrjzk6WZdm1FeI6KuMf6G3NYcfJv/aN5Vu+6KgUtTZhHZxyHmX1rNgM
TdJQjgDvpg3YruSp+piy
=tn7l
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
