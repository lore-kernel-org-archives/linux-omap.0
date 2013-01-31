From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 5/8] MFD: ti_am335x_tscadc: Add DT support
Date: Thu, 31 Jan 2013 04:11:11 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E9B1EE9@DBDE01.ent.ti.com>
References: <1358999112-31192-1-git-send-email-rachna@ti.com>
 <1358999112-31192-6-git-send-email-rachna@ti.com>
 <A9839AA2-ABCD-4642-9766-D56824AC27AD@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <A9839AA2-ABCD-4642-9766-D56824AC27AD-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 30, 2013 at 16:10:09, Koen Kooi wrote:
> 
> Op 24 jan. 2013, om 04:45 heeft "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org> het volgende geschreven:
> 
> > From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
> > 
> > Make changes to add DT support in the MFD core driver.
> > 
> > Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> > ---
> > Changes in v4:
> > 	Non-standard properties prefixed with vendor name.
> > 
> > drivers/mfd/ti_am335x_tscadc.c |   28 +++++++++++++++++++++++-----
> > 1 file changed, 23 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mfd/ti_am335x_tscadc.c 
> > b/drivers/mfd/ti_am335x_tscadc.c index e9f3fb5..87b446b 100644
> > --- a/drivers/mfd/ti_am335x_tscadc.c
> > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > @@ -22,6 +22,8 @@
> > #include <linux/regmap.h>
> > #include <linux/mfd/core.h>
> > #include <linux/pm_runtime.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > 
> > #include <linux/mfd/ti_am335x_tscadc.h> #include 
> > <linux/input/ti_am335x_tsc.h>
> > @@ -64,20 +66,31 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > 	struct resource		*res;
> > 	struct clk		*clk;
> > 	struct mfd_tscadc_board	*pdata = pdev->dev.platform_data;
> > +	struct device_node	*node = pdev->dev.of_node;
> > 	struct mfd_cell		*cell;
> > 	int			err, ctrl;
> > 	int			clk_value, clock_rate;
> > -	int			tsc_wires, adc_channels = 0, total_channels;
> > +	int			tsc_wires = 0, adc_channels = 0, total_channels;
> > 
> > -	if (!pdata) {
> > +	if (!pdata && !pdev->dev.of_node) {
> > 		dev_err(&pdev->dev, "Could not find platform data\n");
> > 		return -EINVAL;
> > 	}
> > 
> > -	if (pdata->adc_init)
> > -		adc_channels = pdata->adc_init->adc_channels;
> > +	if (pdev->dev.platform_data) {
> > +		if (pdata->tsc_init)
> > +			tsc_wires = pdata->tsc_init->wires;
> > +
> > +		if (pdata->adc_init)
> > +			adc_channels = pdata->adc_init->adc_channels;
> > +	} else {
> > +		node = of_find_node_by_name(pdev->dev.of_node, "tsc");
> > +		of_property_read_u32(node, "ti,wires", &tsc_wires);
> > +
> > +		node = of_find_node_by_name(pdev->dev.of_node, "adc");
> > +		of_property_read_u32(node, "ti,adc-channels", &adc_channels);
> > +	}
> 
> Since AM335x is DT only, why is there a platform data codepath and why is it the first branch it tries? And I guess the next question is related to the first: why doesn't it work when used with DT? When I copy over the nodes from the evm.dts to my board I get "tsc tsc: Missing platform data" in dmesg.

This IP came up 1st on AM335x, but it is not platform dependent. The driver can be used on other platforms where-in DT is not supported.
According to the maintainers platform data takes precedence over DT. Hence the order.

I do not see "Missing platform data" error msg in the latest driver. I am not able to trace from where this got populated.

> 
> What are the chances this driver will work when applied on top of 3.8-rcX? Has it even been tested with that? Has it been tested at all?

This driver has been tested on top of v3.8-rc3 on a AM335x EVM.

Regards,
Rachna
