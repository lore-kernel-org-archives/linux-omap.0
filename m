From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 5/5] omap-serial: Request pins using pinctrl framework
Date: Fri, 7 Sep 2012 08:26:14 +0300
Message-ID: <20120907052613.GA3136@arwen.pp.htv.fi>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185832.1172.31013.stgit@muffinssi.local>
 <20120906195605.GA32145@arwen.pp.htv.fi>
 <20120906211725.GQ1303@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58603 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751530Ab2IGFaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 01:30:39 -0400
Received: by lagy9 with SMTP id y9so1605159lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 22:30:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120906211725.GQ1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 06, 2012 at 02:17:26PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120906 13:01]:
> > Hi,
> >=20
> > On Thu, Sep 06, 2012 at 11:58:32AM -0700, Tony Lindgren wrote:
> > > Request pins using pinctrl framework. Only show a warning
> > > on error as some boards set the pins in the bootloader
> > > even if CONFIG_PINCTRL is enabled.
> > >=20
> > > Cc: linux-serial@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
> > >  drivers/tty/serial/omap-serial.c              |   10 ++++++++++
> > >  2 files changed, 11 insertions(+)
> > >=20
> > > diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm=
/plat-omap/include/plat/omap-serial.h
> > > index 1a52725..0f4de14 100644
> > > --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> > > +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> > > @@ -106,6 +106,7 @@ struct uart_omap_port {
> > >  	struct uart_port	port;
> > >  	struct uart_omap_dma	uart_dma;
> > >  	struct platform_device	*pdev;
> > > +	struct pinctrl		*pins;
> >=20
> > this won't apply to Greg's tty-next as I moved this structure to the C
> > file :-s
>=20
> Hmm the tty-next fails to build right now for omaps:
>=20
> drivers/tty/serial/omap-serial.c: In function =E2=80=98serial_omap_set_mc=
trl=E2=80=99:
> drivers/tty/serial/omap-serial.c:514: error: =E2=80=98struct uart_omap_po=
rt=E2=80=99 has no member named =E2=80=98DTR_gpio=E2=80=99
>=20
> Maybe check how you want to fix that first? I can then update
> my patch for tty-next.

oops, my bad. Patch sent.

--=20
balbi

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQSYV1AAoJEIaOsuA1yqREyDwP/Ai/XqwS1t6N0dE6KDb8nGlv
DSqoR2Jui2EZ1craBl6J1+Af/cZCFGmKOvJmrI3I0n3utnYu3hPfwFzX2qkQoo4M
KAgMdzWQMZguCjcMqgsg/Ms20LB4U5yWXwur/Nd4NEIlcYo8RfqV3AIKMxKpFJBZ
Z1KPW+6eDCfgk2Hm3yfdlaFJf+ZuRUeVamTz9vThj8q1DtYlQCwoazVODgcGEkmW
1rfiD6Snlny6T5fokfncJltm+M6eWXq2iqVt/fdvivU657MsApUHoKwwwzLZB9Yv
WC9KHXhh3v0c28FgLic6zH+HhaHkAkBtyyl6jHokic1i2BM/Mk4mxrXar2r+3uH4
/fDbt9tcj1V8d/M6dX58o4WjolvKdH6dEzgMg4FZaAASDXeEtSV6P/uudjJ3F7wq
LChC/Yf+xjc5bTZyFHrg7EhB9IR8avEBJmE8nGTvz7UR+hahF6BwnC0ce9y/4WMh
TFESPu4dZLyeNqu6O7D4wQPoJC5gZnEfvzPKG9cBAQCWEJxaNz0GG1S/RPEDlfqf
Ab7W4JaPydXwy+l1lKP2tjdQCQDLNZKRvZN3k5cF4pqbI9i8Co6ZFyssqVh36Hio
sxiCdaBfrO7JlAZZGKOc0q7lIRzc9w2YUKRHTLTzHd1olbraWyDhUWugrRjlbEkb
Mr2eCopgYBPKEfVOzy4+
=huV/
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
