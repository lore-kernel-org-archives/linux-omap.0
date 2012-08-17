From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: OMAP HWMOD: Query regarding parent<->child support
Date: Fri, 17 Aug 2012 14:30:54 +0200
Message-ID: <502E397E.50904@ti.com>
References: <5004212C.5030807@ti.com> <502E1914.3050502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51507 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756738Ab2HQMa7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 08:30:59 -0400
In-Reply-To: <502E1914.3050502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mugunthan V N <mugunthanvnm@ti.com>, Avinash Philip <avinashphilip@ti.com>, Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Vaibhav,

On 08/17/2012 12:12 PM, Vaibhav Hiremath wrote:
> 
> 
> On 7/16/2012 7:41 PM, Vaibhav Hiremath wrote:
>> Hi All,
>>
> 
> Paul,
> 
> From last couple of days I am almost spending my whole time trying to
> get to somewhere on below issue and based on my understanding and
> learning so far I started feeling that, probably we might have made
> wrong decision to remove all leaf-nodes from the clock-tree. Instead we
> should have it removed from hwmod. :)
> 
> Let's take a example of PWM Module (which is the context of my debugging) -
> 
> As I mentioned before, PWM module present in AM33XX looks something like -
> 
> 
>     ----------------------------------
>    |            --------              |
>    |           |  PWMSS |             |
>    |            --------              |
>    |  -------   --------   ---------  |
>    | |  eCAP | |  ePWM  | |  eQEP   | |
>    |  -------   --------   ---------  |
>     ----------------------------------
> 
> PWMSS: This actually controls all PM related signals like idle,
>        standby, etc...
> eCAP/ePWM/eQEP: Technically it is independent module, reused from
>                 Davinci devices and is implemented as independent
>                 drivers in kernel.
> 
> In case of AM33xx, the basic resources like, clock, idle signal and
> standby signal are abstracted at PWMSS level.
> This means the core IP (eCAP/ePWM/eQEP) have not changed from their
> original implementation.
> 
> These core IP's (eCAP/ePWM/eQEP) are being used in Davinci family of
> devices, but without encapsulation of PWMSS, unlike AM33XX. This means,
> each module has its own clock enable/disable control mechanism and there
> is no dependency between them, unlike AM33XX.
> 
> Options to support:
> 
> 1. Use existing Clock Framework infrastructure to handle, which
> basically supports clock enable/disable function based on usecount and
> parent<->child relation. Driver will simply work, without knowing
> anything about underneath platform, which is what expected.
> So create a dummy-clocks for submodules, making PWMSS clock as a parent
> will solve the issue here.
> 
> And nothing wrong here, we are just treating,
>    clock-enable = module-enable

Yeah, but that looks like a hack to me. That clock hierarchy does not
exist for real and the pm_runtime infrastructure can handle that
properly. In that case you do have a PM dependency and not necessarily a
clock dependency.

> The only issue here is sysconf register access at hwmod level, if you
> leave sysconf idle and standby configuration at smart state, it works
> properly. I have validated it at my end.
> 
> 2. MFD Driver: I think it will be miss-use of MFD driver and should be
> explored at all.

I do think this is the proper use of MFD. In fact with DT, you don't
even need an MFD. The DT nodes hierarchy will create the parent-child
link automatically.

pm_runtime events are taking care of the parent state. It means that if
you are enabling a child, the parent will be enabled first automatically
by the PM fmwk.

This is how the DSS will/was be modified to handle the similar issue you
are facing today. I'm not sure that code is upstream yet, but was tested
on OMAP5.

The only drawback in your case is that the Davinci drivers must be
pm_runtime adapted, which might not be the case already :-(.

Regards,
Benoit


> I certainly vote for option-1.
> Paul, if you agree with me, I will submit the patch for option-1.
> 
> NOTE: Same thing is applicable for CPSW driver, where two independent
> drivers (MDIO and CPSW) share common clock and needs similar fix.
> 
> Thanks,
> Vaibhav
> 
>> During migration to run-time PM we came across unique (I believe) issue
>> with respect to CPSW driver and eHRPWM. I am looking for pointers to
>> handle these use-cases, as I am still going through the code and trying
>> to understand myself on how can we handle this.
>>
>> CPSW:
>> =====
>> CPSW Subsystem is built with 5 sub-modules,
>> 	- CPSW SS (BaseAddr@0x4A100000, rst@0x8)
>> 	- MDIO (BaseAddr@0x4A101000)
>> 	- CPSW WR (0x4A101200, rst@0x4)
>> 	- CPSW SL1 (0x4A100D80, rst@0xc)
>> 	- CPSW SL2 (0x4A100DC0, rst@0xc)
>> 	- CPSW CPDMA (0x4A100800, rst@0x1c)
>>
>>   Issue1:
>>   -------
>>     IP's are reused from legacy devices, for example, we have 2
>>     separate platform driver for MDIO and cpsw, used between Davinci
>>    and AM335x.
>>
>>     Everything is controlled through one MODULEMODE register in PRCM.
>>     So now we have 2 different modules accessing same resources
>>    (CLKCTRL.MODULEMODE), it is tricky to handle this usecase.
>>     Earlier with clock api's, it was easy, since clock framework used
>>     to handle ref_count for this and was sufficient here but with
>>     migration to runtime PM, we no longer use clk api's.
>>
>>     Option1:
>> 	It must be handled at driver level, and there will be
>> 	handshaking between both the drivers. Which might impact legacy
>> 	devices.
>>
>>    Option2:
>> 	It must be handled at SoC level, and parent and child creation
>> 	is required here. parent->child creation is possible with
>> 	platform device, but not sure about how it can be integrated
>> 	with omap_device and hwmod.
>>
>> 	I am reading code and trying to understand how can this be
>> 	handled? what is right place to create this parent<->child
>> 	relation?
>>
>>   Issue2:
>>   -------
>>     Due to one of the HW bug, we have assert ocp-reset 4 sub-modules of
>>     CPSW before disabling clock/module (MODULEMODE=0) everytime.
>>     So for example, in every suspend-resume code before disabling the
>>     module, we have to assert ocp-reset and then disable the module.
>>     Also, please note that, the MDIO driver is separate and independent
>>     and requires clock to access sysconf register.
>>
>>     We can have hwmod_class->reset function here, but the reset offset
>>     is different for every module, which makes it even difficult to
>>     handle.
>>
>>     So if we have parent-child relation at some level, Where, we can
>>     register custom reset function to handle this scenario is required,
>>     like,
>> 	CPSW
>> 	    -> MDIO
>> 	    -> CPSW WR
>> 	    -> CPSW SL1
>> 	    -> CPSW SL2
>> 	    -> CPDMA
>>
>>     Currently, as part of internal release we implemented in hackish
>>     way, where we pass base address of sub-modules (- 0x8) so that we
>>     can access rst_off in common function with,
>>       omap_hwmod_addr_space->pa_start + class.rst_offs
>>
>> eHRPWM1/2/3:
>> ============
>>   Here we have same issue as issue1 mentioned above for CPSW. eHRPWM is
>>   built with 2 independent sub-modules (eCAP and HRPWM) with single
>>   resource access (MODULEMODE).
>>
>>   Functionality point-of-view both can work independently, except
>>   clock/module enable disable (which is shared between both).
>>
>>   Will MFD solve this issue? and will it be right approach? Would it
>>   make sense to have MFD for such small small independent drivers?
>>
>> Thanks,
>> Vaibhav
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

