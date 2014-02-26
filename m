From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 10/16] ARM: OMAP2+: use pdata quirks for iommu reset
	lines
Date: Wed, 26 Feb 2014 09:17:32 -0800
Message-ID: <20140226171731.GG11654@atomide.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
	<1392315347-32967-11-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392315347-32967-11-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [140213 10:19]:
> The OMAP iommu driver performs the reset management for the
> iommu instances in processor sub-systems using the omap_device
> API which are currently supplied as platform data ops. Use pdata
> quirks to maintain the functionality as the OMAP iommu driver
> gets converted to use DT nodes, until the reset portions are
> decoupled from omap_hwmod/omap_device into a separate reset
> driver.
> 
> This patch adds the pdata quirks for the reset management of
> iommus within the DSP (OMAP3 & OMAP4) and IPU subsystems (OMAP4).
> 
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

Looks OK, but I suggest you separate out the remaining patches in
this series into another clean-up series. Then the clean-up series
can be merged later on as these have a good chance of conflicting
with other stuff.

Tony

> ---
>  arch/arm/mach-omap2/pdata-quirks.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 3d5b24d..74e094a 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -16,12 +16,14 @@
>  #include <linux/wl12xx.h>
>  
>  #include <linux/platform_data/pinctrl-single.h>
> +#include <linux/platform_data/iommu-omap.h>
>  
>  #include "am35xx.h"
>  #include "common.h"
>  #include "common-board-devices.h"
>  #include "dss-common.h"
>  #include "control.h"
> +#include "omap_device.h"
>  
>  struct pdata_init {
>  	const char *compatible;
> @@ -92,6 +94,12 @@ static void __init hsmmc2_internal_input_clk(void)
>  	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
>  }
>  
> +static struct iommu_platform_data omap3_iommu_pdata = {
> +	.reset_name = "mmu",
> +	.assert_reset = omap_device_assert_hardreset,
> +	.deassert_reset = omap_device_deassert_hardreset,
> +};
> +
>  static int omap3_sbc_t3730_twl_callback(struct device *dev,
>  					   unsigned gpio,
>  					   unsigned ngpio)
> @@ -185,6 +193,12 @@ static void __init omap4_panda_legacy_init(void)
>  	legacy_init_ehci_clk("auxclk3_ck");
>  	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
>  }
> +
> +static struct iommu_platform_data omap4_iommu_pdata = {
> +	.reset_name = "mmu_cache",
> +	.assert_reset = omap_device_assert_hardreset,
> +	.deassert_reset = omap_device_deassert_hardreset,
> +};
>  #endif
>  
>  #ifdef CONFIG_SOC_OMAP5
> @@ -240,6 +254,8 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
>  #ifdef CONFIG_ARCH_OMAP3
>  	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
>  	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
> +	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
> +		       &omap3_iommu_pdata),
>  	/* Only on am3517 */
>  	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
>  	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
> @@ -248,6 +264,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
>  #ifdef CONFIG_ARCH_OMAP4
>  	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
>  	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
> +	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
> +		       &omap4_iommu_pdata),
> +	OF_DEV_AUXDATA("ti,omap4-iommu", 0x55082000, "55082000.mmu",
> +		       &omap4_iommu_pdata),
>  #endif
>  	{ /* sentinel */ },
>  };
> -- 
> 1.8.5.3
> 
