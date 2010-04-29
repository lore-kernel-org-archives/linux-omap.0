From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 2/2] omap: gpmc-nand: add ability to keep timings defined
	by the bootloader
Date: Thu, 29 Apr 2010 09:57:24 +0530
Message-ID: <z2hce9ab5791004282127u817d6604oa65b8bf3b9957bda@mail.gmail.com>
References: <cover.1272470212.git.mike@compulab.co.il> <d97635d8d65238f8801db6bcf4e89e2fb1b44b17.1272470212.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55237 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933609Ab0D3UeZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:34:25 -0400
Received: by vws19 with SMTP id 19so546071vws.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 13:34:24 -0700 (PDT)
In-Reply-To: <d97635d8d65238f8801db6bcf4e89e2fb1b44b17.1272470212.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: tony@atomide.com, s-ghorai@ti.com, linux-omap@vger.kernel.org

On Wed, Apr 28, 2010 at 9:36 PM, Mike Rapoport <mike@compulab.co.il> wr=
ote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> =A0arch/arm/mach-omap2/gpmc-nand.c =A0 =A0 =A0 =A0| =A0 19 ++++++++++=
++++++++-
> =A0arch/arm/plat-omap/include/plat/nand.h | =A0 =A01 +
> =A02 files changed, 19 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gp=
mc-nand.c
> index e57fb29..7c6c027 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -22,6 +22,7 @@
> =A0#define WR_RD_PIN_MONITORING =A0 0x00600000
>
> =A0static struct omap_nand_platform_data *gpmc_nand_data;
> +static struct gpmc_timings gpmc_default_timings;
>
> =A0static struct resource gpmc_nand_resource =3D {
> =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D IORESOURCE_MEM,
> @@ -34,13 +35,24 @@ static struct platform_device gpmc_nand_device =3D=
 {
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D &gpmc_nand_resource,
> =A0};
>
> +static void gpmc_nand_detect_timings(void)
> +{
> + =A0 =A0 =A0 struct gpmc_timings t;
> +
> + =A0 =A0 =A0 memset(&t, 0, sizeof(t));
> + =A0 =A0 =A0 gpmc_cs_get_timings(gpmc_nand_data->cs, &gpmc_default_t=
imings);
> +}
> +
> =A0static int omap2_nand_gpmc_retime(void)
> =A0{
> + =A0 =A0 =A0 struct device *dev =3D &gpmc_nand_device.dev;
> =A0 =A0 =A0 =A0struct gpmc_timings t;
> =A0 =A0 =A0 =A0int err;
>
> - =A0 =A0 =A0 if (!gpmc_nand_data->gpmc_t)
> + =A0 =A0 =A0 if (!gpmc_nand_data->gpmc_t) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "No timings provided, ski=
pping retime\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0memset(&t, 0, sizeof(t));
> =A0 =A0 =A0 =A0t.sync_clk =3D gpmc_round_ns_to_ticks(gpmc_nand_data->=
gpmc_t->sync_clk);
> @@ -112,6 +124,11 @@ int __init gpmc_nand_init(struct omap_nand_platf=
orm_data *_nand_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (gpmc_nand_data->keep_timings) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_nand_detect_timings();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_nand_data->gpmc_t =3D &gpmc_defaul=
t_timings;
> + =A0 =A0 =A0 }
> +

I guess moving this part to omap2_nand_gpmc_retime will be a good idea.
As there, once we get old/default timings we can simply skip the
rounding part and directly jump to setting the timings.

Rest looks fine to me.

--=20
Regards,
Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
