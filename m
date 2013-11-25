From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Add HYP mode entry support for secondary
 CPUs
Date: Mon, 25 Nov 2013 12:02:32 -0500
Message-ID: <529382A8.6070509@ti.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com> <1385251666-27532-3-git-send-email-santosh.shilimkar@ti.com> <CAMJs5B8XX-93YcRyTiQ1JRcKUB5oer8cV7FLtMPP6SeqeB3RwQ@mail.gmail.com> <52937AB4.1060901@ti.com> <52937DF8.1070505@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55973 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab3KYRDC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 12:03:02 -0500
In-Reply-To: <52937DF8.1070505@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

On Monday 25 November 2013 11:42 AM, Marc Zyngier wrote:
> On 25/11/13 16:28, Santosh Shilimkar wrote:
>> On Monday 25 November 2013 10:09 AM, Christoffer Dall wrote:
>>> On 23 November 2013 16:07, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>>>> Boot-CPU entry into the HYP mode is managed in boot-loader but
>>>> the secondary CPUs directly jumps to kernel during boot. Same
>>>> path is also used for CPU hotplug as well during suspend for
>>>> secondary CPU.
>>>>
>>>> Hence patch the secondary CPU boot path for hyp mode etry.
>>>>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/omap-headsmp.S |    7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
>>>> index 75e9295..4844dd8 100644
>>>> --- a/arch/arm/mach-omap2/omap-headsmp.S
>>>> +++ b/arch/arm/mach-omap2/omap-headsmp.S
>>>> @@ -22,6 +22,7 @@
>>>>
>>>>  /* Physical address needed since MMU not enabled yet on secondary core */
>>>>  #define AUX_CORE_BOOT0_PA                      0x48281800
>>>> +#define API_HYP_ENTRY                          0x102
>>>>
>>>>  /*
>>>>   * OMAP5 specific entry point for secondary CPU to jump from ROM
>>>> @@ -38,6 +39,12 @@ wait:        ldr     r2, =AUX_CORE_BOOT0_PA  @ read from AuxCoreBoot0
>>>>         and     r4, r4, #0x0f
>>>>         cmp     r0, r4
>>>>         bne     wait
>>>> +#ifdef CONFIG_KVM_ARM_HOST
>>>> +       ldr     r12, =API_HYP_ENTRY
>>>> +       adr     r0, hyp_boot
>>>> +       smc     #0
>>>> +hyp_boot:
>>>> +#endif
>>>>         b       secondary_startup
>>>>  END(omap5_secondary_startup)
>>>>  /*
>>>
>>> hmm, this means that currently running this in a guest will fail to
>>> bring-up SMP, right?
>>>
>> Nope. Because the code under 'KVM_ARM_HOST' macro. Guest build 
>> will not enable CONFIG_KVM_ARM_HOST and things should be fine then.
>> Right ? 
> 
> Absolutely not. We're way past the "one image per usage" model, and I
> fully expect the same kernel to boot both as a guest and a host.
> Otherwise, multiplatform is just a joke.
> 
>>> Couldn't you create a little wrapper-pen in U-Boot instead, which
>>> replicates the omap boot protocol and takes care of the hyp-mode
>>> startup there instead, keeping this completely out of the kernel?
>>>
>> Its not just booting but CPU hotplug also follows the same path
>> so we need the mechanism in kernel to switch mode.
>>
>> In general, I think its important to consider the aspect with
>> CPU PM. CPUs are not going to go through the boot-loaders in
>> those paths and hence need of HYP entry in the kernel will
>> be must.
> 
> I definitely agree that you need to consider PM as well. But we've
> decided a long time ago that we wouldn't take that kind of code in the
> kernel. Your CPU has to reach the kernel in HYP, and that is down to
> your boot protocol to take care off that.
> 
> There are a few options. Christoffer mentioned having a pen, and you
> also could implement PSCI fairly easily (I've recently posted a u-boot
> patch series to take care of this, though there is still a fair bit of
> work required).
> 
> Whatever the approach is, the bottom line remains: your CPU enters the
> kernel in HYP.
> 
Our emails crossed. I understand the stand from you guys. Lets
continue discussion on other thread.
