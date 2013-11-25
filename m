From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from
 musb_bus_suspend
Date: Mon, 25 Nov 2013 13:46:29 -0600
Message-ID: <20131125194629.GA18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-3-git-send-email-zonque@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r6fxLKBTHCmC166Z"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385408393-19707-3-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, neumann-SRDuVqtxQLSzQB+pC5nmwQ@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--r6fxLKBTHCmC166Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 08:39:50PM +0100, Daniel Mack wrote:
> Make musb_port_suspend() externally available, and call it when to host
> goes into suspend. This allows the core to go into suspend while a
> device is connected.
>=20
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/musb/musb_host.c    | 2 ++
>  drivers/usb/musb/musb_host.h    | 2 ++
>  drivers/usb/musb/musb_virthub.c | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 6582a20..81caf9f 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -2433,6 +2433,8 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
>  	struct musb	*musb =3D hcd_to_musb(hcd);
>  	u8		devctl;
> =20
> +	musb_port_suspend(musb, true);

have you considered the fact that when musb looses context it'll cause a
disconnect on the bus because soft_connect bit is lost ?

What if you have a mounted file system on a pendrive ? Should we allow
suspend in that case ?

Alan, Greg, any hints ?

--=20
balbi

--r6fxLKBTHCmC166Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk6kVAAoJEIaOsuA1yqRExxQP+wRsC28wau3mK70nGxr3KctO
wRAzZUqV7CpBWfIYdB7x2g38ikc1fbH8X+TeTnjQO9eElx71+JL2xaYxTBVOLeCw
fXmwgZAsdvk2wNzn7WgiLTMT8PouobDuHWI9VYZy4Z97YXsNI0UVhw+mQP9UZnfH
FuMHQKUZVp+cQK0BaGNtbjSyOZ4V8WiQ/YqB4tMOv4TkRxjhe0KRh+Mdo+draamg
Fx02zrEH3gVJCote8R6zEHTL54u1ufYhz6X5p9Z/vHf1Ii0U8sqFqU1kxa0LRk/G
K1Fkf2uFH+HlOaXPG5fuyblPF5EFcvkC+Vb6Vg7Kaiii4DluIqd3ZQuSHw2S/uza
RztvUSn6X9LF8RE9j/7zpNjCYBKKMIVDsjapws8hJEdPMOpLr6/0httlYLEkBbIZ
hDpUBAdshX6HKtWrtgygjaFBHa2cDqDAg+3SSwfDPSATipnOrcuDoi60QjjH+Xpq
eLwmaLL2L87wnonC6K7U754g41Wlf7hJeemFaUi81Kvaa33yitp7JGBXR0aIuWf6
7jn1OQ0+mroDhyOEx8Wz3M3fHpzgD8s/QayBqzPXLDgl7iKbayIyItj/eDmP77ot
MtX09tuxmSqfhGsfzQfKMViQFOTfy8DelMXhYVFwnOnhZsDMbn5QrsiGGKgldZGL
+xOfwkha8TI1YrKt/XHA
=z2fR
-----END PGP SIGNATURE-----

--r6fxLKBTHCmC166Z--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
