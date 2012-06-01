From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/6] usb: gadget: omap_udc: remove useless print
Date: Fri, 1 Jun 2012 14:07:52 +0300
Message-ID: <20120601110751.GM15957@arwen.pp.htv.fi>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
 <1338293761-9457-3-git-send-email-balbi@ti.com>
 <20120601110123.GK12766@atomide.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QqzFzR/RUlLahzby"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120601110123.GK12766-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--QqzFzR/RUlLahzby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 01, 2012 at 04:01:24AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [120529 05:22]:
> > that print isn't needed at all. Remove it
> > and move the use_dma reinitialization to
> > probe() function.
> >=20
> > Note that ideally we would drop all
> > cpu_is_* and machine_is_* checks from
> > this driver instead. Later patches will
> > come to get rid of those.
> >=20
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/usb/gadget/omap_udc.c |   13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_ud=
c.c
> > index aa2d174..5e7b891 100644
> > --- a/drivers/usb/gadget/omap_udc.c
> > +++ b/drivers/usb/gadget/omap_udc.c
> > @@ -2800,6 +2800,9 @@ static int __init omap_udc_probe(struct platform_=
device *pdev)
> >  	struct clk		*dc_clk =3D NULL;
> >  	struct clk		*hhc_clk =3D NULL;
> > =20
> > +	if (cpu_is_omap7xx())
> > +		use_dma =3D 0;
> > +
> >  	/* NOTE:  "knows" the order of the resources! */
> >  	if (!request_mem_region(pdev->resource[0].start,
> >  			pdev->resource[0].end - pdev->resource[0].start + 1,
>=20
> I think this would break omap_udc for 7xx as it then tries to use
> DMA as USED_MA is set by default?

I'm clearing it in the start of probe function. There's not functional
changes at all. use_dma is ON by default, then our probe gets called and
first thing we do is clear use_dma to zero when we're running on
omap7xx. I don't see the issue, maybe I'm missing something.

--=20
balbi

--QqzFzR/RUlLahzby
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPyKKHAAoJEIaOsuA1yqREZ38P/1OCoIGTYFOmSFuL9LIjhDo+
BAKTfmhrtevK2mOr7RzP7v6vBjOKQhVqmOPdyyKV1/lEMkyFSrySxUR/Oe2//qWz
5lNO/csu7878oIDYLBkXOmYdP6wM31pa9Sn6ppzBszBqP8JrcfR+KNFchwZ6mHsf
+M81lI4Q0aj8ez9BV5pBMdp68mRo4dF6FBQ3KGa55RRg26yURb2PQERdILSkeyAf
gDJtLLWmvkO/Fi2t1JFKODVVn5F8fXhXpjwVS8fh5YSHZAn15TqZv56orTzXvnAj
zJXWYguYXbat3xfGLpw688hZ47G3SQvPZpIMGRDodKNS1MTbvbvH9muASeMAHsZ2
YQM3A7BCbnjwPFfaJLwnbXlOODQfyyID0Xk6S8bFBMxO62unJOkESvRzBLynuLAm
iAZ3pq2waUpz+X1vPaqoVaYqKIjgXjXi/KNA0JbtLq7r87TbzOIqx685VTA5WZGq
70YHw9l3f7qqVGCcTfyZUEuBlolEXsu5gzRYmyCcW59WYYFGOUkBtcWzUbxULYcz
a4PW8TGA0WHvOJdK2e8J+bior+vrEZGi32GF1Qq3loF5hamwUAlvysFe9xiqYUR+
r5lCssth9KapYnhx5sRF/FSaBTZxjbZxHdgwjWFSk4l8XCEUS7aeN9Cr/X74+92w
bZd74TF5kEZssx2D+G1C
=42Lk
-----END PGP SIGNATURE-----

--QqzFzR/RUlLahzby--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
