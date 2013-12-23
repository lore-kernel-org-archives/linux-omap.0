From: "Anna, Suman" <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/7] iommu/omap: Convert to devicetree
Date: Mon, 23 Dec 2013 13:48:36 -0600
Message-ID: <52B89394.5060902@ti.com>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
	<1387284818-28739-4-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1387284818-28739-4-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Florian,

On 12/17/2013 06:53 AM, Florian Vaussard wrote:
> As OMAP2+ is moving to a full DT boot for 3.14, commit 7ce93f3
> "ARM: OMAP2+: Fix more missing data for omap3.dtsi file" adds
> basic DT bits. But the driver is not yet converted, so this will
> not work and driver will not be probed. Convert it!
>
> Apart from standard bindings, this patch uses 'dma-window' (already
> used by Tegra SMMU) and adds a custom 'ti,#tlb-entries' binding.
>
> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> ---
>   .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 19 ++++++++++++
>   arch/arm/mach-omap2/omap-iommu.c                   |  5 +++
>   drivers/iommu/omap-iommu.c                         | 36 +++++++++++++++++++---
>   3 files changed, 55 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
>
> diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> new file mode 100644
> index 0000000..4e5027c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> @@ -0,0 +1,19 @@
> +OMAP3 IOMMU used by camera subsystem

As I mentioned in comments on your cover-letter, the current binding is 
only limited to OMAP3 ISP, but the driver is common for all OMAP2+ SoCs. 
This binding an update to handle all SoCs.

To summarize the differences, OMAP2/3 has the same MMU register set for 
all remote processor MMUs (IVA/DSP/ISP) with the only difference being 
the number of TLBs supported (8 for ISP on OMAP2/3 and 32 for all other 
instances on all OMAP2+ SoCs). Depending on whether the compatibility 
property is defined for an SoC or for the processor, "ti,#tlb-entries" 
can be retrieved directly from the match data or made as an optional 
property, with the default value being 32.

OMAP4 and OMAP5 have some additional registers (MMU_FAULT_PC, 
MMU_FAULT_STATUS, MMU_GP_REG/DSPSS_MMU_GPR) on top of the OMAP2/OMAP3 
ones, and DRA7 a further superset of OMAP4/OMAP5. The only difference is 
the definition of the MMU_GPR register, which is different between the 
IPU and DSP processors, but present at the same offset, and dictates the 
validity of the MMU_FAULT_PC and MMU_FAULT_STATUS registers. The MMU_GPR 
register is also not defined on OMAP4430 ES1.0, but is present on all 
other newer SoCs.

> +
> +Required properties:
> +- compatible : "ti,omap3-mmu-isp"
My suggestion would be to use
	"ti,omap2-iommu" for OMAP2/OMAP3 MMUs with the optional 
"ti,#tlb-entries" to distinguish ISP MMU.
	"ti,omap4-iommu" for OMAP4/OMAP5 MMUs with an additional boolean 
property to distinguish the presence/functionality of the MMU_GPR register
	"ti,dra7-iommu" for DRA7 MMUs

Mark, Tony,
Do you have any other recommendations given the above summary?

> +- ti,hwmods : "mmu_isp"
Replace with general description

> +- reg : address space for the configuration registers
> +- interrupts : interrupt line
> +- dma-window : IOVA start address and length.
> +- ti,#tlb-entries : number of entries in the translation look-aside buffer
> +
> +Example:
> +	mmu_isp: mmu_isp@480bd400 {
> +		compatible = "ti,omap3-mmu-isp";
> +		ti,hwmods = "mmu_isp";
> +		reg = <0x480bd400 0x80>;
> +		interrupts = <8>;
> +		dma-window = <0 0xfffff000>;
> +		ti,#tlb-entries = <8>;
> +	};
> diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
> index f6daae8..f1fab56 100644
> --- a/arch/arm/mach-omap2/omap-iommu.c
> +++ b/arch/arm/mach-omap2/omap-iommu.c
> @@ -10,6 +10,7 @@
>    * published by the Free Software Foundation.
>    */
>
> +#include <linux/of.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/err.h>
> @@ -58,6 +59,10 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
>
>   static int __init omap_iommu_init(void)
>   {
> +	/* If dtb is there, the devices will be created dynamically */
> +	if (of_have_populated_dt())
> +		return -ENODEV;
> +
>   	return omap_hwmod_for_each_by_class("mmu", omap_iommu_dev_init, NULL);
>   }
>   /* must be ready before omap3isp is probed */
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 385bf5e..51efcc4 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -23,6 +23,9 @@
>   #include <linux/spinlock.h>
>   #include <linux/io.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_irq.h>
>
>   #include <asm/cacheflush.h>
>
> @@ -1171,20 +1174,30 @@ static int omap_iommu_probe(struct platform_device *pdev)
>   {
>   	int err = -ENODEV;
>   	int irq;
> +	size_t len;
>   	struct omap_iommu *obj;
>   	struct resource *res;
>   	struct iommu_platform_data *pdata = pdev->dev.platform_data;
> +	struct device_node *of = pdev->dev.of_node;
>
>   	obj = kzalloc(sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
>   	if (!obj)
>   		return -ENOMEM;
>
> -	obj->nr_tlb_entries = pdata->nr_tlb_entries;
> -	obj->name = pdata->name;
> +	if (of) {
> +		obj->name = of->name;
> +		of_property_read_u32(of, "ti,#tlb-entries",
> +				     &obj->nr_tlb_entries);
> +		of_get_dma_window(of, NULL, 0, NULL, &obj->da_start, &len);

There is no error checking performed on both the of functions.

> +		obj->da_end = obj->da_start + len;
> +	} else {
> +		obj->nr_tlb_entries = pdata->nr_tlb_entries;
> +		obj->name = pdata->name;
> +		obj->da_start = pdata->da_start;
> +		obj->da_end = pdata->da_end;
> +	}
>   	obj->dev = &pdev->dev;
>   	obj->ctx = (void *)obj + sizeof(*obj);
> -	obj->da_start = pdata->da_start;
> -	obj->da_end = pdata->da_end;
>
>   	spin_lock_init(&obj->iommu_lock);
>   	mutex_init(&obj->mmap_lock);
> @@ -1210,7 +1223,11 @@ static int omap_iommu_probe(struct platform_device *pdev)
>   		goto err_ioremap;
>   	}
>
> -	irq = platform_get_irq(pdev, 0);
> +	if (of)
> +		irq = irq_of_parse_and_map(of, 0);
> +	else
> +		irq = platform_get_irq(pdev, 0);

The platform_get_irq should still work just fine, so this change can 
probably be left out. We can switch once the driver supports DT-only 
devices completely.

regards
Suman


> +
>   	if (irq < 0) {
>   		err = -ENODEV;
>   		goto err_irq;
> @@ -1260,11 +1277,20 @@ static int omap_iommu_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#if defined(CONFIG_OF)
> +static struct of_device_id omap_iommu_of_match[] = {
> +	{ .compatible = "ti,omap3-mmu-isp" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap_iommu_of_match);
> +#endif
> +
>   static struct platform_driver omap_iommu_driver = {
>   	.probe	= omap_iommu_probe,
>   	.remove	= omap_iommu_remove,
>   	.driver	= {
>   		.name	= "omap-iommu",
> +		.of_match_table = omap_iommu_of_match,
>   	},
>   };
>
>
