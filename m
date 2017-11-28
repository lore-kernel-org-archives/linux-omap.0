From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Tue, 28 Nov 2017 11:23:27 +0100
Message-ID: <20171128102327.GA30267@lenoch>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
 <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
 <1511833514.32426.86.camel@perches.com>
 <7e7e64cf-dbe5-614a-f1e5-29d7b6cf9297@users.sourceforge.net>
 <1511856244.19952.14.camel@perches.com>
 <0ecf4b17-7757-adb4-b978-a80ebb15cfe6@users.sourceforge.net>
 <alpine.DEB.2.20.1711281026410.3443@hadrien>
 <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <28816ce9-9d62-7d61-1889-64407eececca@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Joe Perches <joe@perches.com>, "Andrew F. Davis" <afd@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 28, 2017 at 11:15:37AM +0100, SF Markus Elfring wrote:
> >>> Many people do not know that a generic kmalloc does a
> >>> dump_stack() on OOM.
> >>
> >> This is another interesting information, isn't it?
> >>
> >> It is expected that the function “devm_kzalloc” has got a similar property.
> > 
> > 
> > You don't have to expect this.  Go look at the definition of devm_kzalloc
> > and see whether it has the property or not.
> 
> I find that the corresponding documentation of these programming interfaces
> is incomplete for a desired format which could be different than C source code.
> 
> https://elixir.free-electrons.com/linux/v4.15-rc1/source/include/linux/device.h#L657
> https://elixir.free-electrons.com/linux/v4.15-rc1/source/drivers/base/devres.c#L763
> https://www.kernel.org/doc/html/latest/driver-api/basics.html#c.devm_kmalloc
> 
> Can the Coccinelle software help more to determine desired function properties?
> 
> 
> >> For which hardware and software combinations would you like to see
> >> facts there?
> > 
> > This is not for Joe to decide,
> 
> This view is fine in principle.
> 
> 
> > it's for the person who receives the patch to decide.
> 
> I am curious on further comments from these contributors.
> 
> 
> > You could start with the ones for which the code actually compiles,
> > using the standard make file and no special options, and a
> > recent version of gcc.
> 
> The variation space could become too big to handle for me (alone).
> How will this aspect evolve further?

I do not follow. This is OMAP framebuffer driver, so in this case, there
is zero variation. Could you, please, review following patch and verify
is it satisfies your automated static code analysis test?

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 7a75dfda9845..6be13a106ece 100644
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
@@ -4078,9 +4059,9 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 
 	spin_lock_init(&dispc.control_lock);
 
-	r = dispc_init_features(dispc.pdev);
-	if (r)
-		return r;
+	dispc.feat = dispc_get_features();
+	if (!dispc.feat)
+		return -ENODEV;
 
 	dispc_mem = platform_get_resource(dispc.pdev, IORESOURCE_MEM, 0);
 	if (!dispc_mem) {
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 48c6500c24e1..9a255ffe77c5 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -887,58 +887,37 @@ static const struct dss_features dra7xx_dss_feats = {
 	.num_ports		=	ARRAY_SIZE(dra7xx_ports),
 };
 
-static int dss_init_features(struct platform_device *pdev)
+static const struct dss_features* dss_get_features(void)
 {
-	const struct dss_features *src;
-	struct dss_features *dst;
-
-	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		dev_err(&pdev->dev, "Failed to allocate local DSS Features\n");
-		return -ENOMEM;
-	}
-
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
-		src = &omap24xx_dss_feats;
-		break;
+		return &omap24xx_dss_feats;
 
 	case OMAPDSS_VER_OMAP34xx_ES1:
 	case OMAPDSS_VER_OMAP34xx_ES3:
 	case OMAPDSS_VER_AM35xx:
-		src = &omap34xx_dss_feats;
-		break;
+		return &omap34xx_dss_feats;
 
 	case OMAPDSS_VER_OMAP3630:
-		src = &omap3630_dss_feats;
-		break;
+		return &omap3630_dss_feats;
 
 	case OMAPDSS_VER_OMAP4430_ES1:
 	case OMAPDSS_VER_OMAP4430_ES2:
 	case OMAPDSS_VER_OMAP4:
-		src = &omap44xx_dss_feats;
-		break;
+		return &omap44xx_dss_feats;
 
 	case OMAPDSS_VER_OMAP5:
-		src = &omap54xx_dss_feats;
-		break;
+		return &omap54xx_dss_feats;
 
 	case OMAPDSS_VER_AM43xx:
-		src = &am43xx_dss_feats;
-		break;
+		return &am43xx_dss_feats;
 
 	case OMAPDSS_VER_DRA7xx:
-		src = &dra7xx_dss_feats;
-		break;
+		return &dra7xx_dss_feats;
 
 	default:
-		return -ENODEV;
+		return NULL;
 	}
-
-	memcpy(dst, src, sizeof(*dst));
-	dss.feat = dst;
-
-	return 0;
 }
 
 static void dss_uninit_ports(struct platform_device *pdev);
@@ -1104,9 +1083,9 @@ static int dss_bind(struct device *dev)
 
 	dss.pdev = pdev;
 
-	r = dss_init_features(dss.pdev);
-	if (r)
-		return r;
+	dss.feat = dss_get_features();
+	if (!dss.feat)
+		return -ENODEV;
 
 	dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
 	if (!dss_mem) {
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index 9a13c35fd6d8..07d46e14cea4 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -189,47 +189,30 @@ static const struct hdmi_phy_features omap54xx_phy_feats = {
 	.max_phy	=	186000000,
 };
 
-static int hdmi_phy_init_features(struct platform_device *pdev)
+static const struct hdmi_phy_features* hdmi_phy_get_features(void)
 {
-	struct hdmi_phy_features *dst;
-	const struct hdmi_phy_features *src;
-
-	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		dev_err(&pdev->dev, "Failed to allocate HDMI PHY Features\n");
-		return -ENOMEM;
-	}
-
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP4430_ES1:
 	case OMAPDSS_VER_OMAP4430_ES2:
 	case OMAPDSS_VER_OMAP4:
-		src = &omap44xx_phy_feats;
-		break;
+		return &omap44xx_phy_feats;
 
 	case OMAPDSS_VER_OMAP5:
 	case OMAPDSS_VER_DRA7xx:
-		src = &omap54xx_phy_feats;
-		break;
+		return &omap54xx_phy_feats;
 
 	default:
-		return -ENODEV;
+		return NULL;
 	}
-
-	memcpy(dst, src, sizeof(*dst));
-	phy_feat = dst;
-
-	return 0;
 }
 
 int hdmi_phy_init(struct platform_device *pdev, struct hdmi_phy_data *phy)
 {
-	int r;
 	struct resource *res;
 
-	r = hdmi_phy_init_features(pdev);
-	if (r)
-		return r;
+	phy_feat = hdmi_phy_get_features();
+	if (!phy_feat)
+		return -ENODEV;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
 	if (!res) {
