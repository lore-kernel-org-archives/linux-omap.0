From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v4 2/4] TI816X: Update common OMAP machine specific
 sources
Date: Sat, 22 Jan 2011 07:42:25 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB4B5@dbde02.ent.ti.com>
References: <1294677471-18714-1-git-send-email-hemantp@ti.com>
 <8762thes2z.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59509 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab1AVCMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 21:12:35 -0500
In-Reply-To: <8762thes2z.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Kevin,

Kevin Hilman wrote on Saturday, January 22, 2011 5:19 AM:

> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch updates the common machine specific source files with support
>> for TI816X. 
>> 
>> The approach taken is to have TI816X only build for OMAP3 when
>> CONFIG_SOC_OMAPTI816X is defined.
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>> ---
>>  arch/arm/mach-omap2/clock3xxx_data.c           |    5 +++-
>>  arch/arm/mach-omap2/common.c                   |   24 +++++++++++++++++
>>  arch/arm/mach-omap2/control.h                  |   17 ++++++++++++
>>  arch/arm/mach-omap2/id.c                       |   33
>>  ++++++++++++++++++++++- arch/arm/mach-omap2/include/mach/entry-macro.S | 
>>  13 +++++++++ arch/arm/mach-omap2/io.c                       |   13
>>  ++++++++- arch/arm/mach-omap2/irq.c                      |    5 +++-
>>  arch/arm/mach-omap2/serial.c                   |    8 +++---
>>  arch/arm/plat-omap/io.c                        |    5 +++-
>>  9 files changed, 113 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c
> b/arch/arm/mach-omap2/clock3xxx_data.c
>> index 9ab817e..557de99 100644
>> --- a/arch/arm/mach-omap2/clock3xxx_data.c
>> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
>> @@ -3466,6 +3466,9 @@ int __init omap3xxx_clk_init(void)
>>  	} else if (cpu_is_omap3630()) {
>>  		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
>>  		cpu_clkflg = CK_36XX;
>> +	} else if (cpu_is_ti816x()) {
>> +		cpu_mask = RATE_IN_TI816X;
>> +		cpu_clkflg = CK_TI816X;
>>  	} else if (cpu_is_omap34xx()) {
>>  		if (omap_rev() == OMAP3430_REV_ES1_0) {
>>  			cpu_mask = RATE_IN_3430ES1;
>> @@ -3545,7 +3548,7 @@ int __init omap3xxx_clk_init(void)  	/*
>>  	 * Lock DPLL5 and put it in autoidle.
>>  	 */
>> -	if (omap_rev() >= OMAP3430_REV_ES2_0)
>> +	if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0)) 
>> omap3_clk_lock_dpll5(); 
>> 
>>  	/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
>> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
>> index 778929f..7f58b7f 100644 --- a/arch/arm/mach-omap2/common.c
>> +++ b/arch/arm/mach-omap2/common.c
>> @@ -108,6 +108,30 @@ void __init omap3_map_io(void) 
>>  	omap2_set_globals_3xxx(); omap34xx_map_common_io();
>>  }
>> +
>> +/*
>> + * Adjust TAP register base such that omap3_check_revision accesses the
>> correct + * TI816X register for checking device ID (it adds 0x204 to tap
>> base while + * TI816X DEVICE ID register is at offset 0x600 from control
>> base). + */ +#define TI816X_TAP_BASE		(TI816X_CTRL_BASE + \
>> +				TI816X_CONTROL_DEVICE_ID - 0x204)
>> +
>> +static struct omap_globals ti816x_globals = {
>> +	.class  = OMAP343X_CLASS,
>> +	.tap    = OMAP2_L4_IO_ADDRESS(TI816X_TAP_BASE),
>> +	.ctrl   = TI816X_CTRL_BASE,
>> +	.prm    = TI816X_PRCM_BASE,
>> +	.cm     = TI816X_PRCM_BASE,
>> +	.uart1_phys     = TI816X_UART1_BASE,
>> +	.uart2_phys     = TI816X_UART2_BASE,
>> +	.uart3_phys     = TI816X_UART3_BASE,
> 
> The uart*_phys are not needed. I just sent a patch to remove these from
> the core code.
> 
>> +};
>> +
>> +void __init omap2_set_globals_ti816x(void)
>> +{
>> +	__omap2_set_globals(&ti816x_globals);
>> +}
>>  #endif
>> 
>>  #if defined(CONFIG_ARCH_OMAP4)
>> diff --git a/arch/arm/mach-omap2/control.h
> b/arch/arm/mach-omap2/control.h
>> index f0629ae..5c87054 100644
>> --- a/arch/arm/mach-omap2/control.h
>> +++ b/arch/arm/mach-omap2/control.h
>> @@ -52,6 +52,11 @@
>>  #define OMAP343X_CONTROL_PADCONFS_WKUP	0xa00
>>  #define OMAP343X_CONTROL_GENERAL_WKUP	0xa60
>> 
>> +/* TI816X spefic control submodules */
>> +#define TI816X_CONTROL_OCPCONF		0x000
>> +#define TI816X_CONTROL_DEVBOOT		0x040
>> +#define TI816X_CONTROL_DEVCONF		0x600
> 
> Not used in this patch (or series)
> 
>>  /* Control register offsets - read/write with
> omap_ctrl_{read,write}{bwl}() */
>> 
>>  #define OMAP2_CONTROL_SYSCONFIG
> (OMAP2_CONTROL_INTERFACE + 0x10)
>> @@ -241,6 +246,18 @@
>>  #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
>>  #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
>> 
>> +/* TI816X CONTROL_DEVBOOT register offsets */
>> +#define TI816X_CONTROL_STATUS
> (TI816X_CONTROL_DEVBOOT + 0x000)
>> +#define TI816X_CONTROL_BOOTSTAT
> (TI816X_CONTROL_DEVBOOT + 0x004)
>> +
>> +/* TI816X CONTROL_DEVCONF register offsets */
>> +#define TI816X_CONTROL_DEVICE_ID	(TI816X_CONTROL_DEVCONF + 0x000)
>> +#define TI816X_CONTROL_MAC_ID0_LO	(TI816X_CONTROL_DEVCONF + 0x030)
>> +#define TI816X_CONTROL_MAC_ID0_HI	(TI816X_CONTROL_DEVCONF + 0x034)
>> +#define TI816X_CONTROL_MAC_ID1_LO	(TI816X_CONTROL_DEVCONF + 0x038)
>> +#define TI816X_CONTROL_MAC_ID1_HI	(TI816X_CONTROL_DEVCONF + 0x03c)
>> +#define TI816X_CONTROL_PCIE_CFG
> (TI816X_CONTROL_DEVCONF + 0x040)
> 
> Not used in this patch (or series)
> 
> In general, we don't like to see unused code added in a patch or series.
> It is better for review (and also for later investigtion with git-blame
> or git bisect) to have code added only when it is used.
> 
> Thanks,
> 
> Kevin

I will rearrange the files or remove unused parts.

Thanks
   Hemant