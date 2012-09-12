From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [balbi-usb:merge-result-for-greg 66/99]
 drivers/usb/core/hub.c:2654 usb_get_hub_port_power_state() error: doing dma
 on the stack ((null))
Date: Wed, 12 Sep 2012 15:02:13 +0300
Message-ID: <20120912120211.GC5732@arwen.pp.htv.fi>
References: <20120912082622.GB27847@localhost>
 <20120912085057.GC19396@mwanda>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120912085057.GC19396@mwanda>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 12, 2012 at 11:50:57AM +0300, Dan Carpenter wrote:
> On Wed, Sep 12, 2012 at 04:26:22PM +0800, Fengguang Wu wrote:
> > Hi Felipe,
> >=20
> > FYI, there are new smatch warnings show up in
> >=20
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git mer=
ge-result-for-greg
> > head:   23953bde3e4d6aa8780dc054f6ad9882ac63f4f4
> > commit: e918fa161f510136fce45a524e934fe20e62c8b1 [66/99] Merge tag 'gad=
get-for-v3.7' into merge-result-for-greg
> >=20
> > drivers/usb/core/hub.c:2654 usb_get_hub_port_power_state() error: doing=
 dma on the stack ((null))

that's not part of what I handle :-(

And merge-result-for-greg was really a temporary branch, btw :-)

--=20
balbi

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQUHnDAAoJEIaOsuA1yqREruAP/AsJlTd7qHyhoNPhOJCUDgLv
8K6rAjorAyFXw+Nmlw2aoN+XAAfXRyOAeb5j0e1DIAbA2V2xiRqitsbLhsDuHqgo
fms2BKfGtaSUZ41l+qnxuBxv/pA2reoYbhYJZW1XzDNZa9xdMnCt4OTi8ZMNVzj4
kQ7XnkWmvVPfC4yrwlBtVX5px5VDUMTqojAsnfqs5ZyjE1upC0Tcf0T6apjs1iGJ
1wbXw4j8m/kaTW5dojOWZ7sGTqkzfzuCouWrplozWV1INbXXqq4ZXn6BV2Uf+TKm
Ianai7Erz3fFMh9y/gmsNrzqQwRVobBMeyNzy/4Qn/6ImWgBY8VVUZgOV4x1KU/O
pUni2zVqMP/H6azsCB4vYo6ZTzPju/TrGNBR5TtaGKolfENvTYC/xAC8oQF6SPQ7
I6lTsaStU6MLtTanRqnHVMNVgoHCNUBtR6/llPSj/QWRLJUGFL2uauapD8Tu7F2L
7BBifUsOxLO5O5BkanCdyHPaA3o4MKY8KmIeecOmn9AvqCGv8QJY/DlIumlcQsZg
0f64kJGUnDfLwkuG3vIUa7E6kzaBwKDJ2AO9foWuyJIZePgtdG8vUgU7deSeJPZb
NZXRFSNtYvSs0bNcnhuBX8sXeK0BW2LX/z6rrqKsH5i20ReY9x8Xb28+GdttKSA6
iAeSU4uf4Kg5gDkOiRMx
=3+Dw
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
