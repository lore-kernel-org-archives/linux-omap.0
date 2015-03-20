From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] omapdss: extend pm notifier to handle hibernation
Date: Fri, 20 Mar 2015 19:19:57 +0200
Message-ID: <550C56BD.9000600@linaro.org>
References: <1424883836-9119-1-git-send-email-grygorii.strashko@linaro.org> <550C108E.3020907@ti.com> <550C3545.8060702@linaro.org> <550C3AEB.1090802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33755 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbCTRUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 13:20:08 -0400
Received: by ladw1 with SMTP id w1so92212556lad.0
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2015 10:20:05 -0700 (PDT)
In-Reply-To: <550C3AEB.1090802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-fbdev@vger.kernel.org

On 03/20/2015 05:21 PM, Tomi Valkeinen wrote:
> On 20/03/15 16:57, Grygorii.Strashko@linaro.org wrote:
>> On 03/20/2015 02:20 PM, Tomi Valkeinen wrote:
>>> On 25/02/15 19:03, grygorii.strashko@linaro.org wrote:
>>>> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>>>
>>>> Add handling of missed events in omap_dss_pm_notif which are
>>>> needed to support hibernation (suspend to disk).
>>>>
>>>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>>> ---
>>>>    drivers/video/fbdev/omap2/dss/core.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev/omap2/dss/core.c
>>>> index 6b74f73..e60976a 100644
>>>> --- a/drivers/video/fbdev/omap2/dss/core.c
>>>> +++ b/drivers/video/fbdev/omap2/dss/core.c
>>>> @@ -178,11 +178,15 @@ static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
>>>>    	DSSDBG("pm notif %lu\n", v);
>>>>    
>>>>    	switch (v) {
>>>> +	case PM_HIBERNATION_PREPARE:
>>>>    	case PM_SUSPEND_PREPARE:
>>>> +	case PM_RESTORE_PREPARE:
>>>>    		DSSDBG("suspending displays\n");
>>>>    		return dss_suspend_all_devices();
>>>>    
>>>>    	case PM_POST_SUSPEND:
>>>> +	case PM_POST_HIBERNATION:
>>>> +	case PM_POST_RESTORE:
>>>>    		DSSDBG("resuming displays\n");
>>>>    		return dss_resume_all_devices();
>>>>    
>>>
>>> Why suspend displays when PM_RESTORE_PREPARE happens? Why resume when
>>> PM_POST_RESTORE happens?
>>
>> We have following sequence when system is restored from hibernation:
>> - original kernel booted;
>> - late_initcall_sync(software_resume);
>>    - pm_notifier_call_chain(PM_RESTORE_PREPARE);
>>    - freeze_processes
>>    - check & read hibernation image
>>    - suspend all devices (.freeze())
>>    - jump to stored kernel
>>    - restore devices
>>    ...
>>
>> So, all devices should be in frozen/suspended state when we will jump to stored kernel
>> (device's state should be the same as before creating hib image).
>>
>> Without this patch I can see a lot of log messages like below:
> 
> Yes, I am sure a fix is needed for hibernation. But I still don't quite
> understand PM_RESTORE_PREPARE and PM_POST_RESTORE.
> 
> When we enter hibernation, there's only PM_HIBERNATION_PREPARE?

No. There is always PM_POST_HIBERNATION:
    - original Kernel in case of failure
    - restored Kernel on success

> 
> When waking from hibernation, there's first PM_RESTORE_PREPARE, where we
> need to disable displays that were enabled during boot. Then either
> PM_POST_HIBERNATION if all went well, or PM_POST_RESTORE if there was an
> error, and in both cases we want to enable the displays?

Yes.

====
int hibernate(void)
	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
...
	error = hibernation_snapshot(hibernation_mode == HIBERNATION_PLATFORM);
		^^^ restored kernel will start from here

	if (error || freezer_test_done)
		goto Free_bitmaps;

	if (in_suspend) {
...

		pr_debug("PM: writing image.\n");
		error = swsusp_write(flags);
		swsusp_free();
		if (!error)
			power_down();
		in_suspend = 0;
		pm_restore_gfp_mask();
		^^ this part will be executed by Kernel requested Hibernation

	} else {
		pr_debug("PM: Image restored successfully.\n");
		^^ this part will be executed by Kernel restored from Hibernation
	}

...
	pm_notifier_call_chain(PM_POST_HIBERNATION);
^^^ Both Kernels will be notified here:
    - original Kernel in case of failure
    - restored Kernel on success
    
    


====
static int software_resume(void)
	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
	error = swsusp_read(&flags);
	swsusp_close(FMODE_READ);
	if (!error)
		hibernation_restore(flags & SF_PLATFORM_MODE);
                ^^^ if ok we will never return from this function

	printk(KERN_ERR "PM: Failed to load hibernation image, recovering.\n");
	pm_notifier_call_chain(PM_POST_RESTORE);
^^^
   if fail - just continue work as usual


-- 
regards,
-grygorii
