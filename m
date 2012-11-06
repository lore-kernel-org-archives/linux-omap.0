From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 7/7] OMAPDSS: HDMI: Create platform device for audio
 support
Date: Mon, 5 Nov 2012 23:27:09 -0600
Message-ID: <50989FAD.3050601@ti.com>
References: <1351902708-866-1-git-send-email-ricardo.neri@ti.com> <1351902708-866-8-git-send-email-ricardo.neri@ti.com> <50977CD7.7070609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57975 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab2KFE3b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 23:29:31 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA64TVLX027330
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 22:29:31 -0600
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA64TVQw002847
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 22:29:31 -0600
In-Reply-To: <50977CD7.7070609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

Thanks for reviewing.

On 11/05/2012 02:46 AM, Tomi Valkeinen wrote:
> On 2012-11-03 02:31, Ricardo Neri wrote:
>> Creating the accessory devices, such as audio, from the HDMI driver
>> allows to regard HDMI as a single entity with audio an display
>> functionality. This intends to follow the design of drivers such
>> as MFD, in which a single entity handles the creation of the accessory
>> devices. Such devices are then used by domain-specific drivers; audio in
>> this case.
>>
>> Also, this is in line with the DT implementation of HDMI, in which we will
>> have a single node to describe this feature of the OMAP SoC.
>>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>>   drivers/video/omap2/dss/hdmi.c |   62 ++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 62 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
>> index 4adf830..d6ce4c6 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -60,6 +60,9 @@
>>   static struct {
>>   	struct mutex lock;
>>   	struct platform_device *pdev;
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>> +	struct platform_device *audio_pdev;
>> +#endif
>>
>>   	struct hdmi_ip_data ip_data;
>>
>> @@ -766,6 +769,54 @@ static void hdmi_put_clocks(void)
>>   }
>>
>>   #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>> +static int hdmi_probe_audio(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	u32 port_offset, port_size;
>> +	struct resource aud_res[2] = {
>> +		DEFINE_RES_MEM(-1, -1),
>> +		DEFINE_RES_DMA(-1),
>> +	};
>> +
>> +	hdmi.audio_pdev = ERR_PTR(-EINVAL);
>
> I don't like this. I think ERR_PTR stuff should be used only for return
> values, not when storing pointers. I think it's much more natural and
> less error prone to do if (hdmi.audio_pdev == NULL) than if
> (IS_ERR(hdmi.audio_pdev)).
>
> So store the return value from platform_dev_register first to a local
> variable, check IS_ERR for that, and only then store it to hdmi.audio_pdev.

OK. I'll implement the change.
>
>> +	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		DSSERR("can't get IORESOURCE_MEM HDMI\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Pass DMA audio port to audio drivers.
>> +	 * Audio drivers should not ioremap it.
>> +	 */
>> +	hdmi.ip_data.ops->audio_get_dma_port(&port_offset, &port_size);
>> +
>> +	aud_res[0].start = res->start + port_offset;
>> +	aud_res[0].end = aud_res[0].start + port_size - 1;
>> +
>> +	res = platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
>> +	if (!res) {
>> +		DSSERR("can't get IORESOURCE_DMA HDMI\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Pass the audio DMA request resource to audio drivers. */
>> +	aud_res[1].start = res->start;
>> +
>> +	/* create platform device for HDMI audio driver */
>> +	hdmi.audio_pdev = platform_device_register_simple(
>> +							  "omap_hdmi_audio",
>> +							  -1, aud_res,
>> +							   ARRAY_SIZE(aud_res));
>
> Not a problem for the time being, but the above prevents us from having
> two HDMI outputs. Perhaps you could use hdmi pdev's ID instead of -1 above?

I guess it is fine as you suggest. I will have to work on the ASoC side 
to support more than one HDMI outputs as well.

BR,

Ricardo
>
> Otherwise I think the series is ok.
>
>   Tomi
>
>
