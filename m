From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 3/4] omap-serial: Add minimal device tree support
Date: Tue, 29 Nov 2011 12:34:25 +0530
Message-ID: <4ED483F9.4020107@ti.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com> <1321969456-24266-4-git-send-email-rnayak@ti.com> <4ED38F1C.5080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:52028 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab1K2HEf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 02:04:35 -0500
In-Reply-To: <4ED38F1C.5080604@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Monday 28 November 2011 07:09 PM, Rob Herring wrote:
> On 11/22/2011 07:44 AM, Rajendra Nayak wrote:
>> Adapt the driver to device tree and pass minimal platform
>> data from device tree needed for console boot.
>> No power management features will be suppported for now
>> since it requires more tweaks around OCP settings
>> to toggle forceidle/noidle/smaridle bits and handling
>
> typo: smartidle
>
>> remote wakeup and dynamic muxing.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> Acked-by: Rob Herring<rob.herring@calxeda.com>

Thanks Rob, will fix the above typo.

>
> Rob
>
>> ---
>>   .../devicetree/bindings/serial/omap_serial.txt     |   10 ++++
>>   drivers/tty/serial/omap-serial.c                   |   45 ++++++++++++++++++-
>>   2 files changed, 52 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> new file mode 100644
>> index 0000000..342eedd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> @@ -0,0 +1,10 @@
>> +OMAP UART controller
>> +
>> +Required properties:
>> +- compatible : should be "ti,omap2-uart" for OMAP2 controllers
>> +- compatible : should be "ti,omap3-uart" for OMAP3 controllers
>> +- compatible : should be "ti,omap4-uart" for OMAP4 controllers
>> +- ti,hwmods : Must be "uart<n>", n being the instance number (1-based)
>> +
>> +Optional properties:
>> +- clock-frequency : frequency of the clock input to the UART
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index f14b9c5..5aa524e 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -38,6 +38,7 @@
>>   #include<linux/serial_core.h>
>>   #include<linux/irq.h>
>>   #include<linux/pm_runtime.h>
>> +#include<linux/of.h>
>>
>>   #include<plat/dma.h>
>>   #include<plat/dmtimer.h>
>> @@ -1324,6 +1325,19 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
>>   	return;
>>   }
>>
>> +static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
>> +{
>> +	struct omap_uart_port_info *omap_up_info;
>> +
>> +	omap_up_info = devm_kzalloc(dev, sizeof(*omap_up_info), GFP_KERNEL);
>> +	if (!omap_up_info)
>> +		return NULL; /* out of memory */
>> +
>> +	of_property_read_u32(dev->of_node, "clock-frequency",
>> +					&omap_up_info->uartclk);
>> +	return omap_up_info;
>> +}
>> +
>>   static int serial_omap_probe(struct platform_device *pdev)
>>   {
>>   	struct uart_omap_port	*up;
>> @@ -1331,6 +1345,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>>   	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
>>   	int ret = -ENOSPC;
>>
>> +	if (pdev->dev.of_node)
>> +		omap_up_info = of_get_uart_port_info(&pdev->dev);
>> +
>>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	if (!mem) {
>>   		dev_err(&pdev->dev, "no mem resource?\n");
>> @@ -1375,9 +1392,20 @@ static int serial_omap_probe(struct platform_device *pdev)
>>   	up->port.regshift = 2;
>>   	up->port.fifosize = 64;
>>   	up->port.ops =&serial_omap_pops;
>> -	up->port.line = pdev->id;
>> -	sprintf(up->name, "OMAP UART%d", up->port.line);
>>
>> +	if (pdev->dev.of_node)
>> +		up->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
>> +	else
>> +		up->port.line = pdev->id;
>> +
>> +	if (up->port.line<  0) {
>> +		dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
>> +								up->port.line);
>> +		ret = -ENODEV;
>> +		goto err;
>> +	}
>> +
>> +	sprintf(up->name, "OMAP UART%d", up->port.line);
>>   	up->port.mapbase = mem->start;
>>   	up->port.membase = ioremap(mem->start, resource_size(mem));
>>   	if (!up->port.membase) {
>> @@ -1530,7 +1558,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
>>   	if (!up)
>>   		return -EINVAL;
>>
>> -	if (!pdata->enable_wakeup)
>> +	if (!pdata || !pdata->enable_wakeup)
>>   		return 0;
>>
>>   	if (pdata->get_context_loss_count)
>> @@ -1591,12 +1619,23 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
>>   				serial_omap_runtime_resume, NULL)
>>   };
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id omap_serial_of_match[] = {
>> +	{ .compatible = "ti,omap2-uart" },
>> +	{ .compatible = "ti,omap3-uart" },
>> +	{ .compatible = "ti,omap4-uart" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, omap_serial_of_match);
>> +#endif
>> +
>>   static struct platform_driver serial_omap_driver = {
>>   	.probe          = serial_omap_probe,
>>   	.remove         = serial_omap_remove,
>>   	.driver		= {
>>   		.name	= DRIVER_NAME,
>>   		.pm	=&serial_omap_dev_pm_ops,
>> +		.of_match_table = of_match_ptr(omap_serial_of_match),
>>   	},
>>   };
>>
>

