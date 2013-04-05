From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 2/4] ARM: OMAP4+: PM: Consolidate OMAP4 PM code to
 re-use it for OMAP5
Date: Fri, 5 Apr 2013 19:05:22 +0530
Message-ID: <515ED31A.3000307@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-3-git-send-email-santosh.shilimkar@ti.com>
 <20130405132150.GN11464@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130405132150.GN11464@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 05 April 2013 06:51 PM, Felipe Balbi wrote:
> On Fri, Apr 05, 2013 at 06:29:01PM +0530, Santosh Shilimkar wrote:
>> OMAP5 has backward compatible PRCM block and it's programming
>> model is mostly similar to OMAP4. Same is going to be maintained
>> for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
>> management code so that it can be re-used on OMAP5 and later devices.
>>
>> While at it, update the kernel-doc for omap4_pm_init().
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/Makefile                       |    9 +--
>>  arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   58 ++++++++++++++++----
>>  .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
>>  3 files changed, 53 insertions(+), 14 deletions(-)
>>  rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (83%)
>>  rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>> index b068b7f..3e59895 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -35,14 +35,14 @@ obj-$(CONFIG_SOC_HAS_OMAP2_SDRC)	+= sdrc.o
>>  obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
>>  obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
>>  omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
>> -					   sleep44xx.o
>> +					   sleep_omap4plus.o
>>  obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
>>  obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-common)
>>  
>>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>>  AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
>>  AFLAGS_omap-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
>> -AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a$(plus_sec)
>> +AFLAGS_sleep_omap4plus.o		:=-Wa,-march=armv7-a$(plus_sec)
>>  
>>  # Functions loaded to SRAM
>>  obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
>> @@ -80,11 +80,12 @@ endif
>>  obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
>>  
>>  ifeq ($(CONFIG_PM),y)
>> +omap4plus-common-pm			= omap-mpuss-lowpower.o pm_omap4plus.o
>>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
>> -obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
>> +obj-$(CONFIG_ARCH_OMAP4)		+= $(omap4plus-common-pm)
>> +obj-$(CONFIG_SOC_OMAP5)			+= $(omap4plus-common-pm)
>>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>>  
>>  obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm_omap4plus.c
>> similarity index 83%
>> rename from arch/arm/mach-omap2/pm44xx.c
>> rename to arch/arm/mach-omap2/pm_omap4plus.c
>> index 5ba6d88..228deca 100644
>> --- a/arch/arm/mach-omap2/pm44xx.c
>> +++ b/arch/arm/mach-omap2/pm_omap4plus.c
>> @@ -1,7 +1,7 @@
>>  /*
>> - * OMAP4 Power Management Routines
>> + * OMAP4+ Power Management Routines
>>   *
>> - * Copyright (C) 2010-2011 Texas Instruments, Inc.
>> + * Copyright (C) 2010-2013 Texas Instruments, Inc.
>>   * Rajendra Nayak <rnayak@ti.com>
>>   * Santosh Shilimkar <santosh.shilimkar@ti.com>
>>   *
>> @@ -135,16 +135,16 @@ static void omap_default_idle(void)
>>  }
>>  
>>  /**
>> - * omap4_pm_init - Init routine for OMAP4 PM
>> + * omap4_init_static_deps - Add OMAP4 static dependencies
>>   *
>> - * Initializes all powerdomain and clockdomain target states
>> - * and all PRCM settings.
>> + * Add needed static clockdomain dependencies on OMAP4 devices.
>> + * Return: 0 on success or 'err' on failures
>>   */
>> -int __init omap4_pm_init(void)
>> +static inline int omap4_init_static_deps(void)
> 
> you can let compiler inline this if it chooses to, right ?? Otherwise,
> if you really want to make sure this will be inlined, you could(should?)
> be using __always_inline.
> 
Compilers are smart now so that fine. 
