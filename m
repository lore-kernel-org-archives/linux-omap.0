From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Mon, 27 Nov 2017 23:20:56 +0100
Message-ID: <20171127222056.GA10361@lenoch>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <502de06b-ca86-d0ff-bd50-d260fbe46fe5@users.sourceforge.net>
 <20171127174454.GA18851@lenoch>
 <5e90409f-fcb0-cdb6-9bc3-26ad30a1f7c9@users.sourceforge.net>
 <20171127192251.GA23081@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171127192251.GA23081@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 27, 2017 at 08:22:51PM +0100, Ladislav Michl wrote:
> On Mon, Nov 27, 2017 at 07:12:50PM +0100, SF Markus Elfring wrote:
> > >> Can a default allocation failure report provide the information
> > >> which you might expect so far?
> > > 
> > > You should be able to answer that question yourself.
> > 
> > I can not answer this detail completely myself because my knowledge
> > is incomplete about your concrete expectations for the exception handling
> > which can lead to different views for the need of additional error messages.
> 
> The rule is to be able to get idea what failed without recompiling kernel.
> If you think you can point to failed allocation with your changes, then
> you might be able to convice Andrew your change is an improvement.
> 
> > > And if you are unable to do so, just do not sent changes pointed
> > > by any code analysis tools.
> > 
> > They can point aspects out for further software development considerations,
> > can't they?
> 
> So?
> 
> > > As a side note, if you look at whole call chain, you'll find quite some
> > > room for optimizations - look how dev and pdev are used. That also applies
> > > to other patches.
> > 
> > Would you prefer to improve the source code in other ways?
> 
> I would prefer you to look at code as a whole, not as an isolated set
> of lines which can be changes to shut up some random warning obtained
> from code analysis tool.
> 
> Behold, here we saved over 100 bytes just by minor clean up. Patch
> is a mess, should be probably polished and splitted, but you'll get
> an idea. That said, we saved more than by deleting one error message
> and if you can prove we will not loose information _what_ failed
> with your patch, we can save even more.

Well, if we remove allocation, we do not need to print error message...
And numbers are even better.

>    text	   data	    bss	    dec	    hex	filename
>   59319	   2372	   4184	  65875	  10153	dispc.o.orig
>   59178	   2372	   4184	  65734	  100c6	dispc.o
    59095	   2372	   4184	  65651	  10073	dispc.o.noalloc

Care to test this? It is a mess of unrelated changes, but I'm just
interested if it works...

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 7a75dfda9845..f6d631a68c70 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -3976,52 +3976,33 @@ static const struct dispc_features omap54xx_dispc_feats = {
 	.has_writeback		=	true,
 };
 
-static int dispc_init_features(struct platform_device *pdev)
+static const struct dispc_features* dispc_get_features(void)
 {
-	const struct dispc_features *src;
-	struct dispc_features *dst;
-
-	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		dev_err(&pdev->dev, "Failed to allocate DISPC Features\n");
-		return -ENOMEM;
-	}
-
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
-		src = &omap24xx_dispc_feats;
-		break;
+		return &omap24xx_dispc_feats;
 
 	case OMAPDSS_VER_OMAP34xx_ES1:
-		src = &omap34xx_rev1_0_dispc_feats;
-		break;
+		return &omap34xx_rev1_0_dispc_feats;
 
 	case OMAPDSS_VER_OMAP34xx_ES3:
 	case OMAPDSS_VER_OMAP3630:
 	case OMAPDSS_VER_AM35xx:
 	case OMAPDSS_VER_AM43xx:
-		src = &omap34xx_rev3_0_dispc_feats;
-		break;
+		return &omap34xx_rev3_0_dispc_feats;
 
 	case OMAPDSS_VER_OMAP4430_ES1:
 	case OMAPDSS_VER_OMAP4430_ES2:
 	case OMAPDSS_VER_OMAP4:
-		src = &omap44xx_dispc_feats;
-		break;
+		return &omap44xx_dispc_feats;
 
 	case OMAPDSS_VER_OMAP5:
 	case OMAPDSS_VER_DRA7xx:
-		src = &omap54xx_dispc_feats;
-		break;
+		return &omap54xx_dispc_feats;
 
 	default:
-		return -ENODEV;
+		return NULL;
 	}
-
-	memcpy(dst, src, sizeof(*dst));
-	dispc.feat = dst;
-
-	return 0;
 }
 
 static irqreturn_t dispc_irq_handler(int irq, void *arg)
@@ -4068,54 +4049,53 @@ EXPORT_SYMBOL(dispc_free_irq);
 /* DISPC HW IP initialisation */
 static int dispc_bind(struct device *dev, struct device *master, void *data)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	u32 rev;
 	int r = 0;
 	struct resource *dispc_mem;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 
-	dispc.pdev = pdev;
+	dispc.pdev = to_platform_device(dev);
 
 	spin_lock_init(&dispc.control_lock);
 
-	r = dispc_init_features(dispc.pdev);
-	if (r)
-		return r;
+	dispc.feat = dispc_get_features();
+	if (dispc.feat)
+		return -ENODEV;
 
 	dispc_mem = platform_get_resource(dispc.pdev, IORESOURCE_MEM, 0);
 	if (!dispc_mem) {
-		DSSERR("can't get IORESOURCE_MEM DISPC\n");
+		dev_err(dev, "can't get IORESOURCE_MEM DISPC\n");
 		return -EINVAL;
 	}
 
-	dispc.base = devm_ioremap(&pdev->dev, dispc_mem->start,
+	dispc.base = devm_ioremap(dev, dispc_mem->start,
 				  resource_size(dispc_mem));
 	if (!dispc.base) {
-		DSSERR("can't ioremap DISPC\n");
+		dev_err(dev, "can't ioremap DISPC\n");
 		return -ENOMEM;
 	}
 
 	dispc.irq = platform_get_irq(dispc.pdev, 0);
 	if (dispc.irq < 0) {
-		DSSERR("platform_get_irq failed\n");
+		dev_err(dev, "platform_get_irq failed\n");
 		return -ENODEV;
 	}
 
 	if (np && of_property_read_bool(np, "syscon-pol")) {
 		dispc.syscon_pol = syscon_regmap_lookup_by_phandle(np, "syscon-pol");
 		if (IS_ERR(dispc.syscon_pol)) {
-			dev_err(&pdev->dev, "failed to get syscon-pol regmap\n");
+			dev_err(dev, "failed to get syscon-pol regmap\n");
 			return PTR_ERR(dispc.syscon_pol);
 		}
 
 		if (of_property_read_u32_index(np, "syscon-pol", 1,
 				&dispc.syscon_pol_offset)) {
-			dev_err(&pdev->dev, "failed to get syscon-pol offset\n");
+			dev_err(dev, "failed to get syscon-pol offset\n");
 			return -EINVAL;
 		}
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	r = dispc_runtime_get();
 	if (r)
@@ -4124,7 +4104,7 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 	_omap_dispc_initial_config();
 
 	rev = dispc_read_reg(DISPC_REVISION);
-	dev_dbg(&pdev->dev, "OMAP DISPC rev %d.%d\n",
+	dev_dbg(dev, "OMAP DISPC rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
 	dispc_runtime_put();
@@ -4136,7 +4116,7 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 
 err_runtime_get:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	return r;
 }
 
