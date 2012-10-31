From: Vivek Gautam <gautamvivek1987-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] USB: DWC3: EXYNOS: Remove platform data for dwc3-exynos
Date: Wed, 31 Oct 2012 17:36:03 +0530
Message-ID: <CAFp+6iE6cbF+2F5jgS9kH6_AzbwMksQfkPdjRqQiGV0Yu5oC2Q@mail.gmail.com>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
	<1350377157-28465-3-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350377157-28465-3-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi all,


On Tue, Oct 16, 2012 at 2:15 PM, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> We are removing plat data which was used till now to init and
> exit phy. We no longer need this since dwc3-core takes care of
> initializing and shutting-down the phy using usb_phy_init()
> and usb_phy_shutdown().
>
> Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Any thoughts on this please ?

> ---
>  drivers/usb/dwc3/dwc3-exynos.c |   16 ----------------
>  1 files changed, 0 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index d11ef49..5a2a73f 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -92,7 +92,6 @@ static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
>
>  static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>  {
> -       struct dwc3_exynos_data *pdata = pdev->dev.platform_data;
>         struct platform_device  *dwc3;
>         struct dwc3_exynos      *exynos;
>         struct clk              *clk;
> @@ -150,14 +149,6 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>
>         clk_enable(exynos->clk);
>
> -       /* PHY initialization */
> -       if (!pdata) {
> -               dev_dbg(&pdev->dev, "missing platform data\n");
> -       } else {
> -               if (pdata->phy_init)
> -                       pdata->phy_init(pdev, pdata->phy_type);
> -       }
> -
>         ret = platform_device_add_resources(dwc3, pdev->resource,
>                         pdev->num_resources);
>         if (ret) {
> @@ -174,9 +165,6 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>         return 0;
>
>  err4:
> -       if (pdata && pdata->phy_exit)
> -               pdata->phy_exit(pdev, pdata->phy_type);
> -
>         clk_disable(clk);
>         clk_put(clk);
>  err3:
> @@ -192,7 +180,6 @@ err0:
>  static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
>  {
>         struct dwc3_exynos      *exynos = platform_get_drvdata(pdev);
> -       struct dwc3_exynos_data *pdata = pdev->dev.platform_data;
>
>         platform_device_unregister(exynos->dwc3);
>         platform_device_unregister(exynos->usb2_phy);
> @@ -200,9 +187,6 @@ static int __devexit dwc3_exynos_remove(struct platform_device *pdev)
>
>         dwc3_put_device_id(exynos->dwc3->id);
>
> -       if (pdata && pdata->phy_exit)
> -               pdata->phy_exit(pdev, pdata->phy_type);
> -
>         clk_disable(exynos->clk);
>         clk_put(exynos->clk);
>
> --
> 1.7.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Thanks & Regards
Vivek
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
