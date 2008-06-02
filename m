From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 1/1] Added sleep support to UART
Date: Mon, 2 Jun 2008 11:09:20 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394301510E0@vaebe110.NOE.Nokia.com>
References: <1212072948-3987-1-git-send-email-tero.kristo@nokia.com> <1212072948-3987-2-git-send-email-tero.kristo@nokia.com> <20080530230148.GE30901@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27915 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbYFBIJt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 04:09:49 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080530230148.GE30901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Hi,

This patch currently depends on at least one of the PM workaround
patches from Jouni Hogander. Namely this one:

[PATCH 07/10] 34XX: PM: Workaround to check whether any fck is active
before entering sleep

Sorry I think I forgot to mention this in the patch note. Should we
change the patch in order to make this one apply cleanly (I could make a
separate patch for the UART fclk hack which depends on the above?)

-Tero

>-----Original Message-----
>From: ext Tony Lindgren [mailto:tony@atomide.com] 
>Sent: 31 May, 2008 02:02
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 1/1] Added sleep support to UART
>
>Hi,
>
>* Tero Kristo <tero.kristo@nokia.com> [080529 06:07]:
>> UART usage (e.g. serial console) now denies sleep for 5 
>seconds. This 
>> makes it possible to use serial console when dynamic idle is enabled.
>> 
>> Also moved code from pm-debug.c to serial.c, and made pm24xx.c use 
>> this new implementation.
>
>The changes for pm34xx.c don't currently apply, can you please 
>refresh this patch?
>
>Thanks,
>
>Tony
>
>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm-debug.c     |  132 
>------------------------------------
>>  arch/arm/mach-omap2/pm.h           |    8 --
>>  arch/arm/mach-omap2/pm24xx.c       |   53 ++++++++++-----
>>  arch/arm/mach-omap2/pm34xx.c       |    8 ++-
>>  arch/arm/mach-omap2/serial.c       |  118 
>++++++++++++++++++++++++++++++++
>>  include/asm-arm/arch-omap/common.h |    3 +
>>  6 files changed, 163 insertions(+), 159 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/pm-debug.c 
>> b/arch/arm/mach-omap2/pm-debug.c index 8a9f3c4..c20fa3b 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -34,138 +34,6 @@
>>  #ifdef CONFIG_PM_DEBUG
>>  int omap2_pm_debug = 0;
>>  
>> -static int serial_console_clock_disabled; -static int 
>> serial_console_uart; -static unsigned int 
>serial_console_next_disable;
>> -
>> -static struct clk *console_iclk, *console_fclk;
>> -
>> -static void serial_console_kick(void) -{
>> -	serial_console_next_disable = omap2_read_32k_sync_counter();
>> -	/* Keep the clocks on for 4 secs */
>> -	serial_console_next_disable += 4 * 32768;
>> -}
>> -
>> -static void serial_wait_tx(void)
>> -{
>> -	static const unsigned long uart_bases[3] = {
>> -		0x4806a000, 0x4806c000, 0x4806e000
>> -	};
>> -	unsigned long lsr_reg;
>> -	int looped = 0;
>> -
>> -	/* Wait for TX FIFO and THR to get empty */
>> -	lsr_reg = IO_ADDRESS(uart_bases[serial_console_uart - 
>1] + (5 << 2));
>> -	while ((__raw_readb(lsr_reg) & 0x60) != 0x60)
>> -		looped = 1;
>> -	if (looped)
>> -		serial_console_kick();
>> -}
>> -
>> -u32 omap2_read_32k_sync_counter(void) -{
>> -        return omap_readl(OMAP2_32KSYNCT_BASE + 0x0010);
>> -}
>> -
>> -void serial_console_fclk_mask(u32 *f1, u32 *f2) -{
>> -	switch (serial_console_uart)  {
>> -	case 1:
>> -		*f1 &= ~(1 << 21);
>> -		break;
>> -	case 2:
>> -		*f1 &= ~(1 << 22);
>> -		break;
>> -	case 3:
>> -		*f2 &= ~(1 << 2);
>> -		break;
>> -	}
>> -}
>> -
>> -void serial_console_sleep(int enable) -{
>> -	if (console_iclk == NULL || console_fclk == NULL)
>> -		return;
>> -
>> -	if (enable) {
>> -		BUG_ON(serial_console_clock_disabled);
>> -		if (clk_get_usecount(console_fclk) == 0)
>> -			return;
>> -		if ((int) serial_console_next_disable - (int) 
>omap2_read_32k_sync_counter() >= 0)
>> -			return;
>> -		serial_wait_tx();
>> -		clk_disable(console_iclk);
>> -		clk_disable(console_fclk);
>> -		serial_console_clock_disabled = 1;
>> -	} else {
>> -		int serial_wakeup = 0;
>> -		u32 l;
>> -
>> -		switch (serial_console_uart)  {
>> -		case 1:
>> -			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
>> -			if (l & OMAP24XX_ST_UART1)
>> -				serial_wakeup = 1;
>> -			break;
>> -		case 2:
>> -			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
>> -			if (l & OMAP24XX_ST_UART2)
>> -				serial_wakeup = 1;
>> -			break;
>> -		case 3:
>> -			l = prm_read_mod_reg(CORE_MOD, 
>OMAP24XX_PM_WKST2);
>> -			if (l & OMAP24XX_ST_UART3)
>> -				serial_wakeup = 1;
>> -			break;
>> -		}
>> -		if (serial_wakeup)
>> -			serial_console_kick();
>> -		if (!serial_console_clock_disabled)
>> -			return;
>> -		clk_enable(console_iclk);
>> -		clk_enable(console_fclk);
>> -		serial_console_clock_disabled = 0;
>> -	}
>> -}
>> -
>> -void pm_init_serial_console(void)
>> -{
>> -	const struct omap_serial_console_config *conf;
>> -	char name[16];
>> -
>> -	conf = omap_get_config(OMAP_TAG_SERIAL_CONSOLE,
>> -			       struct omap_serial_console_config);
>> -	if (conf == NULL)
>> -		return;
>> -	if (conf->console_uart > 3 || conf->console_uart < 1)
>> -		return;
>> -	serial_console_uart = conf->console_uart;
>> -	sprintf(name, "uart%d_fck", conf->console_uart);
>> -	console_fclk = clk_get(NULL, name);
>> -	if (IS_ERR(console_fclk))
>> -		console_fclk = NULL;
>> -	name[6] = 'i';
>> -	console_iclk = clk_get(NULL, name);
>> -	if (IS_ERR(console_fclk))
>> -		console_iclk = NULL;
>> -	if (console_fclk == NULL || console_iclk == NULL) {
>> -		serial_console_uart = 0;
>> -		return;
>> -	}
>> -	switch (serial_console_uart) {
>> -	case 1:
>> -		prm_set_mod_reg_bits(OMAP24XX_ST_UART1, 
>CORE_MOD, PM_WKEN1);
>> -		break;
>> -	case 2:
>> -		prm_set_mod_reg_bits(OMAP24XX_ST_UART2, 
>CORE_MOD, PM_WKEN1);
>> -		break;
>> -	case 3:
>> -		prm_set_mod_reg_bits(OMAP24XX_ST_UART3, 
>CORE_MOD, OMAP24XX_PM_WKEN2);
>> -		break;
>> -	}
>> -}
>> -
>>  #define DUMP_PRM_MOD_REG(mod, reg)    \
>>  	regs[reg_count].name = #mod "." #reg; \
>>  	regs[reg_count++].val = prm_read_mod_reg(mod, reg) diff --git 
>> a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h index 
>> 351456e..a1a35ea 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -20,18 +20,10 @@ extern unsigned short enable_dyn_sleep;  extern 
>> atomic_t sleep_block;
>>  
>>  #ifdef CONFIG_PM_DEBUG
>> -extern u32 omap2_read_32k_sync_counter(void);
>>  extern void omap2_pm_dump(int mode, int resume, unsigned int us); 
>> -extern void serial_console_fclk_mask(u32 *f1, u32 *f2); 
>-extern void 
>> pm_init_serial_console(void); -extern void serial_console_sleep(int 
>> enable);  extern int omap2_pm_debug;  #else -#define 
>> omap2_read_32k_sync_counter() 0; -#define 
>serial_console_sleep(enable) 
>> do; while(0) -#define pm_init_serial_console() do; while(0)  #define 
>> omap2_pm_dump(mode,resume,us) do; while(0) -#define 
>> serial_console_fclk_mask(f1,f2)  do; while(0)  #define 
>omap2_pm_debug 
>> 0  #endif /* CONFIG_PM_DEBUG */  #endif diff --git 
>> a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c index 
>> 5d060de..9bb7ae4 100644
>> --- a/arch/arm/mach-omap2/pm24xx.c
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -44,6 +44,7 @@
>>  #include <asm/arch/mux.h>
>>  #include <asm/arch/dma.h>
>>  #include <asm/arch/board.h>
>> +#include <asm/arch/common.h>
>>  
>>  #include "prm.h"
>>  #include "prm-regbits-24xx.h"
>> @@ -77,7 +78,9 @@ static int omap2_fclks_active(void)
>>  
>>  	f1 = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
>>  	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
>> -	serial_console_fclk_mask(&f1, &f2);
>> +#ifdef CONFIG_PM_DEBUG
>> +	omap_serial_fclk_mask(&f1, &f2);
>> +#endif
>>  	if (f1 | f2)
>>  		return 1;
>>  	return 0;
>> @@ -85,7 +88,8 @@ static int omap2_fclks_active(void)
>>  
>>  static void omap2_enter_full_retention(void)  {
>> -	u32 l, sleep_time = 0;
>> +	u32 l = 0;
>> +	s64 sleep_time = 0;
>>  
>>  	/* There is 1 reference hold for all children of the oscillator
>>  	 * clock, the following will remove it. If no one else 
>uses the @@ 
>> -114,29 +118,38 @@ static void omap2_enter_full_retention(void)
>>  	omap2_gpio_prepare_for_retention();
>>  
>>  	if (omap2_pm_debug) {
>> +		struct timespec t;
>>  		omap2_pm_dump(0, 0, 0);
>> -		sleep_time = omap2_read_32k_sync_counter();
>> +		getnstimeofday(&t);
>> +		sleep_time = timespec_to_ns(&t);
>>  	}
>>  
>> +#ifdef CONFIG_PM_DEBUG
>> +	omap_serial_enable_clocks(0);
>> +#endif
>> +
>>  	/* One last check for pending IRQs to avoid extra latency due
>>  	 * to sleeping unnecessarily. */
>>  	if (omap_irq_pending())
>>  		goto no_sleep;
>>  
>> -	serial_console_sleep(1);
>>  	/* Jump to SRAM suspend code */
>>  	omap2_sram_suspend(OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL));
>>  no_sleep:
>> -	serial_console_sleep(0);
>> +#ifdef CONFIG_PM_DEBUG
>> +	omap_serial_check_wakeup();
>> +	omap_serial_enable_clocks(1);
>> +#endif
>>  
>>  	if (omap2_pm_debug) {
>>  		unsigned long long tmp;
>> -		u32 resume_time;
>> +		s64 resume_time;
>> +		struct timespec t;
>>  
>> -		resume_time = omap2_read_32k_sync_counter();
>> +		getnstimeofday(&t);
>> +		resume_time = timespec_to_ns(&t);
>>  		tmp = resume_time - sleep_time;
>> -		tmp *= 1000000;
>> -		omap2_pm_dump(0, 1, tmp / 32768);
>> +		omap2_pm_dump(0, 1, tmp / 1000);
>>  	}
>>  	omap2_gpio_resume_after_retention();
>>  
>> @@ -195,7 +208,7 @@ static int omap2_allow_mpu_retention(void)
>>  
>>  static void omap2_enter_mpu_retention(void)  {
>> -	u32 sleep_time = 0;
>> +	s64 sleep_time = 0;
>>  	int only_idle = 0;
>>  
>>  	/* Putting MPU into the WFI state while a transfer is active @@ 
>> -223,20 +236,24 @@ static void omap2_enter_mpu_retention(void)
>>  	}
>>  
>>  	if (omap2_pm_debug) {
>> +		struct timespec t;
>> +
>>  		omap2_pm_dump(only_idle ? 2 : 1, 0, 0);
>> -		sleep_time = omap2_read_32k_sync_counter();
>> +		getnstimeofday(&t);
>> +		sleep_time = timespec_to_ns(&t);
>>  	}
>>  
>>  	omap2_sram_idle();
>>  
>>  	if (omap2_pm_debug) {
>>  		unsigned long long tmp;
>> -		u32 resume_time;
>> +		s64 resume_time;
>> +		struct timespec t;
>>  
>> -		resume_time = omap2_read_32k_sync_counter();
>> +		getnstimeofday(&t);
>> +		resume_time = timespec_to_ns(&t);
>>  		tmp = resume_time - sleep_time;
>> -		tmp *= 1000000;
>> -		omap2_pm_dump(only_idle ? 2 : 1, 1, tmp / 32768);
>> +		omap2_pm_dump(only_idle ? 2 : 1, 1, tmp / 1000);
>>  	}
>>  }
>>  
>> @@ -252,6 +269,10 @@ static int omap2_can_sleep(void)
>>  		return 0;
>>  	if (omap_dma_running())
>>  		return 0;
>> +#ifdef CONFIG_PM_DEBUG
>> +	if (!omap_serial_can_sleep())
>> +		return 0;
>> +#endif
>>  
>>  	return 1;
>>  }
>> @@ -516,8 +537,6 @@ int __init omap2_pm_init(void)
>>  
>>  	prcm_setup_regs();
>>  
>> -	pm_init_serial_console();
>> -
>>  	/* Hack to prevent MPU retention when STI console is enabled. */
>>  	{
>>  		const struct omap_sti_console_config *sti; diff --git 
>> a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c index 
>> abe5cb4..5b68dae 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -94,6 +94,9 @@ static irqreturn_t prcm_interrupt_handler 
>(int irq, void *dev_id)
>>  	u32 wkst, irqstatus_mpu;
>>  	u32 fclk, iclk;
>>  
>> +	/* Check if we woke up to serial console activity */
>> +	omap_serial_check_wakeup();
>> +
>>  	/* WKUP */
>>  	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
>>  	if (wkst) {
>> @@ -242,8 +245,7 @@ static int omap3_fclks_active(void)
>>  	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
>>  				  CM_FCLKEN);
>>  	gpio_fclk_mask(&fck_per);
>> -	fck_core1 &= ~(0x3 << 13);
>> -	fck_per &= ~(0x1 << 11);
>> +	omap_serial_fclk_mask(&fck_core1, &fck_per);
>>  	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
>>  	    fck_cam | fck_per | fck_usbhost)
>>  		return 1;
>> @@ -258,6 +260,8 @@ static int omap3_can_sleep(void)
>>  		return 0;
>>  	if (atomic_read(&sleep_block) > 0)
>>  		return 0;
>> +	if (!omap_serial_can_sleep())
>> +		return 0;
>>  	return 1;
>>  }
>>  
>> diff --git a/arch/arm/mach-omap2/serial.c 
>> b/arch/arm/mach-omap2/serial.c index b0fa582..65571f9 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -23,8 +23,47 @@
>>  #include <asm/arch/common.h>
>>  #include <asm/arch/board.h>
>>  
>> +#include "prm.h"
>> +#include "pm.h"
>> +
>> +#define SERIAL_AWAKE_TIME 5
>> +
>>  static struct clk *uart_ick[OMAP_MAX_NR_PORTS];  static struct clk 
>> *uart_fck[OMAP_MAX_NR_PORTS];
>> +static s64 omap_serial_next_sleep;
>> +
>> +static const u32 omap2_uart_wk_st[OMAP_MAX_NR_PORTS] = {
>> +	PM_WKST1, PM_WKST1, OMAP24XX_PM_WKST2 }; static const u32 
>> +omap2_uart_wk_en[OMAP_MAX_NR_PORTS] = {
>> +	PM_WKEN1, PM_WKEN1, OMAP24XX_PM_WKEN2 }; const u32 
>> +omap2_uart_wk_bit[OMAP_MAX_NR_PORTS] = {
>> +	OMAP24XX_ST_UART1, OMAP24XX_ST_UART2, OMAP24XX_ST_UART3 };
>> +
>> +#if defined(CONFIG_ARCH_OMAP2)
>> +static const u32 omap_uart_fclk_mask[OMAP_MAX_NR_PORTS] = {
>> +	OMAP24XX_EN_UART1, OMAP24XX_EN_UART2, OMAP24XX_EN_UART3 
>}; #endif
>> +
>> +#if defined(CONFIG_ARCH_OMAP3)
>> +static const u32 omap_uart_fclk_mask[OMAP_MAX_NR_PORTS] = {
>> +	OMAP3430_EN_UART1, OMAP3430_EN_UART2, OMAP3430_EN_UART3 };
>> +
>> +/* UART padconfig registers, these may differ if 
>non-default padconfig
>> +   is used */
>> +#define CONTROL_PADCONF_UART1_RX 0x48002182 #define 
>> +CONTROL_PADCONF_UART2_RX 0x4800217A #define 
>CONTROL_PADCONF_UART3_RX 
>> +0x4800219E #define PADCONF_WAKEUP_ST 0x8000
>> +
>> +static const u32 omap_uart_padconf[OMAP_MAX_NR_PORTS] = {
>> +	CONTROL_PADCONF_UART1_RX, CONTROL_PADCONF_UART2_RX, 
>> +CONTROL_PADCONF_UART3_RX }; #endif
>>  
>>  static struct plat_serial8250_port serial_platform_data[] = {
>>  	{
>> @@ -83,6 +122,15 @@ static inline void __init 
>omap_serial_reset(struct plat_serial8250_port *p)
>>  	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 
>2) | (1 << 
>> 0));  }
>>  
>> +static void omap_serial_kick(void)
>> +{
>> +	struct timespec t;
>> +
>> +	getnstimeofday(&t);
>> +	omap_serial_next_sleep = timespec_to_ns(&t) +
>> +		(s64)SERIAL_AWAKE_TIME * (s64)1000000000; }
>> +
>>  void omap_serial_enable_clocks(int enable)  {
>>  	int i;
>> @@ -99,6 +147,71 @@ void omap_serial_enable_clocks(int enable)
>>  	}
>>  }
>>  
>> +void omap_serial_fclk_mask(u32 *f1, u32 *f2) {
>> +	if (uart_ick[0])
>> +		*f1 &= ~omap_uart_fclk_mask[0];
>> +	if (uart_ick[1])
>> +		*f1 &= ~omap_uart_fclk_mask[1];
>> +	if (uart_ick[2])
>> +		*f2 &= ~omap_uart_fclk_mask[2];
>> +}
>> +
>> +void omap_serial_check_wakeup(void)
>> +{
>> +	int i;
>> +
>> +	if (cpu_is_omap34xx())
>> +		for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
>> +			if (!uart_ick[i])
>> +				continue;
>> +			if (omap_readw(omap_uart_padconf[i]) & 
>PADCONF_WAKEUP_ST)
>> +				omap_serial_kick();
>> +				return;
>> +		}
>> +
>> +	if (cpu_is_omap24xx()) {
>> +		u32 l;
>> +
>> +		for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
>> +			if (!uart_ick[i])
>> +				continue;
>> +			l = prm_read_mod_reg(CORE_MOD, 
>omap2_uart_wk_st[i]);
>> +			if (l & omap2_uart_wk_bit[i])
>> +				omap_serial_kick();
>> +				return;
>> +		}
>> +	}
>> +}
>> +
>> +int omap_serial_can_sleep(void)
>> +{
>> +	s64 cnt;
>> +	int i;
>> +	struct timespec t;
>> +
>> +	struct plat_serial8250_port *p = serial_platform_data;
>> +
>> +	getnstimeofday(&t);
>> +	cnt = timespec_to_ns(&t);
>> +
>> +	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
>> +		if (!uart_ick[i])
>> +			continue;
>> +		/* Check if we have data in the transmit buffer */
>> +		if ((serial_read_reg(p + i, UART_LSR) & 
>(UART_LSR_TEMT|UART_LSR_THRE))
>> +			!= (UART_LSR_TEMT|UART_LSR_THRE)) {
>> +				omap_serial_kick();
>> +				return 0;
>> +		}
>> +	}
>> +
>> +	if (omap_serial_next_sleep - cnt >= 0)
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>>  void __init omap_serial_init(void)
>>  {
>>  	int i;
>> @@ -142,7 +255,12 @@ void __init omap_serial_init(void)
>>  			clk_enable(uart_fck[i]);
>>  
>>  		omap_serial_reset(p);
>> +
>> +		if (cpu_is_omap24xx())
>> +			
>prm_set_mod_reg_bits(omap2_uart_wk_bit[i], CORE_MOD, 
>> +omap2_uart_wk_en[i]);
>>  	}
>> +
>> +	omap_serial_kick();
>>  }
>>  
>>  static struct platform_device serial_device = { diff --git 
>> a/include/asm-arm/arch-omap/common.h 
>> b/include/asm-arm/arch-omap/common.h
>> index 6c072de..68894f9 100644
>> --- a/include/asm-arm/arch-omap/common.h
>> +++ b/include/asm-arm/arch-omap/common.h
>> @@ -35,6 +35,9 @@ extern void omap_map_common_io(void);  
>extern struct 
>> sys_timer omap_timer;  extern void omap_serial_init(void);  extern 
>> void omap_serial_enable_clocks(int enable);
>> +extern int omap_serial_can_sleep(void); extern void 
>> +omap_serial_fclk_mask(u32 *f1, u32 *f2); void 
>> +omap_serial_check_wakeup(void);
>>  #ifdef CONFIG_I2C_OMAP
>>  extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
>>  				 struct i2c_board_info const *info,
>> --
>> 1.5.4.3
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>
