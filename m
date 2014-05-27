From: Archit Taneja <archit@ti.com>
Subject: Re: [RFC v2 3/5] OMAPDSS: DPI: support multiple DPI instances
Date: Tue, 27 May 2014 14:57:58 +0530
Message-ID: <53845A9E.8020603@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com> <1401096492-1405-1-git-send-email-archit@ti.com> <1401096492-1405-3-git-send-email-archit@ti.com> <53845515.6030305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52568 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbaE0J3O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 05:29:14 -0400
Received: from dbdlxv05.itg.ti.com ([172.24.171.60])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4R9TDQr004228
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 04:29:13 -0500
Received: from DBDE72.ent.ti.com (dbdmailx.itg.ti.com [172.24.171.97])
	by dbdlxv05.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4R9TAdR022604
	for <linux-omap@vger.kernel.org>; Tue, 27 May 2014 14:59:11 +0530
In-Reply-To: <53845515.6030305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 27 May 2014 02:34 PM, Tomi Valkeinen wrote:
> On 26/05/14 12:28, Archit Taneja wrote:
>> SoCs containing DSS until now had only one DPI instance. DRA7x has 3 DPI
>> instances.
>>
>> In order to support multiple instances, we allocate a driver data
>> struct(dpi_data) for each instance. This is somewhat similar to how DSI driver
>> was changed to support multiple instances.
>>
>> One difference is that there aren't platform devices for each DPI instance
>> when DT is used. In the DT case, we store the dpi_data pointer in the DPI port's
>> (of the type struct device_node) data pointer. In the non DT case, we still
>> have dummy platform devices, and the device's private data pointer is used to
>> store the DPI instance's dpi_data.
>>
>> dpi_init_output/dpi_uninit_output are untouched and only used for non DT case,
>> dpi_init_output_port/dpi_uninit_output_port are used in the DT case, where DSS
>> configures the ports using dpi_init_port/dpi_uninit_port.
>
> This is a bit too big patch, I think it should be split.
>
> The first patch could add the name to the struct dpi_data, but still
> keep it static, and also change the functions to pass the dpi_data
> pointer around, as you do in this patch.
>
> The functions where you do
>
> struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
>
> could just do
>
> struct dpi_data *dpi = &dpi;
>
> This way the in the first patch you can do most of the bulk changes,
> without actually changing the behavior in any way.
>
> In the next patch, you could then add the actual support for allocating
> the dpi_data instances.
>
> Those two patches should be moved to the beginning of the series, as
> they are just preparatory patches, and they don't actually change
> anything with DPI.
>
> Third DPI patch would then add support for the actual multiple DPI
> instances.

Okay, that sounds like a good way to split it.

>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/fbdev/omap2/dss/dpi.c | 263 +++++++++++++++++++++++++-----------
>>   1 file changed, 181 insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
>> index 8593567..43966a7 100644
>> --- a/drivers/video/fbdev/omap2/dss/dpi.c
>> +++ b/drivers/video/fbdev/omap2/dss/dpi.c
>> @@ -37,7 +37,7 @@
>>   #include "dss.h"
>>   #include "dss_features.h"
>>
>> -static struct {
>> +struct dpi_data {
>>   	struct platform_device *pdev;
>>
>>   	struct regulator *vdds_dsi_reg;
>> @@ -52,7 +52,27 @@ static struct {
>>   	struct omap_dss_device output;
>>
>>   	bool port_initialized;
>> -} dpi;
>> +};
>> +
>> +static struct dpi_data *dpi_get_data_from_dssdev(struct omap_dss_device *dssdev)
>> +{
>> +	struct device_node *parent = dssdev->dev->of_node;
>> +
>> +	/* non DT */
>> +	if (!parent) {
>> +		struct omap_dss_device *out = dssdev->src;
>> +
>> +		return dev_get_drvdata(out->dev);
>> +	}
>
> Why do you need the above? Just plain container_of() below should work
> for both DT and non-DT.

Yeah, that's right. For some reason I thought that dssdev in the non-DT 
case is the pointer for the next device in the chain, and not the output 
itself. I'll remove this piece.

Thanks,
Archit

