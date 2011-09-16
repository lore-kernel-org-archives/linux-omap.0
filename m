From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 5/6] OMAP: omap_device: Create a default omap_device_pm_latency
Date: Fri, 16 Sep 2011 09:41:41 -0700
Message-ID: <8762kssam2.fsf@ti.com>
References: <1314973520-3585-1-git-send-email-b-cousson@ti.com>
	<1314973520-3585-6-git-send-email-b-cousson@ti.com>
	<4E73387B.2030403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48077 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104Ab1IPQlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 12:41:47 -0400
Received: by mail-gx0-f172.google.com with SMTP id 19so5183666gxk.17
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 09:41:46 -0700 (PDT)
In-Reply-To: <4E73387B.2030403@ti.com> (Benoit Cousson's message of "Fri, 16
	Sep 2011 13:52:27 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
> On 9/2/2011 4:25 PM, Cousson, Benoit wrote:
>> Most devices are using the same default omap_device_pm_latency structure
>> during device built. In order to avoid the duplication of the same
>> structure everywhere, add a default structure that will be used if
>> the device does not have an explicit one.
>
> [...]
>
>> -	od->pm_lats = pm_lats;
>> -	od->pm_lats_cnt = pm_lats_cnt;
>> +	if (pm_lats) {
>> +		od->pm_lats = pm_lats;
>> +		od->pm_lats_cnt = pm_lats_cnt;
>> +	} else {
>> +		od->pm_lats = omap_default_latency;
>> +		od->pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
>> +	}
>
> Here is the fix for that part. I did the easy version :-). Splitting
> the structure in two parts will indeed require more work.

The kmemdup() method is fine with me.

> I updated the for_3.2/1_omap_device_cleanup branch.

Thanks, I'll pick these into my branch (which is now renamed to
for_3.2/omap_device-cleanup)

Kevin

> Regards,
> Benoit
>
> ---
> From ad163000568dd61dee441473d0a576d84152da9e Mon Sep 17 00:00:00 2001
> From: Benoit Cousson <b-cousson@ti.com>
> Date: Tue, 9 Aug 2011 16:54:19 +0200
> Subject: [PATCH v3 5/6] OMAP: omap_device: Create a default omap_device_pm_latency
>
> Most devices are using the same default omap_device_pm_latency structure
> during device built. In order to avoid the duplication of the same
> structure everywhere, add a default structure that will be used if
> the device does not have an explicit one.
>
> Next patches will clean the duplicated structures.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/plat-omap/omap_device.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 7b2cf62..54bbe7b 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -97,6 +97,14 @@
>  static int omap_device_register(struct platform_device *pdev);
>  static int omap_early_device_register(struct platform_device *pdev);
>  
> +static struct omap_device_pm_latency omap_default_latency[] = {
> +	{
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func   = omap_device_enable_hwmods,
> +		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	}
> +};
> +
>  /* Private functions */
>  
>  /**
> @@ -510,8 +518,17 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>  	if (ret)
>  		goto odbs_exit3;
>  
> -	od->pm_lats = pm_lats;
> +	if (!pm_lats) {
> +		pm_lats = omap_default_latency;
> +		pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
> +	}
> +
>  	od->pm_lats_cnt = pm_lats_cnt;
> +	od->pm_lats = kmemdup(pm_lats,
> +			sizeof(struct omap_device_pm_latency) * pm_lats_cnt,
> +			GFP_KERNEL);
> +	if (!od->pm_lats)
> +		goto odbs_exit3;
>  
>  	for (i = 0; i < oh_cnt; i++) {
>  		hwmods[i]->od = od;
