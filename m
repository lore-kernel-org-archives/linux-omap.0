From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/6] ARM: OMAP3/4: iommu: adapt to runtime pm
Date: Fri, 12 Oct 2012 09:48:33 +0200
Message-ID: <CAMP44s2LTGPnXQuetVLV1tA8w90gUtoJ5coucBUZsbqb3vFnng@mail.gmail.com>
References: <1350003977-32744-1-git-send-email-omar.luna@linaro.org>
	<1350003977-32744-5-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1350003977-32744-5-git-send-email-omar.luna@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Joerg Roedel <joerg.roedel@amd.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 12, 2012 at 3:06 AM, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations and sysconfig
> handling.
>
> Dues to reset sequence, pm_runtime_put_sync must be used, to avoid
> possible operations with the module under reset.

I already made most of these comments, but here they go again.

> @@ -142,11 +142,10 @@ static int iommu_enable(struct omap_iommu *obj)
>                 }
>         }
>
> -       clk_enable(obj->clk);
> +       pm_runtime_get_sync(obj->dev);
>
>         err = arch_iommu->enable(obj);
>
> -       clk_disable(obj->clk);

The device will never go to sleep, until iommu_disable is called.
clk_enable -> pm_runtime_get_sync, clk_disable pm_runtime_put.

> @@ -288,7 +285,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>         if (!obj || !obj->nr_tlb_entries || !e)
>                 return -EINVAL;
>
> -       clk_enable(obj->clk);
> +       pm_runtime_get_sync(obj->dev);
>
>         iotlb_lock_get(obj, &l);
>         if (l.base == obj->nr_tlb_entries) {
> @@ -318,7 +315,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>
>         cr = iotlb_alloc_cr(obj, e);
>         if (IS_ERR(cr)) {
> -               clk_disable(obj->clk);
> +               pm_runtime_put_sync(obj->dev);
>                 return PTR_ERR(cr);
>         }

If I'm correct, the above pm_runtime_get/put are redundant, because
the count can't possibly reach 0 because of the reason I explained
before.

The same for all the cases below.

> @@ -1009,7 +1001,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
>         release_mem_region(res->start, resource_size(res));
>         iounmap(obj->regbase);
>
> -       clk_put(obj->clk);
> +       pm_runtime_disable(obj->dev);

This will turn on the device unnecessarily, wasting power, and there's
no need for that, kfree will take care of that without resuming.

>         dev_info(&pdev->dev, "%s removed\n", obj->name);
>         kfree(obj);
>         return 0;

Also, I still think that something like this is needed:

--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -2222,8 +2222,17 @@ static struct clk cam_mclk = {
        .recalc         = &followparent_recalc,
 };

+static struct clk cam_fck = {
+       .name           = "cam_fck",
+       .ops            = &clkops_omap2_iclk_dflt,
+       .parent         = &l3_ick,
+       .enable_reg     = OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
+       .enable_bit     = OMAP3430_EN_CAM_SHIFT,
+       .clkdm_name     = "cam_clkdm",
+       .recalc         = &followparent_recalc,
+};
+
 static struct clk cam_ick = {
-       /* Handles both L3 and L4 clocks */
        .name           = "cam_ick",
        .ops            = &clkops_omap2_iclk_dflt,
        .parent         = &l4_ick,
@@ -3394,6 +3403,7 @@ static struct omap_clk omap3xxx_clks[] = {
        CLK("omapdss_dss",      "ick",          &dss_ick_3430es2,
 CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
        CLK(NULL,       "dss_ick",              &dss_ick_3430es2,
 CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
        CLK(NULL,       "cam_mclk",     &cam_mclk,      CK_34XX | CK_36XX),
+       CLK(NULL,       "cam_fck",      &cam_fck,       CK_34XX | CK_36XX),
        CLK(NULL,       "cam_ick",      &cam_ick,       CK_34XX | CK_36XX),
        CLK(NULL,       "csi2_96m_fck", &csi2_96m_fck,  CK_34XX | CK_36XX),
        CLK(NULL,       "usbhost_120m_fck", &usbhost_120m_fck,
CK_3430ES2PLUS | CK_AM35XX | CK_36XX),

Cheers.

-- 
Felipe Contreras
