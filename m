From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] rtc: omap: Support regulator supply for RTC
Date: Fri, 19 Sep 2014 15:18:44 +0530
Message-ID: <541BFBFC.5070505@ti.com>
References: <1411119994-8234-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50672 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbaISJuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2014 05:50:25 -0400
In-Reply-To: <1411119994-8234-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: a.zummo@towertech.it, rtc-linux@googlegroups.com
Cc: nsekhar@ti.com, t-kristo@ti.com, nm@ti.com, j-keerthy@ti.com, balbi@ti.com, tony@atomide.com, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

+linux-omap, linux-arm-kernel, devicetree
On Friday 19 September 2014 03:16 PM, Lokesh Vutla wrote:
> On some Soc's RTC is powered by an external power regulator.
> e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
> power regulator.
> And also making the driver as module_platform_driver to
> support probe deferal.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Tested on DRA7. Logs here: http://fpaste.org/134804/11200041/
> 
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  3 +++
>  drivers/rtc/rtc-omap.c                             | 28 ++++++++++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index 5a0f02d..c9f963a 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -10,6 +10,9 @@ Required properties:
>  - interrupts: rtc timer, alarm interrupts in order
>  - interrupt-parent: phandle for the interrupt controller
>  
> +Optional Properties:
> + - rtc-supply : phandle to the regulator device tree node if needed.
> +
>  Example:
>  
>  rtc@1c23000 {
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 21142e6..4473d1d 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/io.h>
> +#include <linux/regulator/consumer.h>
>  
>  /* The OMAP1 RTC is a year/month/day/hours/minutes/seconds BCD clock
>   * with century-range alarm matching, driven by the 32kHz clock.
> @@ -121,6 +122,7 @@
>  #define OMAP_RTC_HAS_32KCLK_EN		BIT(2)
>  
>  static void __iomem	*rtc_base;
> +static struct regulator	*rtc_reg;
>  
>  #define rtc_read(addr)		readb(rtc_base + (addr))
>  #define rtc_write(val, addr)	writeb(val, rtc_base + (addr))
> @@ -372,11 +374,12 @@ static const struct of_device_id omap_rtc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
>  
> -static int __init omap_rtc_probe(struct platform_device *pdev)
> +static int omap_rtc_probe(struct platform_device *pdev)
>  {
>  	struct resource		*res;
>  	struct rtc_device	*rtc;
>  	u8			reg, new_ctrl;
> +	int			ret;
>  	const struct platform_device_id *id_entry;
>  	const struct of_device_id *of_id;
>  
> @@ -402,6 +405,23 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> +	rtc_reg =  devm_regulator_get_optional(&pdev->dev, "rtc");
> +	if (IS_ERR(rtc_reg)) {
> +		if (PTR_ERR(rtc_reg) == -EPROBE_DEFER) {
> +			dev_err(&pdev->dev, "regulator not ready, retry\n");
> +			return -EPROBE_DEFER;
> +		}
> +		rtc_reg = NULL;
> +	}
> +
> +	if (rtc_reg) {
> +		ret = regulator_enable(rtc_reg);
> +		if (ret) {
> +			dev_dbg(&pdev->dev, "regulator enable failed\n");
> +			return ret;
> +		}
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	rtc_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rtc_base))
> @@ -517,6 +537,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> +	if (rtc_reg)
> +		regulator_disable(rtc_reg);
> +
>  	return 0;
>  }
>  
> @@ -565,6 +588,7 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
>  
>  MODULE_ALIAS("platform:omap_rtc");
>  static struct platform_driver omap_rtc_driver = {
> +	.probe		= omap_rtc_probe,
>  	.remove		= __exit_p(omap_rtc_remove),
>  	.shutdown	= omap_rtc_shutdown,
>  	.driver		= {
> @@ -576,7 +600,7 @@ static struct platform_driver omap_rtc_driver = {
>  	.id_table	= omap_rtc_devtype,
>  };
>  
> -module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
> +module_platform_driver(omap_rtc_driver);
>  
>  MODULE_AUTHOR("George G. Davis (and others)");
>  MODULE_LICENSE("GPL");
> 

