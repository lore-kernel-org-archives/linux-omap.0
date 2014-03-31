From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/55] ARM: OMAP4: CM: use cm_base* in register address
 calculations
Date: Mon, 31 Mar 2014 10:20:19 -0500
Message-ID: <20140331152013.GD7760@saruman.home>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
 <1396278994-12624-2-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59267 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbaCaPWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:22:41 -0400
Content-Disposition: inline
In-Reply-To: <1396278994-12624-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 06:15:40PM +0300, Tero Kristo wrote:
> OMAP44XX_CM*_REGADDR macros should be avoided, instead use the cm_base*
> iomaps.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/cm44xx.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
> index 535d66e..5627072 100644
> --- a/arch/arm/mach-omap2/cm44xx.c
> +++ b/arch/arm/mach-omap2/cm44xx.c
> @@ -30,23 +30,23 @@
>  /* Read a register in CM1 */
>  u32 omap4_cm1_read_inst_reg(s16 inst, u16 reg)
>  {
> -	return __raw_readl(OMAP44XX_CM1_REGADDR(inst, reg));
> +	return __raw_readl(cm_base + inst + reg);

should you use readl() or readl_relaxed() instead ? It'll take care of
endianness, right ?

--=20
balbi

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTOYetAAoJEIaOsuA1yqRE4eAQAIgDDL05Z2MG6ezUn6lwzydJ
6nBsxUwY3MaJpcte+PIh7Pf8ggSeBkOnIYfODCVWxQRLn5XRZAITPa3pZN7RjdtN
Mnh8AkorL0pDxbxtRU2rzTo3HPWFYOBslzrlzY/yEiGtU9QFMUmRafDEA9hDUqGo
qTZWHr2oETv6SVit5+uY9s2GMO5Ttjzl7mPNYntv+ESM5Q0K3PheRzqKfWX519Hl
aiSVsbrF07TPI69ab2OHu+7ZjL13+KYaB4dy9BBxeCJKq2SCcX61I9TMIyxWYj4X
eN9Lg1rrjvUnd1xD0ypH6PnhK4KxXut7BmNK6kE7YMgv4FFRFXlpzSLbvxRIW04s
8voaxHwzBy4KrmwtetJI2bSDKhdSJNuf+yT95sxuzZvj08nnsLPX/fuP0D2Bj2yr
v5PGplD+PD8Ob5pqSexmJ7Ieap6whWHj7FUNjTRZAxD2c67QlqZ5QhTjoTfc8OID
fWpg8zaJ4jJLIv1D+Ode51uiiZ8D1OVcLaoCCyJsuyRvTVTSl9aSWRNCOV2CfCD1
DplGTirSmF6IMZV3HjyiTxmnkzsqjR26FlfFVXCpilAjSDjRivClCFPBhisFZib+
GINkgeWwdUpIWEOwq5Gry3b5shO7vb9KPj7JMUYSnxaLVEYhKeN24z4/1QXkb6Ms
UfeRyGK3Oli4lCcGri03
=gi0U
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
