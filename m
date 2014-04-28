From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: Switch to THUMB mode if needed on secondary
 CPU
Date: Mon, 28 Apr 2014 12:20:02 -0500
Message-ID: <535E8DC2.4010504@ti.com>
References: <1398191506-3741-1-git-send-email-joelf@ti.com>
 <20140428164348.GA14354@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140428164348.GA14354@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 04/28/2014 11:43 AM, Dave Martin wrote:
> On Tue, Apr 22, 2014 at 01:31:46PM -0500, Joel Fernandes wrote:
>> On my DRA7 system, when the kernel is built in THUMB mode, the secondary CPU
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
>>   *
>>   * Author:
>>   *      Santosh Shilimkar <santosh.shilimkar@ti.com>
>> @@ -28,9 +28,13 @@
>>   * code.  This routine also provides a holding flag into which
>>   * secondary core is held until we're ready for it to initialise.
>>   * The primary core will update this flag using a hardware
>> -+ * register AuxCoreBoot0.
>> + * register AuxCoreBoot0.
>>   */
>>  ENTRY(omap5_secondary_startup)
> 
> Are you sure this problem is not caused by the missing ENDPROC() for
> omap5_secondary_startup?
> 
> You have END() instead (which may have been accidental).
> 
> Without ENDPROC(), the symbol is not marked as a function and so
> the Thumb bit won't be set when taking a pointer -- so the kernel
> is actually telling the firmware to enter in ARM state.
> 
> 
> Try changing END() to ENDPROC() without this patch, and see if it
> makes a difference.
> 
> If it still doesn't work, then the firmware either doesn't support
> entering in ARM, or is buggy.

Thanks for the suggestion. I'm guessing what you mean is with ENDPROC,
interworking code uses bx instead of bl to set thumb mode.

But ROM/firmware doesn't have access to symbol table, how would it know
the type of the symbol to be ARM or THUMB before it branches?

regards,
 -Joel
