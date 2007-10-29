From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [PATCH resend] Make the dev_*() family of macros in device.h
 complete
Date: Tue, 30 Oct 2007 00:08:27 +0100
Message-ID: <472667EB.4030502@imap.cc>
References: <1193697795-7823-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2CF69EA2B09C1135AC10B22"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754915AbXJ2XIS@vger.kernel.org>
In-Reply-To: <1193697795-7823-1-git-send-email-Emilian.Medve@Freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
Cc: mochel@osdl.org, gregkh@suse.de, linux-kernel@vger.kernel.org, hjlipp@web.de, gigaset307x-common@lists.sourceforge.net, kkeil@suse.de, isdn4linux@listserv.isdn4linux.de, mac@melware.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2CF69EA2B09C1135AC10B22
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 29.10.2007 23:43 schrieb Emil Medve:
> Removed duplicates defined elsewhere
>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Acked-by: Tilman Schmidt <tilman@imap.cc>

for:

> diff --git a/drivers/isdn/gigaset/gigaset.h b/drivers/isdn/gigaset/giga=
set.h
> index a0317ab..02bdaf2 100644
> --- a/drivers/isdn/gigaset/gigaset.h
> +++ b/drivers/isdn/gigaset/gigaset.h
> @@ -106,12 +106,6 @@ enum debuglevel {
>  					 activated */
>  };
> =20
> -/* missing from linux/device.h ... */
> -#ifndef dev_notice
> -#define dev_notice(dev, format, arg...)		\
> -	dev_printk(KERN_NOTICE , dev , format , ## arg)
> -#endif
> -
>  /* Kernel message macros for situations where dev_printk and friends c=
annot be
>   * used for lack of reliable access to a device structure.
>   * linux/usb.h already contains these but in an obsolete form which cl=
utters

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigE2CF69EA2B09C1135AC10B22
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJmfrMdB4Whm86/kRApJ0AJ0TndU2phadwTNtqF6Z2xPA18hAvQCfXtGE
EbQDGodMYRpl62IWLo5towM=
=7/H2
-----END PGP SIGNATURE-----

--------------enigE2CF69EA2B09C1135AC10B22--
