From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH] drivers: mtd: devices: make m25p80 dt adapted.
Date: Fri, 2 Aug 2013 20:41:12 +0530
Message-ID: <51FBCC10.2050206@ti.com>
References: <1375426170-31609-1-git-send-email-sourav.poddar@ti.com> <20130803022215.GA7627@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32854 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab3HBPLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 11:11:46 -0400
In-Reply-To: <20130803022215.GA7627@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: dwmw2@infradead.org, artem.bityutskiy@linux.intel.com, linux-mtd@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, pekon@ti.com, balbi@ti.com

Hi Huang,
On Saturday 03 August 2013 07:52 AM, Huang Shijie wrote:
> On Fri, Aug 02, 2013 at 12:19:30PM +0530, Sourav Poddar wrote:
>> This patch helps gettimg m25p80 probed through dt.
> without this patch, we also can get the right SPI NOR type from the
> dt entry.
>
> Could you explain why we should get the m25p80 probed though the DT?
> or give an example.
>
Actually Yes, I misunderstood the dt bindings to be used for this driver
completely. With the following, I was able to work properly without this
patch.
+        m25p80@0 {
+                compatible = "s25fl256s1";
                  spi-max-frequency = <48000000>;
                  s25fl,three-byte;
                  reg = <0x00>;

Sorry for the noise. Patch can be discarded.

> thanks
> Huang Shijie
>> To get the id of the exact flash type supported for dt case,
>> data->type is getting parsed from dt entry.
>>
>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>> ---
>>   drivers/mtd/devices/m25p80.c |   22 +++++++++++++++++++++-
>>   1 files changed, 21 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index 33098bf..cbfb9b3 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -855,6 +855,13 @@ static const struct spi_device_id m25p_ids[] = {
>>   };
>>   MODULE_DEVICE_TABLE(spi, m25p_ids);
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id m25p_dt_ids[] = {
>> +	{ .compatible = "m25p80", },
>> +	{ /* sentinel */ }
>> +};
>> +#endif
>> +
>>   static const struct spi_device_id *jedec_probe(struct spi_device *spi)
>>   {
>>   	int			tmp;
>> @@ -909,6 +916,7 @@ static int m25p_probe(struct spi_device *spi)
>>   	unsigned			i;
>>   	struct mtd_part_parser_data	ppdata;
>>   	struct device_node __maybe_unused *np = spi->dev.of_node;
>> +	int len;
>>
>>   #ifdef CONFIG_MTD_OF_PARTS
>>   	if (!of_device_is_available(np))
>> @@ -920,7 +928,18 @@ static int m25p_probe(struct spi_device *spi)
>>   	 * a chip ID, try the JEDEC id commands; they'll work for most
>>   	 * newer chips, even if we don't recognize the particular chip.
>>   	 */
>> -	data = spi->dev.platform_data;
>> +	if (!np) {
>> +		data = spi->dev.platform_data;
>> +	} else {
>> +		data = devm_kzalloc(&spi->dev, sizeof(*data), GFP_KERNEL);
>> +		if (!data)
>> +			return -ENOMEM;
>> +
>> +		data->type = (char *) of_get_property(np, "type",&len);
>> +		if (!data->type || strlen(data->type)>  len)
>> +			return -ENODEV;
>> +	}
>> +
>>   	if (data&&  data->type) {
>>   		const struct spi_device_id *plat_id;
>>
>> @@ -1098,6 +1117,7 @@ static struct spi_driver m25p80_driver = {
>>   	.driver = {
>>   		.name	= "m25p80",
>>   		.owner	= THIS_MODULE,
>> +		.of_match_table = of_match_ptr(m25p_dt_ids),
>>   	},
>>   	.id_table	= m25p_ids,
>>   	.probe	= m25p_probe,
>> -- 
>> 1.7.1
>>
>>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/

