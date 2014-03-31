From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/55] ARM: OMAP3+: PRM: add cpu-type as parameter to
 prm_init calls
Date: Mon, 31 Mar 2014 10:21:48 -0500
Message-ID: <20140331152148.GE7760@saruman.home>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
 <1396278994-12624-8-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55280 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972AbaCaPYK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:24:10 -0400
Content-Disposition: inline
In-Reply-To: <1396278994-12624-8-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 31, 2014 at 06:15:46PM +0300, Tero Kristo wrote:
> diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm=
44xx_54xx.h
> index 8d95aa5..73734b2 100644
> --- a/arch/arm/mach-omap2/prm44xx_54xx.h
> +++ b/arch/arm/mach-omap2/prm44xx_54xx.h
> @@ -57,7 +57,7 @@ extern void omap44xx_prm_ocp_barrier(void);
>  extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
>  extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
> =20
> -extern int __init omap44xx_prm_init(void);
> +int __init omap44xx_prm_init(u16 cpu_type);

trailing change ?

--=20
balbi

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTOYgMAAoJEIaOsuA1yqREuI8P/R8l5jv8uGOLqvxmRCDfH3Rp
PDhyR2qDgSwrNEF2wq2RqxYkLby5lgMrp3hiazH8b9rtrcT7UbblCwTip1p9TqJx
m2JCaHP0qOGKWil9MFg1jmphjpzWrZK9Pn+h6gMoKipKJ1S/ab2Ow+Envk8qfmgw
lRScsgyhvS/LvkosVALVJzCBusNKq/uxfPnYe2pYwN46v4PeqDs6h8nyeG6p6D1l
PzOVU8jwG42xlZ3NetHsDeUZbvdl7OMH44omOw6SQnWELUkK2BBfJsKPiVKwc549
OR5QvaqadDJOfSgdVZOg/YxO42F1YUxBrvALbG6+B7r684acLS3Xm+Vcy+X1StxO
svYa99KbleUaHrhxYs4h7ZgajJmSqZ5kj6sqvK8RED1ywTJIDARtC19+ehbh9l0I
TAeWln6iq/ybXBkxYmQQHm9FkEsZt9XmVNKxjxmUpCd/Gvlby5eJ4KddCNuiOQms
HX2D/t4kAmrtEc3gSVhwdWYMU5DO+3rQbIXUUBgQKJMBYRv+ldYyK1UMP+U5NvC7
Sh3NXtvKAHf4ROWw7eubCmDCOdZLH6ZGNSUCJe2QCCMlQXExx47+qw8J/YVQcupc
7NEs3GOmpMIlmsYe4aa3qRfvD6xRlqDrUh5TBQQgDcVz/3hLmdEP0qvTnvCcjRTh
dEyxhuNaGDtaoZJLlekA
=C7kL
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
