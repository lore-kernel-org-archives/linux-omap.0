From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH v2] OMAP:MUSB: Corrects urb unlink function path
Date: Fri, 22 Aug 2008 21:54:40 +0300
Message-ID: <20080822185439.GB7542@frodo>
References: <1219425190-13540-1-git-send-email-ajay.gupta@ti.com> <Pine.LNX.4.44L0.0808221330310.2230-100000@iolanthe.rowland.org>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0808221330310.2230-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2008 at 01:32:12PM -0400, Alan Stern wrote:
> On Fri, 22 Aug 2008 ajay.gupta-l0cyMroinI0@public.gmane.org wrote:
>=20
> > @@ -1785,9 +1784,11 @@ static int musb_urb_enqueue(
> >  	 * REVISIT consider a dedicated qh kmem_cache, so it's harder
> >  	 * for bugs in other kernel code to break this driver...
> >  	 */
>=20
> This doesn't look right.  After calling spin_lock_irqsave you are in an=
=20
> atomic context, so you can't pass mem_flags to kzalloc.
>=20
> Either move the spin_lock_irqsave after the call to kzalloc or else=20
> change mem_flags to GFP_ATOMIC.

first one, please.

should be like:

 	qh =3D kzalloc(sizeof *qh, mem_flags);
 	if (!qh) {
+		spin_lock_irqsave(&musb->lock, flags);
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
+		spin_unlock_irqrestore(&musb->lock, flags);
 		return -ENOMEM;
 	}

--=20
balbi

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIrwtvQBywH/bNoN4RAvgvAJ9bSVmsp8d33FRW3LwtR8/0Lpd+cwCfUxeT
zg/ditvrnFn+dbcYg6rL1c8=
=N2MO
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
