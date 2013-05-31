From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Date: Fri, 31 May 2013 18:17:43 +0300
Message-ID: <51A8BF17.4050209@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com> <874ndk5sse.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45821 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756457Ab3EaPUy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 11:20:54 -0400
In-Reply-To: <874ndk5sse.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 05/30/2013 07:36 PM, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>
>> When using DT, dss device does not have platform data. However,
>> dss_get_ctx_loss_count() uses dss device's platform data to find the
>> get_ctx_loss_count function pointer.
>>
>> To fix this, dss_get_ctx_loss_count() needs to be changed to get the
>> platform data from the omapdss device, which is a "virtual" device and
>> always has platform data.
> Dumb question (since the DSS device model has always been beyond my
> grasp): how/why does the virtual device still have platform_data on a DT
> boot?
>
> Also, this context_loss_count and DT boot is starting to get cumbersome,
> and there's currently no (good) way of handling the context loss in a
> generic way without pdata function pointers.
>
> I'm starting to think we should move towards dropping this OMAP-specific
> context loss counting, and just assume context is always lost.  If there
> are performance problems, runtime PM autosuspend timeouts can be used to
> avoid the transitions.
>
> Or, on some devices, I suspect comparing a few registers against their
> power-on reset values might be a quicker way of detecting lost context
> and would avoid having to call into platform code all together.
Hi Kevin,
I've a question:
Why don't add API in "Kernel/Base PM" framework for context lost detection?
Like pm_was_ctx_lost().

If this topic has been discussed already (many times)) - sorry for the 
noise.
And I'll be very appreciate if you can point me on corresponding 
discussions.
>
> Kevin
>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
>> index 94f66f9..bd01608 100644
>> --- a/drivers/video/omap2/dss/dss.c
>> +++ b/drivers/video/omap2/dss/dss.c
>> @@ -157,7 +157,8 @@ static void dss_restore_context(void)
>>   
>>   int dss_get_ctx_loss_count(void)
>>   {
>> -	struct omap_dss_board_info *board_data = dss.pdev->dev.platform_data;
>> +	struct platform_device *core_pdev = dss_get_core_pdev();
>> +	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;
>>   	int cnt;
>>   
>>   	if (!board_data->get_context_loss_count)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

