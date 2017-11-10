From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3 4/7] mtd: onenand: omap2: Remove partitioning support
 from platform data
Date: Fri, 10 Nov 2017 10:48:06 +0100
Message-ID: <20171110094806.22i4q7jekigeozmo@lenoch>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091444.dxvoaaafjgkf43a2@lenoch>
 <de8a8a40-af31-01af-f523-6fa6dbca2a70@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <de8a8a40-af31-01af-f523-6fa6dbca2a70@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 10, 2017 at 10:19:11AM +0200, Roger Quadros wrote:
> On 09/11/17 11:14, Ladislav Michl wrote:
> > No platform data user setups partitioning informations, so remove.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  Changes:
> >  -v2: new patch
> >  -v3: none
> > 
> >  drivers/mtd/onenand/omap2.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> > index 93bd94337b35..883993bbe40b 100644
> > --- a/drivers/mtd/onenand/omap2.c
> > +++ b/drivers/mtd/onenand/omap2.c
> > @@ -703,8 +703,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
> >  	if ((r = onenand_scan(&c->mtd, 1)) < 0)
> >  		goto err_release_dma;
> >  
> > -	r = mtd_device_register(&c->mtd, pdata ? pdata->parts : NULL,
> > -				pdata ? pdata->nr_parts : 0);
> > +	r = mtd_device_register(&c->mtd, NULL, 0);
> >  	if (r)
> >  		goto err_release_onenand;
> >  
> > 
> 
> Same here. Need to update platform data structure.

I do not want to unnecessarily extend patch as I hope no sane maintainer
would ever allow anyone to add any new platform data dependency while
we are moving towards DT only configured kernel.

Platform data structure will be deleted entirely together with
arch/arm/mach-omap2/gpmc-onenand.c once driver update gets accepted.

	ladis

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
