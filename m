From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP: Fix reprogramming of dpll1 rate
Date: Sat, 12 Nov 2011 01:22:20 +0200
Message-ID: <C8E8D8CC-FF6B-4E5B-9311-C0C34735570B@iki.fi>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi> <20111109231900.GS31337@atomide.com> <20111109232525.GT31337@atomide.com> <20111109233900.GP15294@n2100.arm.linux.org.uk> <20D8B951-2E77-42DF-B735-6062994D47D5@iki.fi> <20111110000421.GU31337@atomide.com> <alpine.DEB.2.00.1111102349170.19713@dell> <20111110232349.GY31337@atomide.com> <20111111191631.GH31337@atomide.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:55289 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab1KKXVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Nov 2011 18:21:11 -0500
In-Reply-To: <20111111191631.GH31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 11.11.2011, at 21.16, Tony Lindgren wrote:
> Commit a66cb3454f220f49f900646ebdc76cb943319eb7 (ARM: OMAP: Map SRAM
> later on with ioremap_exec()) moved the SRAM init to happen later
> to remove a dependency to early SoC detection for map_io.
>
> This broke booting on some boards not using Kconfig option for
> OMAP_CLOCKS_SET_BY_BOOTLOADER as the dpll1 reprogramming would
> cause the following error:
>
> kernel BUG at arch/arm/plat-omap/sram.c:226!
> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
> Modules linked in:
>
> CPU: 0    Not tainted  (3.2.0-rc1-e3 #9)
> PC is at omap_sram_reprogram_clock+0x28/0x30
> LR is at omap1_select_table_rate+0x88/0xb4
> pc : [<c001b0c4>]    lr : [<c0019f54>]    psr: 600000d3
> sp : c035bf10  ip : c035bf20  fp : c035bf1c
> r10: c035bfd4  r9 : 54029252  r8 : c03f8120
> r7 : c0362b50  r6 : 00b71b00  r5 : c03873cc  r4 : c0362b40
> r3 : 00000000  r2 : c0362b40  r1 : 0000010a  r0 : 00002cb0
> Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0000317f  Table: 10004000  DAC: 00000017
> Process swapper (pid: 0, stack limit = 0xc035a270)
> Stack: (0xc035bf10 to 0xc035c000)
> bf00:                                     c035bf3c c035bf20  
> c0019f54 c001b0ac
> bf20: 00001000 00002cb3 00000004 c035ed4c c035bf74 c035bf40  
> c033ea24 c0019edc
> bf40: c02f526c 00000002 00000015 bc058c9b 93111a16 c035335c  
> 02000000 c035ed4c
> bf60: c035ed4c c03f8120 c035bf84 c035bf78 c00194c4 c033e8ec  
> c035bfc4 c035bf88
> bf80: c033bc24 c00194a0 c035bf90 c035bf98 00000000 00000000  
> 00000000 00000000
> bfa0: 00000001 00000000 c0354678 c035ece4 10004000 103532f4  
> c035bff4 c035bfc8
> bfc0: c0338574 c033b598 00000000 00000000 00000000 c035467c  
> 0000317d c035c03c
> bfe0: c0354678 c035ece4 00000000 c035bff8 10008040 c0338508  
> 00000000 00000000
> Backtrace:
> [<c001b09c>] (omap_sram_reprogram_clock+0x0/0x30) from [<c0019f54>]  
> (omap1_select_table_rate+0x88/0xb4)
> [<c0019ecc>] (omap1_select_table_rate+0x0/0xb4) from [<c033ea24>]  
> (omap1_clk_init+0x148/0x334)
>  r7:c035ed4c r6:00000004 r5:00002cb3 r4:00001000
> [<c033e8dc>] (omap1_clk_init+0x0/0x334) from [<c00194c4>]  
> (omap1_init_early+0x34/0x48)
>  r8:c03f8120 r7:c035ed4c r6:c035ed4c r5:02000000 r4:c035335c
> [<c0019490>] (omap1_init_early+0x0/0x48) from [<c033bc24>]  
> (setup_arch+0x69c/0x79c)
> [<c033b588>] (setup_arch+0x0/0x79c) from [<c0338574>] (start_kernel 
> +0x7c/0x2f4)
> [<c03384f8>] (start_kernel+0x0/0x2f4) from [<10008040>] (0x10008040)
>  r7:c035ece4 r6:c0354678 r5:c035c03c r4:0000317d
> Code: 0a000002 e1a0e00f e12fff13 e89da800 (e7f001f2)
>
> Fix this by adding omap1_clk_late_init() that only reprograms dpll1
> if the bootloader rate is less than 60MHz. This also allows removing
> of the OMAP_CLOCKS_SET_BY_BOOTLOADER option.
>
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> ---
> This seems to work when forced on OSK5912 at least. Moving the dpll1
> reprogramming to happen later should not mess up drivers as it's still
> before driver inits. Also the system timer should not change as the
> source is ck_ref.

Cheers mate, this fixes the 3.2-rc1 boot issue on Amstrad E3.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
> diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/ 
> omap1_defconfig
> index 7b63462..a7e7775 100644
> --- a/arch/arm/configs/omap1_defconfig
> +++ b/arch/arm/configs/omap1_defconfig
> @@ -48,7 +48,6 @@ CONFIG_MACH_SX1=y
>  CONFIG_MACH_NOKIA770=y
>  CONFIG_MACH_AMS_DELTA=y
>  CONFIG_MACH_OMAP_GENERIC=y
> -CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=y
>  CONFIG_OMAP_ARM_216MHZ=y
>  CONFIG_OMAP_ARM_195MHZ=y
>  CONFIG_OMAP_ARM_192MHZ=y
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index e0a0281..73f287d 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -171,14 +171,6 @@ config MACH_OMAP_GENERIC
>  comment "OMAP CPU Speed"
>  	depends on ARCH_OMAP1
>
> -config OMAP_CLOCKS_SET_BY_BOOTLOADER
> -	bool "OMAP clocks set by bootloader"
> -	depends on ARCH_OMAP1
> -	help
> -	  Enable this option to prevent the kernel from overriding the clock
> -	  frequencies programmed by bootloader for MPU, DSP, MMUs, TC,
> -	  internal LCD controller and MPU peripherals.
> -
>  config OMAP_ARM_216MHZ
>  	bool "OMAP ARM 216 MHz CPU (1710 only)"
>          depends on ARCH_OMAP1 && ARCH_OMAP16XX
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index eaf09ef..16b1423 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -17,7 +17,8 @@
>
>  #include <plat/clock.h>
>
> -extern int __init omap1_clk_init(void);
> +int omap1_clk_init(void);
> +void omap1_clk_late_init(void);
>  extern int omap1_clk_enable(struct clk *clk);
>  extern void omap1_clk_disable(struct clk *clk);
>  extern long omap1_clk_round_rate(struct clk *clk, unsigned long  
> rate);
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/ 
> clock_data.c
> index 92400b9..1297bb5 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -767,6 +767,15 @@ static struct clk_functions  
> omap1_clk_functions = {
>  	.clk_disable_unused	= omap1_clk_disable_unused,
>  };
>
> +static void __init omap1_show_rates(void)
> +{
> +	pr_notice("Clocking rate (xtal/DPLL1/MPU): "
> +			"%ld.%01ld/%ld.%01ld/%ld.%01ld MHz\n",
> +		ck_ref.rate / 1000000, (ck_ref.rate / 100000) % 10,
> +		ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
> +		arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
> +}
> +
>  int __init omap1_clk_init(void)
>  {
>  	struct omap_clk *c;
> @@ -835,9 +844,12 @@ int __init omap1_clk_init(void)
>  	/* We want to be in syncronous scalable mode */
>  	omap_writew(0x1000, ARM_SYSST);
>
> -#ifdef CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER
> -	/* Use values set by bootloader. Determine PLL rate and recalculate
> -	 * dependent clocks as if kernel had changed PLL or divisors.
> +
> +	/*
> +	 * Initially use the values set by bootloader. Determine PLL rate  
> and
> +	 * recalculate dependent clocks as if kernel had changed PLL or
> +	 * divisors. See also omap1_clk_late_init() that can reprogram dpll1
> +	 * after the SRAM is initialized.
>  	 */
>  	{
>  		unsigned pll_ctl_val = omap_readw(DPLL_CTL);
> @@ -862,25 +874,10 @@ int __init omap1_clk_init(void)
>  			}
>  		}
>  	}
> -#else
> -	/* Find the highest supported frequency and enable it */
> -	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
> -		printk(KERN_ERR "System frequencies not set. Check your config. 
> \n");
> -		/* Guess sane values (60MHz) */
> -		omap_writew(0x2290, DPLL_CTL);
> -		omap_writew(cpu_is_omap7xx() ? 0x3005 : 0x1005, ARM_CKCTL);
> -		ck_dpll1.rate = 60000000;
> -	}
> -#endif
>  	propagate_rate(&ck_dpll1);
>  	/* Cache rates for clocks connected to ck_ref (not dpll1) */
>  	propagate_rate(&ck_ref);
> -	printk(KERN_INFO "Clocking rate (xtal/DPLL1/MPU): "
> -		"%ld.%01ld/%ld.%01ld/%ld.%01ld MHz\n",
> -	       ck_ref.rate / 1000000, (ck_ref.rate / 100000) % 10,
> -	       ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
> -	       arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
> -
> +	omap1_show_rates();
>  	if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
>  		/* Select slicer output as OMAP input clock */
>  		omap_writew(omap_readw(OMAP7XX_PCC_UPLD_CTRL) & ~0x1,
> @@ -925,3 +922,21 @@ int __init omap1_clk_init(void)
>
>  	return 0;
>  }
> +
> +#define OMAP1_DPLL1_SANE_VALUE	60000000
> +
> +void __init omap1_clk_late_init(void)
> +{
> +	if (ck_dpll1.rate >= OMAP1_DPLL1_SANE_VALUE)
> +		return;
> +
> +	/* Find the highest supported frequency and enable it */
> +	if (omap1_select_table_rate(&virtual_ck_mpu, ~0)) {
> +		pr_err("System frequencies not set, using default. Check your  
> config.\n");
> +		omap_writew(0x2290, DPLL_CTL);
> +		omap_writew(cpu_is_omap7xx() ? 0x3005 : 0x1005, ARM_CKCTL);
> +		ck_dpll1.rate = OMAP1_DPLL1_SANE_VALUE;
> +	}
> +	propagate_rate(&ck_dpll1);
> +	omap1_show_rates();
> +}
> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/ 
> devices.c
> index 48ef988..475cb2f 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -30,6 +30,8 @@
>  #include <plat/omap7xx.h>
>  #include <plat/mcbsp.h>
>
> +#include "clock.h"
> +
>  / 
> *--------------------------------------------------------------------- 
> ----*/
>
>  #if defined(CONFIG_RTC_DRV_OMAP) || defined 
> (CONFIG_RTC_DRV_OMAP_MODULE)
> @@ -293,6 +295,7 @@ static int __init omap1_init_devices(void)
>  		return -ENODEV;
>
>  	omap_sram_init();
> +	omap1_clk_late_init();
>
>  	/* please keep these calls, and their implementations above,
>  	 * in alphabetical order so they're easier to sort through.

