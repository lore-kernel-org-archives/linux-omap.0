From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: Switch to THUMB mode if needed on secondary
 CPU
Date: Tue, 22 Apr 2014 14:39:58 -0500
Message-ID: <5356C58E.6020509@ti.com>
References: <1398191506-3741-1-git-send-email-joelf@ti.com> <CAGo_u6oyE0-Xnv8WV0Ks-i=jdyotGH5xTcTmNDrgT2fK3GfZFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51891 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbaDVTkd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 15:40:33 -0400
In-Reply-To: <CAGo_u6oyE0-Xnv8WV0Ks-i=jdyotGH5xTcTmNDrgT2fK3GfZFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

On 04/22/2014 01:47 PM, Nishanth Menon wrote:
> On Tue, Apr 22, 2014 at 1:31 PM, Joel Fernandes <joelf@ti.com> wrote:
>> On my DRA7 system, when the kernel is built in THUMB mode, the secondary CPU
> Did you mean THUMB2? omap2plus_defconfig works today with
> CONFIG_ARM_THUMB enabled..

ARM_THUMB is for user binaries though, not kernel. But yeah I should
reword the commit message to use Thumb-2. I'll do that.
> 
>> (Cortex A15) fails to come up causing SMP boot on second CPU to timeout. This
>> seems to be because the CPU is in ARM mode once the ROM hands over control to
>> the kernel.  Switch to THUMB mode if required once the kernel is control of
>> secondary CPU. On OMAP4 on the other hand, it appears to be in THUMB mode on
>> entry so this is not required and SMP boot works as is.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-headsmp.S |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
>> index 75e9295..1809dce 100644
>> --- a/arch/arm/mach-omap2/omap-headsmp.S
>> +++ b/arch/arm/mach-omap2/omap-headsmp.S
>> @@ -1,7 +1,7 @@
>>  /*
>>   * Secondary CPU startup routine source file.
>>   *
>> - * Copyright (C) 2009 Texas Instruments, Inc.
>> + * Copyright (C) 2014 Texas Instruments, Inc.
> 2009-2014

Sure.

> 
>>   *
>>   * Author:
>>   *      Santosh Shilimkar <santosh.shilimkar@ti.com>
>> @@ -28,9 +28,13 @@
>>   * code.  This routine also provides a holding flag into which
>>   * secondary core is held until we're ready for it to initialise.
>>   * The primary core will update this flag using a hardware
>> -+ * register AuxCoreBoot0.
>> + * register AuxCoreBoot0.
> 
> spurious change?
> 

The "+" is spurious, I was trying to correct that. Will update commit
message in v2.

thanks,
 -Joel

