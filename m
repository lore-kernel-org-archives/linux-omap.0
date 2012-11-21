From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/16] mfd: omap-usb-tll: Clean up clock handling
Date: Wed, 21 Nov 2012 21:39:52 +0200
Message-ID: <20121121193952.GA14290@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-3-git-send-email-rogerq@ti.com>
 <20121121115556.GD10216@arwen.pp.htv.fi>
 <50ACCAE0.3030907@ti.com>
 <20121121140354.GR10216@arwen.pp.htv.fi>
 <50ACF5CD.9010209@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50ACF5CD.9010209-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 05:39:57PM +0200, Roger Quadros wrote:
> On 11/21/2012 04:03 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Wed, Nov 21, 2012 at 02:36:48PM +0200, Roger Quadros wrote:
> >>>>  		break;
> >>>>  	default:
> >>>> -		dev_err(dev, "TLL version failed\n");
> >>>> -		ret =3D -ENODEV;
> >>>> -		goto err_ioremap;
> >>>> +		tll->nch =3D DEFAULT_TLL_CHANNEL_COUNT;
> >>>> +		dev_info(dev,
> >>>> +		 "USB TLL Rev : 0x%x not recognized, assuming %d channels\n",
> >>>> +			ver, tll->nch);
> >>>
> >>> this hsould be dev_dbg().
> >>>
> >>
> >> I think it should be more of a warning because it signals a problem.
> >> There is another pr_info in the success path which could probably be a
> >> dev_dbg.
> >=20
> > it's not a problem at all. It just means that a newer OMAP has come to
> > market and perhaps we don't need extra code to support it. A revision
> > detection should *never* be grounds to failure. When we can't understand
> > the revision, we default to the highest possible value we know.
> >=20
> > that's not an error.
>=20
> Agreed. I'm not treating it as an error. We still continue probe and the
> driver should work for newer revisions. Just prints a line on the
> console about the new revision. Thought it would be useful to us, but if
> you think it is a problem I don't mind removing it :).

that's the thing. It _is_ useful to *us*, kernel/device-driver
engineers. But for the end user it just ends up as yet another
meaningless print in dmesg ;-)

--=20
balbi

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrS4IAAoJEIaOsuA1yqREeloP/jX1m8jCQjZPaTXmclDUaHvj
5MB7x/eAamkAJky3bdsul4QChez+V78Y1m24fP9pOqOw+2OJemYOK6L2Jp+Xjfwj
QdrhAQFGdTquwVXvj2v2eoXqop6GO3xZFG97sPss1oMsVAcxqPfQksVQIKMg9jkD
fgAMAcAoYoyxj2cNR7iUwJ7jlSrlVJARt8MtU1fneO7jt8eWkU8xrrZkN7EMKw6G
xleSuBXhFonhHJSuQvBi6TfpECW6J/xapRQn3wEUYLZZ7OZ56WV8kP0Vc9bw8gOi
qQUZ5mM6ew19f+09Tw5liy/Z3rnPJWFMFKalmePJOhBUPhydw0Cih6bFx6fgxXLL
R9hCqRhyPMwtlGmkX/n5YmF0hUq1ya7BsPm13jI1tO7VXhtBWAUNN/rBkuIYuW1H
bOvT0qBkgZSvDy1Tq3S3r9pJLO1sbJz+Kk1EDxfsqen7DEVlvK4mHcaxuH8iZxiR
RPfMbjj02xhWhkW9OHnyXJ0cfAEfG/HxfaXOtBdy/sb3aTopqOs/d0so+NbflqcE
ic2xcGqBVfbHhbsXh+qX1KSgfhKc07yUP8ZaY3yztMr0lAAGU9NwQrb2muy+azFh
HO2Vx82c1kZWvF17dvpBseEri7tzv//8aw0TgmTFtIqBuas2QEbO4tPQDZL9hvbn
WlJiAIJtAek6EOy97bez
=gO0S
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
