From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RESEND PATCH] mtd: nand: omap2: Remove omap_nand_platform_data
Date: Thu, 12 Oct 2017 13:38:37 +0200
Message-ID: <20171012133837.13bfe1e4@bbrezillon>
References: <20171006103543.gnb2hxq7msallyzl@lenoch>
 <20171010114047.202d7d44@bbrezillon>
 <2cd668a5-1c53-ea90-b7d3-47ddad71c23a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <2cd668a5-1c53-ea90-b7d3-47ddad71c23a@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Richard Weinberger <richard@nod.at>, linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 12 Oct 2017 14:28:45 +0300
Roger Quadros <rogerq@ti.com> wrote:

> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> On 10/10/17 12:40, Boris Brezillon wrote:
> > On Fri, 6 Oct 2017 12:35:43 +0200
> > Ladislav Michl <ladis@linux-mips.org> wrote:
> >  
> >> As driver is now configured using DT, omap_nand_platform_data structure
> >> is no longer needed.
> >>
> >> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> >> ---
> >>  Resend to linux-mtd as other part this patch was depending on
> >>  was merged months ago via linux-omap tree...
> >>
> >>  drivers/mtd/nand/omap2.c                     | 40 +++++++---------------------
> >>  include/linux/platform_data/mtd-nand-omap2.h | 17 ------------
> >>  2 files changed, 10 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> >> index 54540c8fa1a2..b1fc070c8279 100644
> >> --- a/drivers/mtd/nand/omap2.c
> >> +++ b/drivers/mtd/nand/omap2.c
> >> @@ -1588,8 +1588,7 @@ static bool is_elm_present(struct omap_nand_info *info,
> >>      return true;
> >>  }
> >>
> >> -static bool omap2_nand_ecc_check(struct omap_nand_info *info,
> >> -                             struct omap_nand_platform_data *pdata)
> >> +static bool omap2_nand_ecc_check(struct omap_nand_info *info)
> >>  {
> >>      bool ecc_needs_bch, ecc_needs_omap_bch, ecc_needs_elm;
> >>
> >> @@ -1804,7 +1803,6 @@ static const struct mtd_ooblayout_ops omap_sw_ooblayout_ops = {
> >>  static int omap_nand_probe(struct platform_device *pdev)
> >>  {
> >>      struct omap_nand_info           *info;
> >> -    struct omap_nand_platform_data  *pdata = NULL;
> >>      struct mtd_info                 *mtd;
> >>      struct nand_chip                *nand_chip;
> >>      int                             err;
> >> @@ -1814,6 +1812,9 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>      int                             min_oobbytes = BADBLOCK_MARKER_LENGTH;
> >>      int                             oobbytes_per_step;
> >>
> >> +    if (!dev->of_node)
> >> +            return -EINVAL;
> >> +  
> >
> > Is this really needed? I expect omap_get_dt_info() to return an error
> > when dev->of_node is NULL.
> >  
> >>      info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
> >>                              GFP_KERNEL);
> >>      if (!info)
> >> @@ -1821,29 +1822,9 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>
> >>      info->pdev = pdev;
> >>
> >> -    if (dev->of_node) {
> >> -            if (omap_get_dt_info(dev, info))
> >> -                    return -EINVAL;
> >> -    } else {
> >> -            pdata = dev_get_platdata(&pdev->dev);
> >> -            if (!pdata) {
> >> -                    dev_err(&pdev->dev, "platform data missing\n");
> >> -                    return -EINVAL;
> >> -            }
> >> -
> >> -            info->gpmc_cs = pdata->cs;
> >> -            info->reg = pdata->reg;
> >> -            info->ecc_opt = pdata->ecc_opt;
> >> -            if (pdata->dev_ready)
> >> -                    dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
> >> -
> >> -            info->xfer_type = pdata->xfer_type;
> >> -            info->devsize = pdata->devsize;
> >> -            info->elm_of_node = pdata->elm_of_node;
> >> -            info->flash_bbt = pdata->flash_bbt;
> >> -    }
> >> +    if (omap_get_dt_info(dev, info))
> >> +            return -EINVAL;  
> 
> how about
> 
>         err = omap_get_dt_info(dev, info);
>         if (err)
>                 return err;

Already done like that in v2 [1]

> 
> >>
> >> -    platform_set_drvdata(pdev, info);  
> >
> > This removal seems unrelated to the change you're describing in the
> > commit log. I'm not saying we should keep this platform_set_drvdata()
> > if it's useless, but it should be done in a separate patch.  
> 
> we do use platform_get_drvdata() in omap_nand_remove() so I suppose
> we can't get rid of platorm_set_drvdata().

There's another platform_set_drvdata() later in the probe function, I
think this one is indeed useless (see patch [2])

[1]http://patchwork.ozlabs.org/patch/823820/
[2]http://patchwork.ozlabs.org/patch/823839/

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
