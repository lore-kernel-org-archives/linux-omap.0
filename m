From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] am33xx: create child nodes for the two musb controllers
Date: Thu, 27 Jun 2013 10:42:08 +0300
Message-ID: <20130627074207.GO15455@arwen.pp.htv.fi>
References: <20130626153325.GA24075@linutronix.de>
 <20130627065150.GK15455@arwen.pp.htv.fi>
 <51CBEA56.4010806@linutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRo3kt64Wi40AlcO"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51CBEA56.4010806-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--QRo3kt64Wi40AlcO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 27, 2013 at 09:31:34AM +0200, Sebastian Andrzej Siewior wrote:
> > the patch is alright, but what about the giant amoutn of function=20
> > pointers we have ? Are you planning to use of_dev_auxdata ??
>=20
> I didn't plan to use of_dev_auxdata. What do you mean by "giant amount
> of function pointers"?

every glue layer has:

467 static const struct musb_platform_ops omap2430_ops =3D {
468         .init           =3D omap2430_musb_init,
469         .exit           =3D omap2430_musb_exit,
470=20
471         .set_mode       =3D omap2430_musb_set_mode,
472         .try_idle       =3D omap2430_musb_try_idle,
473=20
474         .set_vbus       =3D omap2430_musb_set_vbus,
475=20
476         .enable         =3D omap2430_musb_enable,
477         .disable        =3D omap2430_musb_disable,
478 };

note that in the glue layer, they have access to musb itself (biggest
mistake of my life, btw :-)

--=20
balbi

--QRo3kt64Wi40AlcO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRy+zPAAoJEIaOsuA1yqREjC8P/3ENl84SLMV2GDeS3gCI7a1O
n56UlSmhIra8SuqOracAE2NwIqlCRLoxEQ0/rsQW4LDjDfEpUdqtwLxmnWgEEjTo
/p2lIqSNZ+W2Oeqn5DKAbMc0tCEgMZ2bFF2EHpG3jD6HOaG00F1mk72qVYppfjom
WrBG49mkWIXUIRdS6nS7SrgfiZXhUMP6sQGmPU60MW7d7axzsFgIAkE/qGZpBMff
Lzcu09r45PLW2gVRgqkCVP86JPFVo+aCWSJ468aszVKah0bMOxncTXYdBNqD2viY
5YeQpNjaUgojnkNqK6G50VtT8ma6KcGUTWT7O11Oduw/Z2r0urqZN75p+VD8m+Mf
p+MiXMtbGsiLVUrB0UTb2bnq3KBradnhcb+//uJGRcbUBeSCb/pPzaYu+BPxuh2e
9LhC/l1FLd/EHSrWWipS3Toj4Pd+DXMK0vEdfe1poHWTIvbFDy7nkzAKRPAeFOLq
5gUsQQnBNyrA8ogRNe7SZHO/0l1Mfy0zzl3QKVKxfmB0un/gCpetEvJyiJff6zzC
ypOteVRhDyeC7zx/poz+fOgkpaTN8JGLy9XAQPSYo2zX2l+0z83804xDDXPI2jy9
EdBgB+gaH95M4GbAbR3/XNgMrQv4IK3xAp8/fuFxGkJipp+wt3VMAulRe4CsW0gn
RKuTWprgnMX1QOytdgj5
=rVI4
-----END PGP SIGNATURE-----

--QRo3kt64Wi40AlcO--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
