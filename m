From: Tilman Schmidt <tilman-ZTO5kqT2PaM@public.gmane.org>
Subject: Re: [PATCH] Make the dev_*() family of macros in device.h complete
Date: Fri, 19 Oct 2007 00:56:38 +0200
Message-ID: <4717E4A6.9000608@imap.cc>
References: <1192740689-28722-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0787284623=="
Return-path: <isdn4linux-bounces+gli-isdn4linux=gmane.org-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org>
In-Reply-To: <1192740689-28722-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://www.isdn4linux.de/mailman/listinfo/isdn4linux>,
	<mailto:isdn4linux-request-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.isdn4linux.de/pipermail/isdn4linux>
List-Post: <mailto:isdn4linux-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org>
List-Help: <mailto:isdn4linux-request-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org?subject=help>
List-Subscribe: <https://www.isdn4linux.de/mailman/listinfo/isdn4linux>,
	<mailto:isdn4linux-request-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org?subject=subscribe>
Sender: isdn4linux-bounces+gli-isdn4linux=gmane.org-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org
Errors-To: isdn4linux-bounces+gli-isdn4linux=gmane.org-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org
To: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Cc: gigaset307x-common-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kkeil-l3A5Bk7waGM@public.gmane.org, mac-l2TVJu5ShECELgA04lAiVw@public.gmane.org, isdn4linux-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org, hjlipp-S0/GAf8tV78@public.gmane.org, linux-omap-open-source-P3Mejjx7fphMeHKdZgrLhA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0787284623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig73420EAEB13284BB850C3626"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig73420EAEB13284BB850C3626
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 18.10.2007 22:51 schrieb Emil Medve:
> Removed duplicates defined elsewhere
>=20
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Acked-by: Tilman Schmidt <tilman-ZTO5kqT2PaM@public.gmane.org>

for

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

Thanks,
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman-ZTO5kqT2PaM@public.gmane.org
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig73420EAEB13284BB850C3626
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHF+SvMdB4Whm86/kRAtdIAJ40QDZTMhFV579fAAxnXZv8jBydkACePdv9
UltTRfc0M6f00B6NxXtYMyU=
=UcYV
-----END PGP SIGNATURE-----

--------------enig73420EAEB13284BB850C3626--

--===============0787284623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
isdn4linux mailing list
isdn4linux-JX7+OpRa80SjiSfgN6Y1Ib39b6g2fGNp@public.gmane.org
https://www.isdn4linux.de/mailman/listinfo/isdn4linux
--===============0787284623==--
