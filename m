From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 29 Aug 2013 16:41:20 -0500
Message-ID: <521FC000.6080900@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <1375811376-49985-9-git-send-email-d-gerlach@ti.com> <87mwo2vmds.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55202 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3H2Vlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 17:41:47 -0400
In-Reply-To: <87mwo2vmds.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>

On 08/27/2013 04:45 PM, Kevin Hilman wrote:
> Dave Gerlach <d-gerlach@ti.com> writes:
>
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> AM335x supports various low power modes as documented
>> in section 8.1.4.3 of the AM335x TRM which is available
>> @ http://www.ti.com/litv/pdf/spruh73f
>>
>> DeepSleep0 mode offers the lowest power mode with limited
>> wakeup sources without a system reboot and is mapped as
>> the suspend state in the kernel. In this state, MPU and
>> PER domains are turned off with the internal RAM held in
>> retention to facilitate resume process. As part of the boot
>> process, the assembly code is copied over to OCMCRAM using
>> the OMAP SRAM code.
>>
>> AM335x has a Cortex-M3 (WKUP_M3) which assists the MPU
>> in DeepSleep0 entry and exit. WKUP_M3 takes care of the
>> clockdomain and powerdomain transitions based on the
>> intended low power state. MPU needs to load the appropriate
>> WKUP_M3 binary onto the WKUP_M3 memory space before it can
>> leverage any of the PM features like DeepSleep.
>>
>> The IPC mechanism between MPU and WKUP_M3 uses a mailbox
>> sub-module and 8 IPC registers in the Control module. MPU
>> uses the assigned Mailbox for issuing an interrupt to
>> WKUP_M3 which then goes and checks the IPC registers for
>> the payload. WKUP_M3 has the ability to trigger on interrupt
>
> s/trigger on interrupt/trigger an interrupt/  ??

Oops I will fix that.

>
>> to MPU by executing the "sev" instruction.
>>
>> In the current implementation when the suspend process
>> is initiated MPU interrupts the WKUP_M3 to let it know about
>> the intent of entering DeepSleep0 and waits for an ACK. When
>> the ACK is received MPU continues with its suspend process
>> to suspend all the drivers and then jumps to assembly in
>> OCMC RAM. The assembly code puts the PLLs in bypass, puts the
>> external RAM in self-refresh mode and then finally execute the
>> WFI instruction. Execution of the WFI instruction triggers another
>> interrupt to the WKUP_M3 which then continues wiht the power down
>> sequence wherein the clockdomain and powerdomain transition takes
>> place. As part of the sleep sequence, WKUP_M3 unmasks the interrupt
>> lines for the wakeup sources. WFI execution on WKUP_M3 causes the
>> hardware to disable the main oscillator of the SoC.
>>
>> When a wakeup event occurs, WKUP_M3 starts the power-up
>> sequence by switching on the power domains and finally
>> enabling the clock to MPU. Since the MPU gets powered down
>> as part of the sleep sequence in the resume path ROM code
>> starts executing. The ROM code detects a wakeup from sleep
>> and then jumps to the resume location in OCMC which was
>> populated in one of the IPC registers as part of the suspend
>> sequence.
>>
>> The low level code in OCMC relocks the PLLs, enables access
>> to external RAM and then jumps to the cpu_resume code of
>> the kernel to finish the resume process.
>
> [...]
>
>>   arch/arm/mach-omap2/pm33xx.c  |  474 +++++++++++++++++++++++++++++++++++++++++
>>   arch/arm/mach-omap2/pm33xx.h  |   77 +++++++
>>   arch/arm/mach-omap2/wkup_m3.c |  183 ++++++++++++++++
>
>
> Looking closer at this code as I'm trying to fully get my head around
> all the IPC, I have some more comments.
>
> I think the split between pm33xx.c and the M3 driver is still confusing
> here.  For example, am33xx_ping_wkup_m3(),
> am33xx_m3_state_machine_reset() and the guts of am33xx_pm_begin() all
> belong inside the M3 driver, along with all the wakeup_src stuff, which
> is info coming from the M3.
>
> IOW, the communication with M3 should be abstracted from pm33xx by the
> M3 driver (or possibly an eventual remoteproc/rpmsg implementation) with
> a well defined API.  In this implementation, the interface is pretty
> fuzzy and mixed between pm33xx.c and wkup_m3.c.

I have since moved much more of the m3 functionality, including the ping 
and wakeup src code, into the wkup_m3 driver to make the split more 
clear but I haven't yet moved the state machine portion into the wkup_m3 
driver. I feel that this is the portion of the IPC that could 
potentially be the most variant between different SoC implementations so 
leaving this in the pm code should allow for more flexibility.

>
> Kevin
>
> P.S. I'd also suggest renaming wakeup_src to something else since
> it's close to wakeup_source which has a rather different meaning in the
> kernel (c.f. linux/pm_wakeup.h)
>

I will rename this to tie it into the M3 code.

Regards,
Dave

