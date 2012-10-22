From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 2/6] OMAPDSS: Convert to devm_ioremap
Date: Mon, 22 Oct 2012 17:59:03 -0500
Message-ID: <5085CFB7.9060907@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-3-git-send-email-ricardo.neri@ti.com> <5084F441.4060502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41260 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab2JVXBN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 19:01:13 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9MN1DnU007326
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 18:01:13 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9MN1DGx004984
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 18:01:13 -0500
In-Reply-To: <5084F441.4060502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

On 10/22/2012 02:22 AM, Tomi Valkeinen wrote:
> On 2012-10-16 04:27, Ricardo Neri wrote:
>> Using devm_ioremap provides better memory handling and improves
>> readability.
>>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>>   drivers/video/omap2/dss/hdmi.c |   11 +++++++----
>>   1 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
>> index 2cba177..6773e2c 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -1010,8 +1010,13 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>>
>> +	if (!devm_request_mem_region(&pdev->dev, res->start,
>> +				     resource_size(res), "HDMI"))
>> +		return -EBUSY;
>> +
>>   	/* Base address taken from platform */
>> -	hdmi.ip_data.base_wp = ioremap(res->start, resource_size(res));
>> +	hdmi.ip_data.base_wp = devm_ioremap(&pdev->dev, res->start,
>> +					     resource_size(res));
>
> I think you can use devm_request_and_ioremap() here to simplify it even
> more.

Thanks! I'll use it.

BR,

Ricardo
>
>   Tomi
>
>
