From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC] ARM: OMAP4470: Fix OMAP4470 boot failure
Date: Mon, 18 Jun 2012 15:03:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206181435560.11642@utopia.booyaka.com>
References: <1339110048-13677-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1043828845-1340053429=:11642"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41764 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab2FRVDt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 17:03:49 -0400
In-Reply-To: <1339110048-13677-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1043828845-1340053429=:11642
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jon,

On Thu, 7 Jun 2012, Jon Hunter wrote:

> The problem is that currently none of the clocks are being registered for
> OMAP4470 devices and so on boot-up no clocks can be found and the kernel =
panics.
>=20
> This fix always the kernel to boot without failure using a simple RAMDISK=
 file
> system. However, I need some inputs from the clock guru's if this is the
> correct fix :-)
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

I guess Beno=EEt should make the call on this, since he's got access to the=
=20
hardware data to use to autogenerate these clocks.  If there aren't any=20
differences between the 4460 and 4470 clocks and dividers, then your=20
patch looks good to me. =20

If there are any differences between the 4460 and 4470 clocks and=20
dividers, we should probably wait until the common clock conversion is=20
complete, since that would presumably be a large change.

Just my 2 cents,=20

- Paul


> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/c=
lock44xx_data.c
> index 2172f66..19275e8 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3412,7 +3412,7 @@ int __init omap4xxx_clk_init(void)
>  =09if (cpu_is_omap443x()) {
>  =09=09cpu_mask =3D RATE_IN_4430;
>  =09=09cpu_clkflg =3D CK_443X;
> -=09} else if (cpu_is_omap446x()) {
> +=09} else if (cpu_is_omap446x() || cpu_is_omap447x()) {
>  =09=09cpu_mask =3D RATE_IN_4460 | RATE_IN_4430;
>  =09=09cpu_clkflg =3D CK_446X | CK_443X;
>  =09} else {
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


- Paul
--155748971-1043828845-1340053429=:11642--
