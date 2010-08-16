From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH] : Bug fix in generic runtime pm APIs
Date: Mon, 16 Aug 2010 20:15:40 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270BE1011@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940270AE9715@dbde02.ent.ti.com>
 <4C693E82.9000503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55666 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab0HPOqT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 10:46:19 -0400
In-Reply-To: <4C693E82.9000503@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi,
 
>> -----Original Message-----
>> From: Kalliguddi, Hema
>> Sent: Friday, August 13, 2010 7:08 PM
>> To: Cousson, Benoit
>> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kevin Hilman; 
>Paul.Walmsley[paul@pwsan.com]
>> Subject: RE: [PATCH] : Bug fix in generic runtime pm APIs
>>
>> Hi,
>>
>>> -----Original Message-----
>>> From: Cousson, Benoit
>>> Sent: Friday, August 13, 2010 6:29 PM
>>> To: Kalliguddi, Hema
>>> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kevin Hilman;
>>> Paul.Walmsley[paul@pwsan.com]
>>> Subject: Re: [PATCH] : Bug fix in generic runtime pm APIs
>>>
>>> Hi Hema,
>>>
>>> On 8/13/2010 2:31 PM, Kalliguddi, Hema wrote:
>>>> From: Hema HK<hemahk@ti.com>
>>>>
>>>> pm_generic_runtime_resume/pm_generic_runtime_suspend api
>>> should return zero if
>>>> driver has not implemented runtime_suspend or runtime_resume apis.
>>>
>>> Why? Could you elaborate?
>>>
>> I don't have runtime_suspend and runtime_resume APIs 
>implemented in the usb driver.
>> When runtime_pm_get_sync is called there is a -22 as return value.
>
>It is still not clear why it is related to the following patch?
>Can you explain in what context you observe that?

Sorry. It is not related o following commit. It is related to 
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=1ebda92e47879750c739f6125ab11632a8f6f713

In this pm_generic_runtime_resume() API returns -EINVAL if there is no 
runtime_resume and runtime_suspend APIs implemented by driver.

I observe this issue when I call runtime_pm_get_sync api in the driver and check for the return value.
The return value is -22 because there is no runtime_resume API implemented in the USB driver.

>
>> Is not it is valid if there is no runtime_suspend and 
>runtime_resume implemented by drivers/device?
>> Why should this API returns -EINVAL if there is no 
>runtime_resume and runtime_suspend APIs ?
>
>Good question, you should maybe ask the original author, who is Rafael.
>

Rafael,

Is it mandatory to implement the runtime_suspend and runtime_resume APIs in the driver
even if there is nothing to done in the APIs?

>
>This patch is just adding platform_pm_suspend_noirq and 
>platform_pm_resume_noirq custom implementation in order to use 
>the same 
>idle / enable as runtime PM.
>How it is related to your problem?

This is not related.
>
>>> This patch is changing some core driver code, so you should probably
>>> send it to Rafael / lkml / linux-pm.
>>>
>> I am not sure the above commit posted by Kevin already. This 
>issue I am seeing on Kevin's pm-wip/hwmods-omap4 branch.
>
>That does not matter. The code you are trying to change is already in 
>mainline kernel, so you just have to explain how you observe 
>that issue.
Yes you are right. I will check with Rafael.
>
>Regards,
>Benoit
>
>>
>>> Regards,
>>> Benoit
>>>
>>>> Signed-off-by: Hema HK<hemahk@ti.com>
>>>>
>>>> Cc: Tony Lindgren<tony@atomide.com>
>>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>>> Cc: Cousson, Benoit<b-cousson@ti.com>
>>>> Cc: Paul Walmsley [paul@pwsan.com]
>>>> ---
>>>> Based of: Kevin's pm-wip/hwmods-omap4  branch
>>>>
>>>>    drivers/base/power/generic_ops.c |    8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> Index: linux-omap-pm/drivers/base/power/generic_ops.c
>>>> ===================================================================
>>>> --- linux-omap-pm.orig/drivers/base/power/generic_ops.c	
>>> 2010-08-13 08:05:54.705862674 -0400
>>>> +++ linux-omap-pm/drivers/base/power/generic_ops.c	
>>> 2010-08-13 08:06:19.257924404 -0400
>>>> @@ -38,14 +38,14 @@
>>>>     *
>>>>     * If PM operations are defined for the @dev's driver and
>>> they include
>>>>     * ->runtime_suspend(), execute it and return its error
>>> code.  Otherwise,
>>>> - * return -EINVAL.
>>>> + * return Zero.
>>>>     */
>>>>    int pm_generic_runtime_suspend(struct device *dev)
>>>>    {
>>>>    	const struct dev_pm_ops *pm = dev->driver ?
>>> dev->driver->pm : NULL;
>>>>    	int ret;
>>>>
>>>> -	ret = pm&&   pm->runtime_suspend ?
>>> pm->runtime_suspend(dev) : -EINVAL;
>>>> +	ret = pm&&   pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
>>>>
>>>>    	return ret;
>>>>    }
>>>> @@ -57,14 +57,14 @@
>>>>     *
>>>>     * If PM operations are defined for the @dev's driver and
>>> they include
>>>>     * ->runtime_resume(), execute it and return its error
>>> code.  Otherwise,
>>>> - * return -EINVAL.
>>>> + * return Zero.
>>>>     */
>>>>    int pm_generic_runtime_resume(struct device *dev)
>>>>    {
>>>>    	const struct dev_pm_ops *pm = dev->driver ?
>>> dev->driver->pm : NULL;
>>>>    	int ret;
>>>>
>>>> -	ret = pm&&   pm->runtime_resume ?
>>> pm->runtime_resume(dev) : -EINVAL;
>>>> +	ret = pm&&   pm->runtime_resume ? pm->runtime_resume(dev) : 0;
>>>>
>>>>    	return ret;
>>>>    }
>>>
>>>
>
>