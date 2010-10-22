From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH] ARM: Fix data abort accessing proc_info from __lookup_processor_type
 (Re: [PATCH 03/10] ARM: hotplug cpu: Keep processor information, startup
 code & __lookup_processor_type)
Date: Fri, 22 Oct 2010 16:14:33 -0400
Message-ID: <4CC1F0A9.8050206@ti.com>
References: <E1P2oXV-00020M-QV@rmk-PC.arm.linux.org.uk> <20101022185108.GF17595@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38926 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392Ab0JVUOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Oct 2010 16:14:47 -0400
Received: by mail-iw0-f173.google.com with SMTP id 36so1398855iwn.4
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 13:14:45 -0700 (PDT)
In-Reply-To: <20101022185108.GF17595@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 10/22/2010 2:51 PM, Tony Lindgren wrote:
> * Russell King - ARM Linux<linux@arm.linux.org.uk>  [101004 10:18]:
>> When hotplug CPU is enabled, we need to keep the list of supported CPUs,
>> their setup functions, and __lookup_processor_type in place so that we
>> can find and initialize secondary CPUs.  Move these into the __CPUINIT
>> section.
>
>> +	__CPUINIT
>> +__lookup_processor_type:
>> +	adr	r3, __lookup_processor_type_data
>> +	ldmia	r3, {r4 - r6}
>> +	sub	r3, r3, r4			@ get offset between virt&phys
>> +	add	r5, r5, r3			@ convert virt addresses to
>> +	add	r6, r6, r3			@ physical address space
>> +1:	ldmia	r5, {r3, r4}			@ value, mask
>> +	and	r4, r4, r9			@ mask wanted bits
>> +	teq	r3, r4
>> +	beq	2f
>> +	add	r5, r5, #PROC_INFO_SZ		@ sizeof(proc_info_list)
>> +	cmp	r5, r6
>> +	blo	1b
>> +	mov	r5, #0				@ unknown processor
>> +2:	mov	pc, lr
>> +ENDPROC(__lookup_processor_type)
>
> The ldmia r5 above can cause a data abort depending on the compiler
> pixies. This can happen if r5 address is unaligned. Here's a fix
> for that.
>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren<tony@atomide.com>
> Date: Thu, 21 Oct 2010 19:00:41 -0700
> Subject: [PATCH] ARM: Fix data abort accessing proc_info from __lookup_processor_type
>
> Commit 5085f3ff458521045f7e43da62b8c30ea7df2e82 added better support for
> CONFIG_HOTPLUG_CPU by keeping proc_info around. However, depending on
> the Kconfig options selected, this can make the booting fail mysteriously
> early on.
>
> Turns out a data abort can happen in __lookup_processor in ldmia r5 {r3, r4}.
> When it happens the address loaded to r5 is not aligned. Fix the problem by
> aligning proc_info.
>
> Reported-by: Anand Gadiyar<gadiyar@ti.com>
> Signed-off-by: Tony Lindgren<tony@atomide.com>

Tested-by: Anand Gadiyar <gadiyar@ti.com>

This patch lets linux-next as of 20101021 boot up on my OMAP4 boards.


>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 1953e3d..a58b91d 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -114,6 +114,7 @@ SECTIONS
>   			*(.glue_7)
>   			*(.glue_7t)
>   		*(.got)			/* Global offset table		*/
> +			. = ALIGN(4);
>   			ARM_CPU_KEEP(PROC_INFO)
>   	}
>

