From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/3] omap-serial: Add minimal device tree support
Date: Thu, 17 Nov 2011 14:09:36 +0530
Message-ID: <4EC4C848.4080800@ti.com>
References: <1321441346-19591-1-git-send-email-rnayak@ti.com> <1321441346-19591-3-git-send-email-rnayak@ti.com> <4EC3CFDA.1070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <4EC3CFDA.1070804@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, linaro-dev@lists.linaro.org, tony@atomide.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 16 November 2011 08:29 PM, Rob Herring wrote:
> On 11/16/2011 05:02 AM, Rajendra Nayak wrote:
>> Adapt the driver to device tree and pass minimal platform
>> data from device tree needed for console boot.
>> No power management features will be suppported for now
>> since it requires more tweaks around OCP settings
>> to toggle forceidle/noidle/smaridle bits and handling
>> remote wakeup and dynamic muxing.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   .../devicetree/bindings/serial/omap_serial.txt     |    9 +++++
>>   drivers/tty/serial/omap-serial.c                   |   37 +++++++++++++++++++-
>>   2 files changed, 45 insertions(+), 1 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> new file mode 100644
>> index 0000000..bf6d631
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> @@ -0,0 +1,9 @@
>> +OMAP UART controller
>> +
>> +Required properties:
>> +- compatible : should be "ti,omap-uart"
>
> This seems too generic. There are no h/w differences in the uart since
> the 1st OMAP1 device?

This driver supports only OMAP2+ devices, and there doesn't seem to be
really much difference. But I might have to re-look, in case I need to
handle some silicon errata.

>
>> +- ti,hwmods : Must be "uart<n>", n being the instance number (1-based)
>> +
>> +Optional properties:
>> +- clock-frequency : frequency of the clock input to the UART
>> +- ti,console_hwmod : boolean, UART used as debug console
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index e1c8527..e3419c6 100644
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
>> @@ -1322,6 +1323,22 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
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
>> +					&(*omap_up_info).uartclk);
>
> &omap_up_info->uartclk
>
> You want 0 to be the default freq?

good point, I need to handle this better.

>
>> +
>> +	return omap_up_info;
>> +}
>> +
>> +static atomic_t omap_uart_next_id = ATOMIC_INIT(0);
>> +
>>   static int serial_omap_probe(struct platform_device *pdev)
>>   {
>>   	struct uart_omap_port	*up;
>> @@ -1329,6 +1346,11 @@ static int serial_omap_probe(struct platform_device *pdev)
>>   	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
>>   	int ret = -ENOSPC;
>>
>> +	if (pdev->dev.of_node) {
>> +		omap_up_info = of_get_uart_port_info(&pdev->dev);
>> +		pdev->id = atomic_inc_return(&omap_uart_next_id) - 1;
>
> I don't think a driver changing this value is a good idea. Look at other
> serial drivers like iMX for how they use aliases.

Well, I did lookup, but maybe the wrong one. I looked up the msm serial
which added DT support not too long ago and does the exact same thing.

>
>> +	}
>> +
>>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	if (!mem) {
>>   		dev_err(&pdev->dev, "no mem resource?\n");
>> @@ -1523,7 +1545,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
>>   	if (!up)
>>   		return -EINVAL;
>>
>> -	if (!pdata->enable_wakeup)
>> +	if (!pdata || !pdata->enable_wakeup)
>>   		return 0;
>>
>>   	if (pdata->get_context_loss_count)
>> @@ -1582,12 +1604,25 @@ static const struct dev_pm_ops serial_omap_dev_pm_ops = {
>>   				serial_omap_runtime_resume, NULL)
>>   };
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id omap_serial_of_match[] = {
>> +	{
>> +		.compatible = "ti,omap-uart",
>> +	},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, omap_serial_of_match);
>> +#else
>> +#define omap_serial_of_match NULL
>> +#endif
>> +
>>   static struct platform_driver serial_omap_driver = {
>>   	.probe          = serial_omap_probe,
>>   	.remove         = serial_omap_remove,
>>   	.driver		= {
>>   		.name	= DRIVER_NAME,
>>   		.pm	=&serial_omap_dev_pm_ops,
>> +		.of_match_table = omap_serial_of_match,
>
> Use of_match_ptr and get rid of the #else

Ok, thanks.
Rajendra
>
> Rob

