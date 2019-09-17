From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: use devm_platform_ioremap_resource()
 to simplify code
Date: Tue, 17 Sep 2019 20:35:51 +0200
Message-ID: <CAMuHMdXdd4oiHqTpFTYBTSeCB6A78_gSGmwPy5EgPRZXibOqZw@mail.gmail.com>
References: <20190821124850.9592-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190821124850.9592-1-yuehaibing@huawei.com>
Sender: netdev-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, ivan.khoronzhuk@linaro.org, Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi YueHaibing,

On Wed, Aug 21, 2019 at 2:51 PM YueHaibing <yuehaibing@huawei.com> wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 32a8974..5401095 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -2764,7 +2764,7 @@ static int cpsw_probe(struct platform_device *pdev)
>         struct net_device               *ndev;
>         struct cpsw_priv                *priv;
>         void __iomem                    *ss_regs;
> -       struct resource                 *res, *ss_res;
> +       struct resource                 *ss_res;
>         struct gpio_descs               *mode;
>         const struct soc_device_attribute *soc;
>         struct cpsw_common              *cpsw;
> @@ -2798,8 +2798,7 @@ static int cpsw_probe(struct platform_device *pdev)

And just out-of-context, we also have:

        ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
        ss_regs = devm_ioremap_resource(dev, ss_res);
        if (IS_ERR(ss_regs))

which was not detected as being the same pattern?

Interesting...

>                 return PTR_ERR(ss_regs);
>         cpsw->regs = ss_regs;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -       cpsw->wr_regs = devm_ioremap_resource(dev, res);
> +       cpsw->wr_regs = devm_platform_ioremap_resource(pdev, 1);
>         if (IS_ERR(cpsw->wr_regs))
>                 return PTR_ERR(cpsw->wr_regs);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
