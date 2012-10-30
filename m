From: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: pinctrl-ify i2c-omap.c
Date: Tue, 30 Oct 2012 19:13:09 +0000
Message-ID: <AA125593-C53C-426E-9DCA-27318D5AB941@ti.com>
References: <1351698930-3797-1-git-send-email-panto@antoniou-consulting.com>
 <20121030185303.GD4804@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121030185303.GD4804-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Content-ID: <ACC15AC987BB4C44A3BEB568EF7D91C1-q8tqbTl1AnqmHdYHvhjUOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "<linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, "Dill, Russ" <russ.dill-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On Oct 30, 2012, at 2:53 PM, Felipe Balbi wrote:

> Hi,
> 
> On Wed, Oct 31, 2012 at 05:55:30PM +0200, Pantelis Antoniou wrote:
>> Enable pinctrl for i2c-omap.
>> 
>> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
>> ---
>> drivers/i2c/busses/i2c-omap.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>> 
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index db31eae..4c38aa0 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -44,6 +44,8 @@
>> #include <linux/i2c-omap.h>
>> #include <linux/pm_runtime.h>
>> #include <linux/pm_qos.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/err.h>
>> 
>> /* I2C controller revisions */
>> #define OMAP_I2C_OMAP1_REV_2		0x20
>> @@ -1064,6 +1066,7 @@ omap_i2c_probe(struct platform_device *pdev)
>> 	const struct of_device_id *match;
>> 	int irq;
>> 	int r;
>> +	struct pinctrl *pinctrl;
>> 
>> 	/* NOTE: driver uses the static register mapping */
>> 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -1202,6 +1205,13 @@ omap_i2c_probe(struct platform_device *pdev)
>> 
>> 	of_i2c_register_devices(adap);
>> 
>> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>> +	if (IS_ERR(pinctrl))
>> +		dev_warn(dev->dev, "unable to select pin group\n");
> 
> if we continue anyway, should this be dev_warn() ? Would you consider
> dev_dbg() instead ?

This has been the convention already in other drivers upstream. Discussed
previously in http://www.spinics.net/lists/arm-kernel/msg192856.html and
http://lkml.org/lkml/2012/9/11/369

That resulted in having dev_warn with a message of "pins are not configured
from the driver" in both leds-gpio and spi-omap2-mcspi. It seems there should
be a good reason to change reporting for the same case here.

-Matt
