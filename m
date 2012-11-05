From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 6 Nov 2012 03:22:16 +0530
Message-ID: <50983510.80000@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com> <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com> <87txt4aqyc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2KEVwU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 16:52:20 -0500
In-Reply-To: <87txt4aqyc.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com

On Monday 05 November 2012 11:10 PM, Kevin Hilman wrote:
> +Santosh (to help with EMIF questions/comments)
>
> On 11/02/2012 12:32 PM, Vaibhav Bedia wrote:
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
>> to MPU by executing the "sev" instruction.
>>
>> In the current implementation when the suspend process
>> is initiated MPU interrupts the WKUP_M3 to let about the
>> intent of entering DeepSleep0 and waits for an ACK. When
>> the ACK is received, MPU continues with its suspend process
>> to suspend all the drivers and then jumps to assembly in
>> OCMC RAM to put the PLLs in bypass, put the external RAM in
>> self-refresh mode and then finally execute the WFI instruction.
>> The WFI instruction triggers another interrupt to the WKUP_M3
>> which then continues wiht the power down sequence wherein the
>> clockdomain and powerdomain transition takes place. As part of
>> the sleep sequence, WKUP_M3 unmasks the interrupt lines for
>> the wakeup sources. When WKUP_M3 executes WFI, the hardware
>> disables the main oscillator.
>>
>> When a wakeup event occurs, WKUP_M3 starts the power-up
>> sequence by switching on the power domains and finally
>> enabling the clock to MPU. Since the MPU gets powered down
>> as part of the sleep sequence, in the resume path ROM code
>> starts executing. The ROM code detects a wakeup from sleep
>> and then jumps to the resume location in OCMC which was
>> populated in one of the IPC registers as part of the suspend
>> sequence.
>>
>> The low level code in OCMC relocks the PLLs, enables access
>> to external RAM and then jumps to the cpu_resume code of
>> the kernel to finish the resume process.
>>
>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> Very well summarized.  Thanks for the thorough changelog.
>
> First, some general comments.  This is a big patch and probably should
> be broken up a bit.  I suspect it could be broken up a bit, maybe into
> at least:
>
> - EMIF interface
> - SCM interface, new APIs
> - assembly/OCM code
> - pm33xx.[ch]
> - lastly, the late_init stuff that actually initizlizes
>
> I have a handful of comments below.  I wrote this up on the plane over
> the weekend, and I see that Santosh has already made some similar
> comments, but I'll send mine anyways.
>
[...]

>
>> +extern void __iomem *am33xx_get_emif_base(void);
>> +int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg);
>> +#endif
>> +
>> +#define	IPC_CMD_DS0			0x3
>> +#define IPC_CMD_RESET                   0xe
>> +#define DS_IPC_DEFAULT			0xffffffff
>> +
>> +#define IPC_RESP_SHIFT			16
>> +#define IPC_RESP_MASK			(0xffff << 16)
>> +
>> +#define M3_STATE_UNKNOWN		0
>> +#define M3_STATE_RESET			1
>> +#define M3_STATE_INITED			2
>> +#define M3_STATE_MSG_FOR_LP		3
>> +#define M3_STATE_MSG_FOR_RESET		4
>> +
>> +#define AM33XX_OCMC_END			0x40310000
>> +#define AM33XX_EMIF_BASE		0x4C000000
>> +
>> +/*
>> + * This a subset of registers defined in drivers/memory/emif.h
>> + * Move that to include/linux/?
>> + */
>
> I'd probably suggest just moving the register definitions you
> need into <plat/emif_plat.h> so they can be shared with the driver.
>
> Also, the EMIF stuff would benefit greatly from using symbolic defines
> for the values being written.  Probably having those in
> <plat/emif_plat.h> would also help out here.
>
> Or, maybe the EMIF driver can provide some self-contained stubs that can
> be copied to OCP RAM for the functionality needed here?
>
> Santosh, what do you think of that?
>
Thats what I mentioned in my comment. I also don't know why such a bad
hardware choice was made when we have perfectly working EMIF IP across
low power states. Even the self refresh control is managed inside
hardware upon idle.  My guess is DDR self-refresh might be the reason
to use OCMC RAM.

In either case, Keeping EMIF changes separate as part of EMIF 
driver/platform code is right way to go about it. May be the
disable_selfrefresh() might need to kept in assembly files since it 
needs to be running from SRAM but rest need not be part of
PM code.

Regards
Santosh

For

Regards
Santosh



