From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 02/11] usb: musb: kill global and static for multi
 instance
Date: Thu, 26 Jul 2012 10:40:58 +0300
Message-ID: <20120726074057.GH29029@arwen.pp.htv.fi>
References: <1343218326-30610-1-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343218326-30610-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 25, 2012 at 05:42:06PM +0530, Ajay Kumar Gupta wrote:
> @@ -240,20 +238,24 @@ int __devinit musb_init_debugfs(struct musb *musb)
>  	struct dentry		*root;
>  	struct dentry		*file;
>  	int			ret;
> +	char			name[10];
> =20
> -	root =3D debugfs_create_dir("musb", NULL);
> +	sprintf(name, "musb%d", musb->id);
> +	root =3D debugfs_create_dir(name, NULL);

I told you to use dev_name(musb) for a reason. See what happens when you
use dev_name(musb);

Do you not think about the other users of this driver ? Do you not know
what's the ID on platform_devices which "don't have an ID" ?? The
drivers core set it to -1, then on everybody who's got a single musb
instance, will have to access the "musb-1" directory. That doesn't seem
nice.

Just use dev_name(musb).

>  	if (!root) {
>  		ret =3D -ENOMEM;
>  		goto err0;
>  	}
> =20
> -	file =3D debugfs_create_file("regdump", S_IRUGO, root, musb,
> +	sprintf(name, "regdump%d", musb->id);
> +	file =3D debugfs_create_file(name, S_IRUGO, root, musb,
>  			&musb_regdump_fops);
>  	if (!file) {
>  		ret =3D -ENOMEM;
>  		goto err1;
>  	}
> =20
> +	sprintf(name, "testmode%d", musb->id);

this is unnecessary!! Only the directory name needs this trick,
whatever's under the root directory does not need any ID appended to it.

--=20
balbi

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEPSJAAoJEIaOsuA1yqREBBMP/34f1kE3qFLu08S+l2sYC51q
Xoq70zTLn6URL1gc0v5YOW9RauOQkeiSwexfx9miabarPb+/lL8UK+gOASsac+LY
TbJufNvuFZ0saQWrSnQ7LgkxpaVb87u/px9PrUZ4ALpQWZBo3MicR5B0nKnB5zNK
4Q/gAz3iPo6v74mVR0yKaRUVkX7Wd5pHO3+//ib9URaIIiU6CATJYZRIS/FkO4Cm
UMPz6Sn8p30Wp/OVC6ZCSS6DPjk5GDpuShUzHiSGzas/EQYV4AFOfpUXJacOhqO+
bn5+v0i6BybZBv+02iQDn5889clBAkDHcTf1xgEbLgOBOqP/YeLz+Npv3I5VklI8
mxNhy48c8dcRf+alxR5129WmFpPdVcRdbNUhxAdo3L3fM5tu9srUM5PRXX972xBI
EXRDJ1W5OfHxzNUpnpv/wFj407f2QeVMVfdXbPK9GBu9sPLkQjw/TF62IKr/Mm6R
3G4JxrewZ3pX/RugM0zUvYom85da6SfDabB3N3tuat6lnWiDk/ULCjPP1HpvC1oE
GHbV3h0Gskrt6cp37KdGYV1EFtqPybK9PXjyRnUmkHKTgfMPrvhlh1kpNqS9abLw
yCjJiSU1Mj+jmfq1X+MWZZ+5M21xfo0x75RG8256UDE4RKuvjRAa2DkiOovDqg/c
vRzEshj6f1/koou08Hlf
=1Pis
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
