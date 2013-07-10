From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Boot hang regression 3.10.0-rc4 -> 3.10.0
Date: Wed, 10 Jul 2013 15:16:54 +0300
Message-ID: <51DD50B6.5030604@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com> <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com> <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com> <20130708133512.GD31221@arwen.pp.htv.fi> <51DBA0C2.6030003@ti.com> <20130709064212.GB5552@arwen.pp.htv.fi> <51DC5D90.1010603@ti.com> <20130709194131.GA12523@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49561 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab3GJMRs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jul 2013 08:17:48 -0400
In-Reply-To: <20130709194131.GA12523@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Sourav Poddar <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>

On 07/09/2013 10:41 PM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jul 09, 2013 at 09:59:28PM +0300, Grygorii Strashko wrote:
>>>>> Imagine the device is marked as suspended even though it's fully enabled
>>>>> (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
>>>>> your context structure is all zeroes (context has never been saved
>>>>> before) then when you call pm_runtime_get_sync() on probe() your
>>>>> ->runtime_resume() will get called, which will restore context,
>>>>> essentially undoing anything which was configured by u-boot.
>>>>
>>>> This could be a problem for drivers which do a save context in ->runtime_suspend()
>>>> but from what I see with omap serial, there is no save context done as part of
>>>> ->runtime_suspend.
>>>
>>> right, because context is "saved" in set_termios. probe() will get
>>> called much before set_termios() has a chance to run, right ?
>>>
>>> Same problem will trigger in that case.
>>>
>>> I still think patch below is necessary
>>>
>>>>> (completely untested, didn't even try to compile, just to illustrate)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>>>> index 7341eff..d8dca68 100644
>>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>>> @@ -2559,6 +2559,12 @@ static void __init _setup_postsetup(struct omap_hwmod *oh)
>>>>>   	    (postsetup_state == _HWMOD_STATE_IDLE)) {
>>>>>   		oh->_int_flags |= _HWMOD_SKIP_ENABLE;
>>>>>   		postsetup_state = _HWMOD_STATE_ENABLED;
>>>>> +
>>>>> +		/* tell pm_runtime this device is already active */
>>>>> +		pm_runtime_set_active(&oh->od->pdev->dev);
>>>>> +	} else {
>>>>> +		/* tell pm_runtime this device is trully suspended */
>>>>> +		pm_runtime_set_suspended(&oh->od->pdev->dev);
>>>>>   	}
>>>>>
>>>>>   	if (postsetup_state == _HWMOD_STATE_IDLE)
>>>
>>
>> This will not work - _setup_postsetup() is called from core_initcall
>> level and OMAP devices have not been created at this moment yet
>> (of_platform_populate() is called from
>> customize_machine->init_machine->omap_generic_init() at arch_initcall time)
>
> fair enough, but something *like* that needs to be done. If pm_runtime
> doesn't know the state of the device by the time pm_runtime_enable() is
> called, the wrong assumptions might be made and we will forever have
> such problems as our ->runtime_resume() callback being called when it
> shouldn't.
>
>> More over, I don't recommend to depend on hwmod->od field - it's been
>> created to support OPPs and it's obsolete now in case of DT use.
>
> that's alright, but still we need something similar.
>
> But in any case, if on DT boot that's not used, than *what* uses
> HWMOD_INIT_NO_IDLE during DT boot ?
>
> There's a single place in kernel source which checks if
> HWMOD_INIT_NO_IDLE is set, and that's the place which I patched.
>
> We, certainly, need a way to tell pm_runtime if the device is active or
> suspended by the time we reach our probe() function. Either we assume
> *all* devices are active and we blindly call pm_runtime_set_active() for
> all devices, or we assume *all* devices are suspended as we call
> pm_runtime_set_suspend() for all devices, or we figure out which ones
> are active and which are not and call pm_runtime_set_{active,suspend}()
> conditionally.
>
>> Seems, This issue need to be handled in driver for DT boot use case,
>> possibly cmdline need to be parsed in the same way as it's done in
>> omap_serial_early_init().
>
> so you want *every* single driver to parse their own cmdline ? How big
> would the cmdline become ? This makes no sense.
>

Agree here. Seems there two similar issues:
- this one with omap_serial
- GPIO reset issue http://www.spinics.net/lists/linux-omap/msg84186.html
   (similar issue is observed on OMAP4460+TPS6236x)

And I think, that HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET flags can't 
be treated as
SoC (IP) specific parameters any more - they should be board specific.

I think, some kind of board_layout {} DT definition need to be created 
to solve these issues (just an idea). For example:

Board DTS file:
board_layout {
  ti,hwmods-init-no-reset = "gpio1", "uart3";
  ti,hwmods-init-no-idle = "uart3";
}

Then above DT parameters can be used in omap_hwmod_setup_all()->_setup()
and omap_device_build_from_dt().
- omap_hwmod_setup_all()->_setup() will configure hwmod's flags
- omap_device_build_from_dt() will check for HWMOD_INIT_NO_IDLE and
   call pm_runtime_set_active() if needed (this is the valid place for that)

NOTE. "ti,hwmods-init-no-reset" and "ti,hwmods-init-no-idle" can't be 
defined per device, because HWMOD framework will work 
(init/reset/setup/idle) with IP even if corresponding IP is not defined 
in DT.

More over, board_layout{} section can be used to define some common for 
OMAP2+ boards properties or enable/disable PM features, like:
- Setup clksetup/clkshoutdown time for oscillator
- enable/disable OFF-mode

Regards,
-grygorii

