From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v2 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3
 HC
Date: Tue, 22 Jul 2014 10:38:15 +0100
Message-ID: <20140722093815.GA6817@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-2-git-send-email-peter.griffin@linaro.org>
 <000d01cf99e6$602096b0$2061c410$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000d01cf99e6$602096b0$2061c410$%han@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 'Maxime Coquelin' <maxime.coquelin@st.com>, 'Patrice Chotard' <patrice.chotard@st.com>, 'Srinivas Kandagatla' <srinivas.kandagatla@gmail.com>, devicetree@vger.kernel.org, 'Felipe Balbi' <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, 'Lee Jones' <lee.jones@linaro.org>, 'Giuseppe Cavallaro' <peppe.cavallaro@st.com>
List-Id: linux-omap@vger.kernel.org

Hi Jingoo,

Sorry for the delay in replying. Thanks for reviewing, 
see my comments inline below: -

<snip>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/ioport.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/delay.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> 
> Would you re-order these headers alphabetically?
> It enhances the readability.

Ok fixed in V3

> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg-glue");
> > +	if (!res)
> > +		return -ENXIO;
> > +
> > +	dwc3_data->glue_base = devm_request_and_ioremap(dev, res);
> 
> Please don't use devm_request_and_ioremap() any more. It was deprecated
> and will be removed from 3.17-rc1.
> 
> Please, use devm_ioremap_resource() instead.

Ok changed over to use devm_ioremap_resource in V3.

> 
> +	dwc3_data->glue_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(dwc3_data->glue_base))
> +		return PTR_ERR(dwc3_data->glue_base);
> 
> > +	if (!dwc3_data->glue_base)
> > +		return -EADDRNOTAVAIL;
> > +
<snip>
> > +
> > +static const struct dev_pm_ops st_dwc3_dev_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(st_dwc3_suspend, st_dwc3_resume)
> > +};
> > +
> > +static struct of_device_id st_dwc3_match[] = {
> 
> Please add 'const' as below. This is because all OF functions
> handle of_device_id as const.
> 
> static const struct of_device_id st_dwc3_match[] = {

Ok, fixed in V3

> 
> > +	{ .compatible = "st,stih407-dwc3" },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, st_dwc3_match);
> > +
> > +static struct platform_driver st_dwc3_driver = {
> > +	.probe = st_dwc3_probe,
> > +	.remove = st_dwc3_remove,
> > +	.driver = {
> > +		.name = "usb-st-dwc3",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = of_match_ptr(st_dwc3_match),
> 
> You already use OF dependency as below. So, of_match_ptr() is
> NOT necessary.
> 
> +config USB_DWC3_ST
> +	tristate "STMicroelectronics Platforms"
> +	depends on ARCH_STI && OF
> 
> Please remove of_match_ptr() as below.
> 
> +		.of_match_table = st_dwc3_match,

Ok fixed in V3

regards,

Peter.
