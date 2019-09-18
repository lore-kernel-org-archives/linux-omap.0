From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: use devm_platform_ioremap_resource()
 to simplify code
Date: Wed, 18 Sep 2019 11:35:59 +0200
Message-ID: <CAMuHMdW4Yzd6tMP=mTWvcVdeCbKiDE+Nm2V=73Wsbc5rG6uYNQ@mail.gmail.com>
References: <20190821124850.9592-1-yuehaibing@huawei.com> <CAMuHMdXdd4oiHqTpFTYBTSeCB6A78_gSGmwPy5EgPRZXibOqZw@mail.gmail.com>
 <12c00786-980f-5761-3117-3e741e63d7b3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12c00786-980f-5761-3117-3e741e63d7b3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: YueHaibing <yuehaibing@huawei.com>, "David S. Miller" <davem@davemloft.net>, ivan.khoronzhuk@linaro.org, Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On Wed, Sep 18, 2019 at 11:29 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 17/09/2019 21:35, Geert Uytterhoeven wrote:
> > On Wed, Aug 21, 2019 at 2:51 PM YueHaibing <yuehaibing@huawei.com> wrote:
> >> Use devm_platform_ioremap_resource() to simplify the code a bit.
> >> This is detected by coccinelle.
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>   drivers/net/ethernet/ti/cpsw.c | 5 ++---
> >>   1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> >> index 32a8974..5401095 100644
> >> --- a/drivers/net/ethernet/ti/cpsw.c
> >> +++ b/drivers/net/ethernet/ti/cpsw.c
> >> @@ -2764,7 +2764,7 @@ static int cpsw_probe(struct platform_device *pdev)
> >>          struct net_device               *ndev;
> >>          struct cpsw_priv                *priv;
> >>          void __iomem                    *ss_regs;
> >> -       struct resource                 *res, *ss_res;
> >> +       struct resource                 *ss_res;
> >>          struct gpio_descs               *mode;
> >>          const struct soc_device_attribute *soc;
> >>          struct cpsw_common              *cpsw;
> >> @@ -2798,8 +2798,7 @@ static int cpsw_probe(struct platform_device *pdev)
> >
> > And just out-of-context, we also have:
> >
> >          ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >          ss_regs = devm_ioremap_resource(dev, ss_res);
> >          if (IS_ERR(ss_regs))
> >
> > which was not detected as being the same pattern?
> >
> > Interesting...
>
> ss_res is used below to determine phys address of CPPI RAM.

Right, thanks, I missed that.

> >
> >>                  return PTR_ERR(ss_regs);
> >>          cpsw->regs = ss_regs;
> >>
> >> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >> -       cpsw->wr_regs = devm_ioremap_resource(dev, res);
> >> +       cpsw->wr_regs = devm_platform_ioremap_resource(pdev, 1);
> >>          if (IS_ERR(cpsw->wr_regs))
> >>                  return PTR_ERR(cpsw->wr_regs);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
