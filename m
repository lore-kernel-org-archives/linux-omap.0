From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: dwc3 gadget breaks on system suspend/resume
Date: Thu, 19 Jan 2017 13:59:04 +0200
Message-ID: <87a8anjm5z.fsf@linux.intel.com>
References: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54bdc1b7-69ed-d580-fd17-3e7499ac1c27-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> Hi Felipe,
>
> We have system suspend resume working on dra7-evm in v4.10-rc but
> dwc3 gadget breaks after system suspend resume.
>
> Any hints how to fix it? Full backtrace below.

from a quick look. END_TRANSFER is timing out, most likely. Tracepoints
should give better hints.

We might have a bug in dwc3_gadget_suspend(). No idea what's really
going on.

> Another message that looks worry-some is
> "[   61.495313] omap-dwc3 48880000.omap_dwc3_1: runtime PM trying to susp=
end device but active child"

did you implement runtime PM on dwc3-omap.c? Look at dwc3-pci.c for referen=
ce.

> If I unload gadget, then suspend/resume system then load gadget everythin=
g works fine.

right, dwc3 UDC will already have been toredown. Unfortunately I can't
spend a lot of time on this, so you're gonna have to try to fix it and
provide a patch :-s Quite busy looking at some f_fs weirdness.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAliAqggACgkQzL64meEa
mQaGWBAArycAc5VD847qhl8f5GJoFOS1eRkycb9gJ5YrPJKRoBrjsJOd0xO5R/Iw
kFskk3SViXVZCn4iTS1zo9r0m8fHZnzYHeSdd2istCoin4oTPTXlIR/d9BhCoP/3
/Uqx/8BcPuDFOPZtoRHDC7oM5YfmAvghEy7h9mx+aoaAntw6+BOtZYnVYjG/BDLi
dLokOFisg880iUQVtbamojkBXHEUc4kRo4UpOQzrI7OF1qfOLlVpvXk4JUmvNxCp
cl9nYN8PoQEidRC8TcTm/Q11AD2u/qoh45Snc6343Kk9YiWsXcjBDF7c7iu7wpvs
thv43ygnwXljh9BZarVYMiaFEZTI+wcgSrxN/zodVtTFLac5KVjbnkKPRNI2qqI9
8hi1wOgzYihWSeUGwDNW2HYeiDinrRu7IOcaqjdFGdnYuLU6/wDP/RVteXGF1CS7
xraxyKFlgW9R13FoByDdaU37OB10bm/BavMZoQ6sl5+9Z2uCX+cCpmgjPLGH6Im4
FnQEFI4G5gtfNJTrElz54hTGYwQfHXCuR1fybxQLPzRkCpoqSG/6XFOhndlCQWWq
GRf/nsSkf26KYQH3fQQ25l0IBXyK8Q9oEA33L6zE7gexvFtZSqhA7+i9XPWnSwkg
CN3g3hcvBmiFOd7zB6iPiQWJ2MYLGAkDWd+4MW9PDuxEW5dzoGU=
=KVjk
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
