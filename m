From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: [PATCH] OMAP3EVM: Update pad configuration for wakeup enabled
 pads
Date: Thu, 29 Apr 2010 16:42:24 +0530
Message-ID: <4BD96998.9090902@ti.com>
References: <1272369361-25147-1-git-send-email-ranjithl@ti.com>	<87fx2hq61m.fsf@deeprootsystems.com> <4BD7FF39.8080607@ti.com> <87y6g7e8s2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58981 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab0D3REV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 13:04:21 -0400
In-Reply-To: <87y6g7e8s2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>



On Wed, 28-Apr-10 11:53 PM +0530, Kevin Hilman wrote:
> Ranjith Lohithakshan <ranjithl@ti.com> writes:
> 
>> Kevin,
>>
>> On Tue, 27-Apr-10 8:46 PM +0530, Kevin Hilman wrote:
>>> Ranjith Lohithakshan <ranjithl@ti.com> writes:
>>>
>>>> OMAP3530 TRM section 7.4.4.4.2 requires OFFOUTENABLE to be set (active low)
>>>> if wakeup capabilities are enabled on a pad. During OFF mode testing
>>>> on OMAP3530 EVM, it was observed that the device was not residing in
>>>> the OFF state. The device enters into the OFF state and immediately exits
>>>> from that state as if an IO wakeup event has occured. The issue was traced
>>>> down to the pad configuration of wkaeup enabled pad's.
>>> Nice.
>>>
>>>> Also, the pad configuration is included only if the respective drivers are
>>>> enabled in the defconfig.
>>> Hmm, do you really want this?  If you don't have the driver enabled,
>>> you have to rely on the bootloader settings of these pads which may
>>> also be wrong and trigger an IO wakeup as well.
>> The thought process was that, for example, if keypad is not enabled
>> in a system configuration you probably don't want to see a wakeup
>> occurring if someone presses a key stroke. I understand the concern
>> that you have raised regarding bootloader mis-configurations. My
>> impression was that the bootloaders typically set the mux modes and
>> pull up's/downs and dont really program or enable the wakeup
>> capability.  But we cannot depend on that thumb rule.
> 
> Unfortunately, Bootloaders don't "typically" do anything.  They are
> routinely hacked/patched and cannot be trusted at all.
> 
>> What is your recommendation?
> 
> First, I suggest you fix the OFFOUTENABLE bug in a single patch
> without introducing the #ifdefs.  Then, address the enable/disable of
> the wakeups in a separate patch.

I will do that.

> Next, ideally wakeups should not be configured a this level of board
> code.  There are APIs for that: enable_irq_wake()/disable_irq_wake()
> 
> For GPIOs (like the touchscreen), you really need to enable wakeups
> using existing APIs, either in the driver or in board init code and be
> sure there is an interrupt handler.  Please see the 'Known Problems'
> section of the OMAP PM wiki[2] where it talks about GPIO wakeups.
> Below[2] is an test patch I've used.

I have pushed a patch on ads7846 to linux-input some time ago adding
wakeup support.

fdba2bb : Input: ads7846 - add wakeup support

There is now a wakeup flag added to the ads7846 platform data which can
enabled at the board level. Once this is set , the driver will do an
enable_irq_wake. The patch is now accepted and in mainline. I will
remove the wakeup mux configuration from the board file and instead will
just set the wakeup flag in the ads7846 platform data.

The keypad uses a pin in the non-gpio mode. Is enable_irq_wake supported
for non-gpio mode?

> For MPU IRQs, the IRQ wake APIs don't quite work as expected.  You
> can look at board-3430sdp.c to see how wakeups are enabled there.  
> If you want to make that conditional on the T2 driver being installed,
> it could be part of the T2 init process.
> 

Thanks for the pointers.

> 
> [1] http://elinux.org/OMAP_Power_Management#Known_Problems
> 
> [2]
> commit a12a1b43c75795fa106d1222730591354209c037
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Wed Sep 9 11:58:20 2009 -0700
> 
>     OMAP3: PM: Enable touchscreen GPIO wakeups on SDP and omap3evm
>     
>     For the GPIO wakeup to work, the GPIO IRQ must be configured as a
>     wakeup IRQ.
>     
>     In addition, a corresponding interrupt handler must be used and enabled
>     so that after coming out of idle/suspend the interrupt will be cleared.
>     Otherwise, a pending GPIO IRQ will prevent future idle request. (c.f.
>     GPIO 'Interrupt and Wakeup' section of the TRM, specifically the
>     subsection 'Involved Configuration Registers'.)
>     
>     Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index c1742d0..96f921e 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -24,6 +24,8 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -140,6 +142,11 @@ static struct twl4030_keypad_data sdp3430_kp_data = {
>  
>  static int ts_gpio;	/* Needed for ads7846_get_pendown_state */
>  
> +static irqreturn_t dummy_interrupt_handler (int irq, void *dev_id)
> +{
> +	return IRQ_HANDLED;
> +}
> +
>  /**
>   * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
>   *
> @@ -147,6 +154,8 @@ static int ts_gpio;	/* Needed for ads7846_get_pendown_state */
>   */
>  static void ads7846_dev_init(void)
>  {
> +	int ret;
> +
>  	if (gpio_request(ts_gpio, "ADS7846 pendown") < 0) {
>  		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
>  		return;
> @@ -156,6 +165,12 @@ static void ads7846_dev_init(void)
>  
>  	omap_set_gpio_debounce(ts_gpio, 1);
>  	omap_set_gpio_debounce_time(ts_gpio, 0xa);
> +
> +	ret = request_irq(gpio_to_irq(ts_gpio),
> +			  (irq_handler_t)dummy_interrupt_handler,
> +			  IRQF_TRIGGER_FALLING,
> +			  "ads7846-dummy", NULL);
> +	enable_irq_wake(gpio_to_irq(ts_gpio));
>  }
>  
>  static int ads7846_get_pendown_state(void)
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 9ac1eb2..1647440 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -574,8 +574,15 @@ static int __init omap3_evm_i2c_init(void)
>  	return 0;
>  }
>  
> +static irqreturn_t dummy_interrupt_handler (int irq, void *dev_id)
> +{
> +	return IRQ_HANDLED;
> +}
> +
>  static void ads7846_dev_init(void)
>  {
> +	int ret;
> +
>  	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
>  		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
>  
> @@ -583,6 +590,12 @@ static void ads7846_dev_init(void)
>  
>  	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
>  	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
> +
> +	ret = request_irq(gpio_to_irq(OMAP3_EVM_TS_GPIO),
> +			  (irq_handler_t)dummy_interrupt_handler,
> +			  IRQF_TRIGGER_FALLING,
> +			  "ads7846-dummy", NULL);
> +	enable_irq_wake(gpio_to_irq(OMAP3_EVM_TS_GPIO));
>  }
>  
>  static int ads7846_get_pendown_state(void)
> 
> 
> 
