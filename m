From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Tue, 9 Jul 2013 21:59:28 +0300
Message-ID: <51DC5D90.1010603@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE93C23@DBDE04.ent.ti.com> <20130705115959.GQ5523@atomide.com> <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com> <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com> <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com> <20130708133512.GD31221@arwen.pp.htv.fi> <51DBA0C2.6030003@ti.com> <20130709064212.GB5552@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55593 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3GITAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jul 2013 15:00:21 -0400
In-Reply-To: <20130709064212.GB5552@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On 07/09/2013 09:42 AM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jul 09, 2013 at 11:03:54AM +0530, Rajendra Nayak wrote:
>> On Monday 08 July 2013 07:05 PM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Mon, Jul 08, 2013 at 06:50:01PM +0530, Rajendra Nayak wrote:
>>>>>>>>>> I wonder if this is because the timeouts get now initialized to 0 instead
>>>>>>>>>> of -1 for the serial driver?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> You meant initialized to -1, right? There's an additional check for timeout being 0. Unless i
>>>>>>>>> am missing something DT-boot will start off with timeout set to 0 and then get forced to -1.
>>>>>>>
>>>>>>> OK
>>>>>>
>>>>>> Issue 2: Causing boot to stop when serial driver is initialized.
>>>>>> (After Issue 1 is fixed)
>>>>>>
>>>>>> I could narrow this down to the change done to return -EINVAL
>>>>>> instead of 0 in serial_omap_get_context_loss_count() as part of
>>>>>> commit 'a630fbfbb1beeffc5bbe542a7986bf2068874633' "serial: omap:
>>>>>> Fix device tree based PM runtime"
>>>>>>
>>>>>> What this change in turn seems to do is cause a
>>>>>> serial_omap_restore_context() to get called as part of
>>>>>> serial_omap_runtime_resume() which was not the case when
>>>>>> serial_omap_get_context_loss_count() returned 0
>>>>>>
>>>>>> from serial_omap_runtime_resume():
>>>>>> -----
>>>>>>          int loss_cnt = serial_omap_get_context_loss_count(up);
>>>>>>
>>>>>>          if (loss_cnt < 0) {
>>>>>>                  dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
>>>>>>                          loss_cnt);
>>>>>>                  serial_omap_restore_context(up);
>>>>>>          } else if (up->context_loss_cnt != loss_cnt) {
>>>>>>                  serial_omap_restore_context(up);
>>>>>>          }
>>>>>> -----
>>>>>>
>>>>>> I am still working on why a serial_omap_restore_context() could
>>>>>> have caused console to die. I will work with Sourav on this and
>>>>>> post the fixes for both issue 1 and issue2 once its clear on whats
>>>>>> really causing issue 2.
>>>>>
>>>>> That's because we don't have the omap specific pdata callbacks for
>>>>> context loss any longer. We may be able to detect when the context
>>>>> was really lost in the serial driver, and only then call the
>>>>> serial_omap_restore_context().
>>>>
>>>> Right, but calling serial_omap_restore_context() even when the context
>>>> is not lost, should not ideally cause an issue.
>>>
>>> it does in one condition. If context hasn't been saved before. And that
>>> can happen in the case of wrong pm runtime status for that device.
>>>
>>> Imagine the device is marked as suspended even though it's fully enabled
>>> (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
>>> your context structure is all zeroes (context has never been saved
>>> before) then when you call pm_runtime_get_sync() on probe() your
>>> ->runtime_resume() will get called, which will restore context,
>>> essentially undoing anything which was configured by u-boot.
>>
>> This could be a problem for drivers which do a save context in ->runtime_suspend()
>> but from what I see with omap serial, there is no save context done as part of
>> ->runtime_suspend.
>
> right, because context is "saved" in set_termios. probe() will get
> called much before set_termios() has a chance to run, right ?
>
> Same problem will trigger in that case.
>
> I still think patch below is necessary
>
>>> (completely untested, didn't even try to compile, just to illustrate)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 7341eff..d8dca68 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -2559,6 +2559,12 @@ static void __init _setup_postsetup(struct omap_hwmod *oh)
>>>   	    (postsetup_state == _HWMOD_STATE_IDLE)) {
>>>   		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
>>>   		postsetup_state = _HWMOD_STATE_ENABLED;
>>> +
>>> +		/* tell pm_runtime this device is already active */
>>> +		pm_runtime_set_active(&oh->od->pdev->dev);
>>> +	} else {
>>> +		/* tell pm_runtime this device is trully suspended */
>>> +		pm_runtime_set_suspended(&oh->od->pdev->dev);
>>>   	}
>>>
>>>   	if (postsetup_state == _HWMOD_STATE_IDLE)
>

This will not work - _setup_postsetup() is called from core_initcall 
level and OMAP devices have not been created at this moment yet 
(of_platform_populate() is called from
customize_machine->init_machine->omap_generic_init() at arch_initcall time)

More over, I don't recommend to depend on hwmod->od field - it's been 
created to support OPPs and it's obsolete now in case of DT use.

Seems, This issue need to be handled in driver for DT boot use case, 
possibly cmdline need to be parsed in the same way as it's done in
omap_serial_early_init().

Regards,
-grygorii

