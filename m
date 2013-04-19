From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Fri, 19 Apr 2013 07:05:52 -0700
Message-ID: <87sj2mzkcf.fsf@linaro.org>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
	<871ua734mv.fsf@linaro.org> <51707D7C.1050600@ti.com>
	<5170911C.6010507@ti.com> <51709499.8030208@ti.com>
	<5170E4EE.7090100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62456 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030427Ab3DSOF4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 10:05:56 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so2280869pab.8
        for <linux-omap@vger.kernel.org>; Fri, 19 Apr 2013 07:05:56 -0700 (PDT)
In-Reply-To: <5170E4EE.7090100@ti.com> (Santosh Shilimkar's message of "Fri,
	19 Apr 2013 12:02:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Friday 19 April 2013 06:19 AM, Jon Hunter wrote:
>> 
>> On 04/18/2013 07:34 PM, Jon Hunter wrote:
>>>
>>> On 04/18/2013 06:10 PM, Jon Hunter wrote:
>>>> On 04/18/2013 04:34 PM, Kevin Hilman wrote:
>>>
>>> ...
>>>
>>>>> Why not just init context right here if bank->loses_context &&
>>>>> !bank->context_valid?
>>>
>>> I really like this idea a lot. It can really clean-up the code
>>> and really make it much more readable. Before we were playing 
>>> some tricks with when we init'ed the get_context_loss_count()
>>> function pointer. How about the below?
>>>
>>> Tony, care to re-test?
>>>
>>> Cheers
>>> Jon
>>>
>>> From d7a940531d354e6be5e16ee50fa8344041df963a Mon Sep 17 00:00:00 2001
>>> From: Jon Hunter <jon-hunter@ti.com>
>>> Date: Mon, 15 Apr 2013 13:06:54 -0500
>>> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
>>>
>>> Commit a2797be (gpio/omap: force restore if context loss is not
>>> detectable) broke gpio support for OMAP when booting with device-tree
>>> because a restore of the gpio context being performed without ever
>>> initialising the gpio context. In other words, the context restored was
>>> bad.
>>>
>>> This problem could also occur in the non device-tree case, however, it
>>> is much less likely because when booting without device-tree we can
>>> detect context loss via a platform specific API and so context restore
>>> is performed less often.
>>>
>>> Nevertheless we should ensure that the gpio context is initialised
>>> on the first pm-runtime resume for gpio banks that could lose their
>>> state regardless of whether we are booting with device-tree or not.
>>>
>>> The context loss count was being initialised on the first pm-runtime
>>> suspend following a resume, by populating the get_count_loss_count()
>>> function pointer after the first pm-runtime resume. To make the code
>>> more readable and logical, initialise the context loss count on the
>>> first pm-runtime resume if the context is not yet valid.
>>>
>>> Reported-by: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>  drivers/gpio/gpio-omap.c |   45 ++++++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 42 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index 0557529..db3c732 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -70,6 +70,7 @@ struct gpio_bank {
>>>  	bool is_mpuio;
>>>  	bool dbck_flag;
>>>  	bool loses_context;
>>> +	bool context_valid;
>>>  	int stride;
>>>  	u32 width;
>>>  	int context_loss_count;
>>> @@ -1129,6 +1130,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>>>  			bank->loses_context = true;
>>>  	} else {
>>>  		bank->loses_context = pdata->loses_context;
>>> +		bank->get_context_loss_count = pdata->get_context_loss_count;
>> 
>> Still need to check loses_context for populating
>> get_context_loss_count here. Updated patch below.
>> 
>> Jon
>> 
>> From d02ef7b7dfcf8e13bf019aedfdecb38ca3c6749f Mon Sep 17 00:00:00 2001
>> From: Jon Hunter <jon-hunter@ti.com>
>> Date: Mon, 15 Apr 2013 13:06:54 -0500
>> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
>> 
>> Commit a2797be (gpio/omap: force restore if context loss is not
>> detectable) broke gpio support for OMAP when booting with device-tree
>> because a restore of the gpio context being performed without ever
>> initialising the gpio context. In other words, the context restored was
>> bad.
>> 
>> This problem could also occur in the non device-tree case, however, it
>> is much less likely because when booting without device-tree we can
>> detect context loss via a platform specific API and so context restore
>> is performed less often.
>> 
>> Nevertheless we should ensure that the gpio context is initialised
>> on the first pm-runtime resume for gpio banks that could lose their
>> state regardless of whether we are booting with device-tree or not.
>> 
>> The context loss count was being initialised on the first pm-runtime
>> suspend following a resume, by populating the get_count_loss_count()
>> function pointer after the first pm-runtime resume. To make the code
>> more readable and logical, initialise the context loss count on the
>> first pm-runtime resume if the context is not yet valid.
>> 
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
> This version looks better than the first one for sure. I am still not
> happy with per bank "context_valid" flag whose job just ends after
> the probe. 

Assuming this driver could become a module someday (not terribly likely,
I know), but context_valid would have meaning for each module reload.

> But then I do agree with you about the global flag might
> be fragile and less maintainable.
>
> So, FWIW,
> Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>

Yes, this version is more readable.  Thanks for the update.

Reviewed-by: Kevin Hilman <khilman@linaro.org>
