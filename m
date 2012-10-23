From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Mon, 22 Oct 2012 19:48:23 -0500
Message-ID: <5085E957.6060003@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43454 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848Ab2JWAud (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 20:50:33 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9N0oXZX023193
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 19:50:33 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9N0oXBG029071
	for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 19:50:33 -0500
In-Reply-To: <5084F85C.9050508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

Hi Tomi,

Thanks for reviewing!

On 10/22/2012 02:40 AM, Tomi Valkeinen wrote:
> On 2012-10-16 04:27, Ricardo Neri wrote:
>> Creating the accessory devices, such as audio, from the HDMI driver
>> allows to regard HDMI as a single entity with audio an display
>> functionality. This intends to follow the design of drivers such
>> as MFD, in which a single entity handles the creation of the accesory
>> devices. Such devices are then used by domain-specific drivers; audio in
>> this case.
>>
>> Also, this is in line with the DT implementation of HDMI, in which we will
>> have a single node to describe this feature of the OMAP SoC.
>>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>>   drivers/video/omap2/dss/hdmi.c |   68 ++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 68 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
>> index e5be0a5..c62c5ab 100644
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
>> @@ -73,6 +76,13 @@ static struct {
>>   	struct omap_dss_output output;
>>   } hdmi;
>>
>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>> +#define HDMI_AUDIO_MEM_RESOURCE 0
>> +#define HDMI_AUDIO_DMA_RESOURCE 1
>
> I don't see much point with these definitions. They are hdmi.c internal,
> so the audio driver can't use them, and so they aren't really fixed.

I just thought it could make the code more readable; but if the 
resources array is going to be local, then they are not helpful.
>
>> +static struct resource hdmi_aud_res[2];
>
> Did you check if the platform_device_register does a copy of these? If
> it does, this can be local to the probe function.

Thanks! I checked, platform_device_register does the copy. I will put it 
as a local variable.
>
>> +#endif
>> +
>> +
>>   /*
>>    * Logic for the below structure :
>>    * user enters the CEA or VESA timings by specifying the HDMI/DVI code.
>> @@ -765,6 +775,50 @@ static void hdmi_put_clocks(void)
>>   }
>>
>>   #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>> +static int hdmi_probe_audio(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +
>> +	hdmi.audio_pdev = ERR_PTR(-EINVAL);
>> +
>> +	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		DSSERR("can't get IORESOURCE_MEM HDMI\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Pass this resource to audio_pdev.
>> +	 * Audio drivers should not remap it
>> +	 */
>> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].start = res->start;
>> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].end = res->end;
>> +	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].flags = IORESOURCE_MEM;
>> +
>> +	res = platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
>> +	if (!res) {
>> +		DSSERR("can't get IORESOURCE_DMA HDMI\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Pass this resource to audio_pdev */
>> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].start = res->start;
>> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].end = res->end;
>> +	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].flags = IORESOURCE_DMA;
>> +
>> +	/* create platform device for HDMI audio driver */
>> +	hdmi.audio_pdev = platform_device_register_simple(
>> +							  "omap_hdmi_audio",
>> +							  -1, hdmi_aud_res,
>> +							   ARRAY_SIZE(hdmi_aud_res));
>> +	if (IS_ERR(hdmi.audio_pdev)) {
>> +		DSSERR("Can't instantiate hdmi-audio\n");
>> +		return PTR_ERR(hdmi.audio_pdev);
>> +	}
>> +
>> +	return 0;
>> +}
>
> So, how will this work? All the audio related functions will be removed
> from the (video) hdmi driver, and the audio driver will access the
> registers independently? The audio driver will still need to access the
> video parts, right?
That could be a new approach, but the idea here is to continue having an 
omapdss audio interface for audio drivers to use.

The root problem that I am trying to address is that the omapdss audio 
interface does not have functionality for DMA transfer of audio samples 
to the HDMI IP. Also, I am not sure how that could be done without 
duplicating the functionality that ASoC already provides.
>
> I feel a bit uneasy about giving the same ioremapped register space to
> two independent drivers... If we could split the registers to video and
> audio parts, each driver only ioremapping their respective registers,
> it'd be much better.

Fwiw, the audio drivers (at least my audio drivers) will not ioremap. 
They will just take the DMA request number and port. Maybe spliting the 
register space into audio and video is not practical as we would endup 
having many tiny address spaces.

BR,

Ricardo
>
>   Tomi
>
>
