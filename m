From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] drm/omap: tiler: add hibernation callback
Date: Fri, 20 Mar 2015 16:57:49 +0200
Message-ID: <550C356D.8060204@linaro.org>
References: <1424887700-5909-1-git-send-email-grygorii.strashko@linaro.org> <55099207.3060006@linaro.org> <550C07FB.3060104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36272 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbbCTO56 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 10:57:58 -0400
Received: by labe2 with SMTP id e2so13709752lab.3
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2015 07:57:57 -0700 (PDT)
In-Reply-To: <550C07FB.3060104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>

On 03/20/2015 01:43 PM, Tomi Valkeinen wrote:
> On 18/03/15 16:56, Grygorii.Strashko@linaro.org wrote:
>> Hi All,
>>
>> On 02/25/2015 08:08 PM, grygorii.strashko@linaro.org wrote:
>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>
>>> Setting a dev_pm_ops resume callback but not a set of
>>> hibernation handler means that pm function will not be
>>> called upon hibernation.
>>> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
>>> assigns the suspend and hibernation handlers and move
>>> omap_dmm_resume under CONFIG_PM_SLEEP to avoid build warnings.
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>>> ---
>>>    drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 10 +++-------
>>>    1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>>> b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>>> index 56c6055..afb8cfc 100644
>>> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>>> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>>> @@ -941,7 +941,7 @@ error:
>>>    }
>>>    #endif
>>>
>>> -#ifdef CONFIG_PM
>>> +#ifdef CONFIG_PM_SLEEP
>>>    static int omap_dmm_resume(struct device *dev)
>>>    {
>>>        struct tcm_area area;
>>> @@ -965,12 +965,10 @@ static int omap_dmm_resume(struct device *dev)
>>>
>>>        return 0;
>>>    }
>>> -
>>> -static const struct dev_pm_ops omap_dmm_pm_ops = {
>>> -    .resume = omap_dmm_resume,
>>> -};
>>>    #endif
>>>
>>> +SIMPLE_DEV_PM_OPS(omap_dmm_pm_ops, NULL, omap_dmm_resume);
>>> +
>>>    #if defined(CONFIG_OF)
>>>    static const struct of_device_id dmm_of_match[] = {
>>>        { .compatible = "ti,omap4-dmm", },
>>> @@ -986,9 +984,7 @@ struct platform_driver omap_dmm_driver = {
>>>            .owner = THIS_MODULE,
>>>            .name = DMM_DRIVER_NAME,
>>>            .of_match_table = of_match_ptr(dmm_of_match),
>>> -#ifdef CONFIG_PM
>>>            .pm = &omap_dmm_pm_ops,
>>> -#endif
>>>        },
>>>    };
>>>
>>>
>>
>> Any comments on this?
>
> Sorry, I missed this. I'll add it to my omapdrm branch.
>
Thanks.

-- 
regards,
-grygorii
