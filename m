From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio/omap: ensure gpio context is initialised
Date: Fri, 19 Apr 2013 20:10:50 +0530
Message-ID: <51715772.9020003@ti.com>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com> <871ua734mv.fsf@linaro.org> <51707D7C.1050600@ti.com> <5170911C.6010507@ti.com> <51709499.8030208@ti.com> <5170E4EE.7090100@ti.com> <87sj2mzkcf.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48386 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030555Ab3DSOiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 10:38:54 -0400
In-Reply-To: <87sj2mzkcf.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Friday 19 April 2013 07:35 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On Friday 19 April 2013 06:19 AM, Jon Hunter wrote:
>>>
>>> On 04/18/2013 07:34 PM, Jon Hunter wrote:
>>>>
>>>> On 04/18/2013 06:10 PM, Jon Hunter wrote:
>>>>> On 04/18/2013 04:34 PM, Kevin Hilman wrote:
>>>>
>>>> ...
>>>>
>>>>>> Why not just init context right here if bank->loses_context &&
>>>>>> !bank->context_valid?
>>>>
>>>> I really like this idea a lot. It can really clean-up the code
>>>> and really make it much more readable. Before we were playing 
>>>> some tricks with when we init'ed the get_context_loss_count()
>>>> function pointer. How about the below?
>>>>
>>>> Tony, care to re-test?
>>>>
>>>> Cheers
>>>> Jon
>>>>
>>>> From d7a940531d354e6be5e16ee50fa8344041df963a Mon Sep 17 00:00:00 2001
>>>> From: Jon Hunter <jon-hunter@ti.com>
>>>> Date: Mon, 15 Apr 2013 13:06:54 -0500
>>>> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
>>>>
>>>> Commit a2797be (gpio/omap: force restore if context loss is not
>>>> detectable) broke gpio support for OMAP when booting with device-tree
>>>> because a restore of the gpio context being performed without ever
>>>> initialising the gpio context. In other words, the context restored was
>>>> bad.
>>>>
>>>> This problem could also occur in the non device-tree case, however, it
>>>> is much less likely because when booting without device-tree we can
>>>> detect context loss via a platform specific API and so context restore
>>>> is performed less often.
>>>>
>>>> Nevertheless we should ensure that the gpio context is initialised
>>>> on the first pm-runtime resume for gpio banks that could lose their
>>>> state regardless of whether we are booting with device-tree or not.
>>>>
>>>> The context loss count was being initialised on the first pm-runtime
>>>> suspend following a resume, by populating the get_count_loss_count()
>>>> function pointer after the first pm-runtime resume. To make the code
>>>> more readable and logical, initialise the context loss count on the
>>>> first pm-runtime resume if the context is not yet valid.
>>>>
>>>> Reported-by: Tony Lindgren <tony@atomide.com>
>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>> ---
>>>>  drivers/gpio/gpio-omap.c |   45 ++++++++++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 42 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>> index 0557529..db3c732 100644
>>>> --- a/drivers/gpio/gpio-omap.c
>>>> +++ b/drivers/gpio/gpio-omap.c
>>>> @@ -70,6 +70,7 @@ struct gpio_bank {
>>>>  	bool is_mpuio;
>>>>  	bool dbck_flag;
>>>>  	bool loses_context;
>>>> +	bool context_valid;
>>>>  	int stride;
>>>>  	u32 width;
>>>>  	int context_loss_count;
>>>> @@ -1129,6 +1130,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>>>>  			bank->loses_context = true;
>>>>  	} else {
>>>>  		bank->loses_context = pdata->loses_context;
>>>> +		bank->get_context_loss_count = pdata->get_context_loss_count;
>>>
>>> Still need to check loses_context for populating
>>> get_context_loss_count here. Updated patch below.
>>>
>>> Jon
>>>
>>> From d02ef7b7dfcf8e13bf019aedfdecb38ca3c6749f Mon Sep 17 00:00:00 2001
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
>> This version looks better than the first one for sure. I am still not
>> happy with per bank "context_valid" flag whose job just ends after
>> the probe. 
> 
> Assuming this driver could become a module someday (not terribly likely,
> I know), but context_valid would have meaning for each module reload.
> 
I don't think GPIO can ever be a module(at least on OMAP) considering the way
it is used in many SOCs and hence the objection on that flag. GPIO is really
an infrastructure driver which is needed to be always available for the
client drivers to work. 

Regards,
Santosh
