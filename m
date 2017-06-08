From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 07/11] ARM: OMAP2+: Remove unused legacy code for DMA
Date: Thu, 8 Jun 2017 09:25:47 +0300
Message-ID: <10f65a24-0459-5df7-378d-84933b83c070@ti.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-8-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-8-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony,

On 2017-06-01 01:51, Tony Lindgren wrote:
> We are now booting all mach-omap2 in device tree only mode.
> Any code that is only called in legacy boot mode where
> of_have_populated_dt() is not set is safe to remove now.
> =

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/dma.c | 30 +-----------------------------
>  1 file changed, 1 insertion(+), 29 deletions(-)
> =

> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -334,20 +334,6 @@ static int __init omap2_system_dma_init_dev(struct o=
map_hwmod *oh, void *unused)
>  	p.dma_attr =3D (struct omap_dma_dev_attr *)oh->dev_attr;
>  	p.errata =3D configure_dma_errata();
>  =

> -	if (!of_have_populated_dt()) {
> -		if (soc_is_omap24xx()) {
> -			p.slave_map =3D omap24xx_sdma_map;
> -			p.slavecnt =3D ARRAY_SIZE(omap24xx_sdma_map);
> -		} else if (soc_is_omap34xx() || soc_is_omap3630()) {
> -			p.slave_map =3D omap3xxx_sdma_map;
> -			p.slavecnt =3D ARRAY_SIZE(omap3xxx_sdma_map);
> -		} else {
> -			pr_err("%s: The legacy DMA map is not provided!\n",
> -			       __func__);
> -			return -ENODEV;
> -		}
> -	}
> -

This will conflict with the changes introduced by the tusb6010 DMAengine
conversion:
https://patchwork.kernel.org/patch/9734219/

with this patch I think the omap24xx_sdma_map and omap3xxx_sdma_map can
also be removed, but we need to keep the omap24xx_sdma_dt_map for now
till we have proper DT support for tusb.

>  	pdev =3D omap_device_build(name, 0, oh, &p, sizeof(p));
>  	if (IS_ERR(pdev)) {
>  		pr_err("%s: Can't build omap_device for %s:%s.\n",
> @@ -389,21 +375,7 @@ static int __init omap2_system_dma_init_dev(struct o=
map_hwmod *oh, void *unused)
>  =

>  static int __init omap2_system_dma_init(void)
>  {
> -	struct platform_device *pdev;
> -	int res;
> -
> -	res =3D omap_hwmod_for_each_by_class("dma",
> +	return omap_hwmod_for_each_by_class("dma",
>  			omap2_system_dma_init_dev, NULL);
> -	if (res)
> -		return res;
> -
> -	if (of_have_populated_dt())
> -		return res;
> -
> -	pdev =3D platform_device_register_full(&omap_dma_dev_info);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> -
> -	return res;
>  }
>  omap_arch_initcall(omap2_system_dma_init);
> =


- P=E9ter
