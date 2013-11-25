From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: HYP Kernel boot requirements [Was ...Re: [PATCH 2/2] ARM: OMAP5:
 Add HYP mode entry support for secondary CPUs]
Date: Mon, 25 Nov 2013 11:59:16 -0500
Message-ID: <529381E4.3090405@ti.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com> <1385251666-27532-3-git-send-email-santosh.shilimkar@ti.com> <CAMJs5B8XX-93YcRyTiQ1JRcKUB5oer8cV7FLtMPP6SeqeB3RwQ@mail.gmail.com> <52937AB4.1060901@ti.com> <CAMJs5B9nnpqjSmT7vi9cvC4e9Fx2Bft4rRGxmVKyLP7JbGMPAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37841 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab3KYQ75 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 11:59:57 -0500
In-Reply-To: <CAMJs5B9nnpqjSmT7vi9cvC4e9Fx2Bft4rRGxmVKyLP7JbGMPAg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Monday 25 November 2013 11:33 AM, Christoffer Dall wrote:
> On 25 November 2013 08:28, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
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
>>
> 
> That really goes against the whole single binary on all platforms
> thing. With multi-platform support you really shouldn't have to
> compile your kernel any differently for running as a guest as when
> you're running on a host.  Someone may even emulate an OMAP5 in QEMU
> and you'd certainly want your kvm-enabled kernel to run as both guest
> and host.  After all, this is not a paravirtualization solution.
> 
Fair enough.

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
>>
> I agree, and PSCI is the obvious only correct answer to this.
> 
> We have discussed this a bit earlier (I think Will Deacon brought this
> up - cc'ed), but I don't think anyone had any bright ideas.
> 
> However, we broadly agreed on the fact that for KVM/hyp support, you
> need to boot your kernel in that mode, and this is definitely pulling
> in the wrong direction.
> 
What I am saying is the platforms like OMAP5 already support PM in
mainline kernel and we can't break that for KVM. Boot-loaders
would be thrashed after boot so you need something which runs
in Kernel or along with Kernel to have equivalent of hyp
switching.

Am not challenging the agreed direction but we need to solve the
PM problem as well before making "all CPU runs boot-loader for
HYP kernels" as a must have. At least its is a change in boot
strategy from existing kernels.

CC'ing few more folks and changing the subject line

Regards,
Santosh

 

