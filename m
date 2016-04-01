From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] of/platform: Allow secondary compatible match in
 of_dev_lookup
Date: Fri, 1 Apr 2016 14:40:54 -0700
Message-ID: <20160401214053.GQ9329@atomide.com>
References: <1459546504-32668-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459546504-32668-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160401 14:37]:
> We currently try to match of_dev_auxdata based on compatible,
> IO address, and device name. But in some cases we have multiple
> instances of drivers that can use the same auxdata.
> 
> Let's add an additional secondary lookup for generic compatible
> match for auxdata if no device specific match is found. This does
> not change the existing matching, and still allows adding device
> specific auxdata.
> 
> This simplifies things as specifying the IO address and device
> name is prone errors as it requires maintaining an in kernel
> database for each SoC.

And here's what I can apply later on to get rid of some
ifdeffery.

I'm also planning to move some of the legacy omap hwmod
functionality into proper device drivers, so can generic
pdata for that too.

Cheers,

Tony

8< -----------------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 1 Apr 2016 13:57:49 -0700
Subject: [PATCH] ARM: OMAP2+: Simplify auxdata by using the generic match

We can now just use the compatible if there's no need to have
device instance specific auxdata.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -492,9 +492,6 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("tlv320aic3x", 0x18, "2-0018", &n810_aic33_data),
 #endif
 #ifdef CONFIG_ARCH_OMAP3
-	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
-	OF_DEV_AUXDATA("ti,omap3-padconf", 0x480025a0, "480025a0.pinmux", &pcs_pdata),
-	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
 		       &omap3_iommu_pdata),
 	/* Only on am3517 */
@@ -506,19 +503,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,am3352-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
 		       &wkup_m3_data),
 #endif
-#ifdef CONFIG_ARCH_OMAP4
-	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
-	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
-#endif
-#ifdef CONFIG_SOC_OMAP5
-	OF_DEV_AUXDATA("ti,omap5-padconf", 0x4a002840, "4a002840.pinmux", &pcs_pdata),
-	OF_DEV_AUXDATA("ti,omap5-padconf", 0x4ae0c840, "4ae0c840.pinmux", &pcs_pdata),
-#endif
-#ifdef CONFIG_SOC_DRA7XX
-	OF_DEV_AUXDATA("ti,dra7-padconf", 0x4a003400, "4a003400.pinmux", &pcs_pdata),
-#endif
 #ifdef CONFIG_SOC_AM43XX
-	OF_DEV_AUXDATA("ti,am437-padconf", 0x44e10800, "44e10800.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
 		       &wkup_m3_data),
 #endif
@@ -531,6 +516,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x55082000, "55082000.mmu",
 		       &omap4_iommu_pdata),
 #endif
+	/* Common auxdata */
+	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
 	{ /* sentinel */ },
 };
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
