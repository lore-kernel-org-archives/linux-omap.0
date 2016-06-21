From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [balbi-usb:testing/next 64/67] otg.c:undefined reference to
 `usb_gadget_vbus_disconnect'
Date: Tue, 21 Jun 2016 03:18:26 +0200
Message-ID: <20160621011826.GA17167@earth>
References: <201606081642.T1wpsuI1%fengguang.wu@intel.com>
 <87k2i09f1k.fsf@linux.intel.com>
 <20160612023955.GA22054@shlinux2>
 <87vb1d4oy8.fsf@linux.intel.com>
 <87r3c14ofg.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87r3c14ofg.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

On Mon, Jun 13, 2016 at 09:01:55AM +0300, Felipe Balbi wrote:
> From d45bdfafc3143dc7acc9d71131807d3e30ab7bcd Mon Sep 17 00:00:00 2001
> From: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date: Tue, 31 May 2016 13:07:47 +0300
> Subject: [PATCH] usb: gadget: move gadget API functions to udc-core
>=20
> instead of defining all functions as static inlines,
> let's move them to udc-core and export them with
> EXPORT_SYMBOL_GPL, that way we can make sure that
> only GPL drivers will use them.
>=20
> As a side effect, it'll be nicer to add tracepoints
> to the gadget API.
>=20
> While at that, also fix Kconfig dependencies to
> avoid randconfig build failures.
>=20
> Signed-off-by: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/phy/Kconfig               |   1 +
>  drivers/power/Kconfig             |   1 +
>  drivers/usb/gadget/udc/udc-core.c | 573 ++++++++++++++++++++++++++++++++=
+++++
>  drivers/usb/host/Kconfig          |   2 +-
>  drivers/usb/phy/Kconfig           |  11 +-
>  include/linux/usb/gadget.h        | 585 ++++----------------------------=
------
>  6 files changed, 645 insertions(+), 528 deletions(-)

[For drivers/power/Kconfig]
Acked-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXaJXgAAoJENju1/PIO/qaN6oP/jcnYAC10ZLpv3lrLW8unhOS
EZn+3OTzlJpS0PrucmzJQZ2LODiKC6J0NAOe9GaySXgX63USGSa0ILu2Ayz93rfG
DzyHlmh98z0TyRSCZNptdv5ehOOuvFfZMdbDw4343jYXSglSJX1DFCswbms+tgGZ
SnEQHQxOEio0J2Avyf/mgKtJDV5pXDv1QKUV4NIxNSTDQfbD30gqZBNpjHMael6X
C81Ukr0Qr80sYSC8lsf3A+rgtjWDpCxPL7Rg5pD+zVy/jSP5gc7rzFGwbQalW457
6giczS4t0XGPrUCrzG6FYuc9GAOJUjAnBEFWwn3oPhxwX/FJvxIgNc0x90Zz/Bxt
0ITakJYvqkiGR25ukO6G61KxjrFCW0V6whr3a3zHviNiUJ6arKim7zCt2Xtx5Kez
6Au2kyB7iE5hqdrLrQg1lXtT9Nb97MQCn3Z0yqHQhzkoy9WD14fM8RHbJP6FhMCJ
V9DWDxPFScc0izyaqUmxoUIpSAo7YktGNqb6O5GeUVy6sT0oUXTXwWyirWKd2LNu
QYiCM/a5zbnk/ej9IOdV3yWJzZr4TcMrlv7l2zUP5eqV5SsqfcIyJvmPBINrA8sB
dgF5ZW9rVwqBI1Nrjagij1bNV+LZCR3IODHvQ3vxtSS2EGxvYqy1KMixqeFwFvZE
nIfDO06bpC3y54LXMmos
=u6c2
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
