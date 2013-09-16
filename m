From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/2] DMM DT adaptation
Date: Mon, 16 Sep 2013 14:30:31 +0300
Message-ID: <5236EBD7.1020405@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com> <1379323815-14130-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KqnknAdQMdwjKBN2gnf8fOMc5wt6cRist"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379323815-14130-1-git-send-email-archit-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--KqnknAdQMdwjKBN2gnf8fOMc5wt6cRist
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16/09/13 12:30, Archit Taneja wrote:
> The DMM/Tiler block can used by omapdrm to allocate frame buffers. With=
 the
> removal of address and irq data from the omap4 hwmods, the probe of DMM=
 driver
> fails and omapdrm isn't able to utilize the DMM hardware.
>=20
> Add DMM bindings for omap4 and omap5.
>=20
> Changes in v2:
> - No changes, split out into a separate series containing only DT relat=
ed parts.
>=20
> Archit Taneja (2):
>   arm: dts: omap4+: Add DMM bindings
>   drm: omap: Enable DT support for DMM

This is not an objection as such, but I just want to point out that DMM
is part of the memory subsystem, and Tiler is part of DMM. So it's not
linked to the display subsystem in any way. And with a quick glance to
the TRM, DMM manages _all_ accesses to system memory.

In that sense, having a "DMM" driver as part of omapdrm is quite wrong.
If it was just a "Tiler" driver, it'd be better, but still wrong.

That said, if I remember right I brought this point up long ago, and it
was pointed out that only the Tiler part of DMM is configured at
runtime, and more or less all the registers of DMM are about Tiler. And
only omapdrm uses the Tiler. Thus it was deemed ok to have the DMM
driver in omapdrm.

I'd still rather have tiler as a separate driver, but that's a separate
issue from this series.

So, after fixing the issues I pointed in the other mail:

Acked-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

 Tomi



--KqnknAdQMdwjKBN2gnf8fOMc5wt6cRist
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNuvXAAoJEPo9qoy8lh71c+MP/2LE4gOhsIQuj/V/E7w4oNSX
oLlPtUsOwYXkfpVU81o8KQabKCxYRlpFAPS15z3KnBt4okqs6MQvWemN36bDyzPf
CmsUwfm8Oc73rIPYl8SJVJBlpO2rjgGms8z9R/+XczgvVrM1/ZNfjva9h+ar3OX3
6wZ+6D7kOPausb+fyiVStA/Na+/txck7laX5CATyjmLNkAafI4C6dg4K9qjL8gWa
AjatbYlMZfWbY+5VoRAoMf97hVJd0FEHv/bOhfiM8e8TMilVTMGgbZA3p8uZD2QE
haHW0LZF7DZJBVwR32g1RpaMid9VmyMOuv874EjcOKkBNhoXwccNe+XAnRp1jxpm
xASgIhCGeqlbWiCDj4OcRF3T71hrrwHKRsNZDFuH7I/3M0/mKfFdpsxNLoRLbQs5
1pgt1Ewsc/rCEIiVxmkQMI1Qp8j8i9uowvex1wBjfAD7+B2w7aCkPcUHRQyyUMPF
thnOSR23eDl2nBhycyiWNsNxMt/Ib6keO11MhSImRxqYDBIE515GanU94Yedg+zP
z3MX36sdGSZohphvjrz6QRUvWHiJJUW6+ver+iPIeIGNO9oKDVta8NOm0qAwprwt
NxCdEhFeEqTcbqW/DbbtYGP1yni2z6S00lld3g9Mf2tLgaYRxJukzF7pUj0l0rqh
vBOmAmLPixBxmZqgYyzc
=xG06
-----END PGP SIGNATURE-----

--KqnknAdQMdwjKBN2gnf8fOMc5wt6cRist--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
