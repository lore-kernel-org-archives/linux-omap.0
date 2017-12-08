From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v4 4/8] arm: OMAP: Move dmtimer driver out of plat-omap to
 drivers under clocksource
Date: Fri, 8 Dec 2017 09:25:35 +0530
Message-ID: <996847a8-d927-638b-3eee-de496d21fe65@ti.com>
References: <1512105397-2544-1-git-send-email-j-keerthy@ti.com>
 <1512105397-2544-5-git-send-email-j-keerthy@ti.com>
 <e71f4c7b-e5c7-6305-dc1c-274da6fbf07d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e71f4c7b-e5c7-6305-dc1c-274da6fbf07d@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, grygorii.strashko@ti.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, ladis@linux-mips.org, sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Thursday 07 December 2017 04:24 PM, Daniel Lezcano wrote:
> On 01/12/2017 06:16, Keerthy wrote:
>> Move the dmtimer driver out of plat-omap to clocksource.
>> So that non-omap devices also could use this.
>>
>> No Code changes done to the driver file.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> ---
>>
>> Changes in v3:
>>
>>   * Added Sebastian's Reviewed-by.
>>
>> Changes in v2:
>>
>>   * No code changes in this v2 version. Only enhanced patch
>>     statistics for renames.
>>
>>  arch/arm/plat-omap/Kconfig                            | 6 ------
>>  arch/arm/plat-omap/Makefile                           | 1 -
>>  drivers/clocksource/Kconfig                           | 6 ++++++
>>  drivers/clocksource/Makefile                          | 1 +
>>  {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c | 0
>>  5 files changed, 7 insertions(+), 7 deletions(-)
>>  rename {arch/arm/plat-omap => drivers/clocksource}/dmtimer.c (100%)
> 
> Take the opportunity to rename it timer-dm.c

okay.

> 
>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>> index 7276afe..afc1a1d 100644
>> --- a/arch/arm/plat-omap/Kconfig
>> +++ b/arch/arm/plat-omap/Kconfig
>> @@ -106,12 +106,6 @@ config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
>>  	help
>>  	  PPA routine service ID for setting L2 auxiliary control register.
>>  
>> -config OMAP_DM_TIMER
>> -	bool "Use dual-mode timer"
>> -	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
>> -	help
>> -	 Select this option if you want to use OMAP Dual-Mode timers.
>> -
>>  config OMAP_SERIAL_WAKE
>>  	bool "Enable wake-up events for serial ports"
>>  	depends on ARCH_OMAP1 && OMAP_MUX
>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
>> index 47e1867..7215ada 100644
>> --- a/arch/arm/plat-omap/Makefile
>> +++ b/arch/arm/plat-omap/Makefile
>> @@ -9,5 +9,4 @@ obj-y := sram.o dma.o counter_32k.o
>>  
>>  # omap_device support (OMAP2+ only at the moment)
>>  
>> -obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
>>  obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index c729a88..4da66cf 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -46,6 +46,12 @@ config DIGICOLOR_TIMER
>>  	help
>>  	  Enables the support for the digicolor timer driver.
>>  
>> +config OMAP_DM_TIMER
>> +	bool "Use dual-mode timer"
>> +	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
>> +	help
>> +	 Select this option if you want to use Dual-Mode timers.
>> +
> 
> So in the clocksource directory the rule is the following:
> 
> The config option is silent except if COMPILE_TEST is set.
> 
> It is the Kconfig's platform which select the driver so there is no deps
> on the ARCH.

Okay understood.

> 
> config OMAP_DM_TIMER
> 	bool "Use dual-mode timer" if COMPILE_TEST
> 	help
> 	 Select this option if you want to use Dual-Mode timers.
> 
> Here you will have to make sure the driver compiles on x86.

Okay. I will check that in my next version.

Thanks for reviewing!

> 
>>  config DW_APB_TIMER
>>  	bool "DW APB timer driver" if COMPILE_TEST
>>  	help
>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>> index 72711f1..b077076 100644
>> --- a/drivers/clocksource/Makefile
>> +++ b/drivers/clocksource/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
>>  obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
>>  obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
>>  obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
>> +obj-$(CONFIG_OMAP_DM_TIMER)	+= dmtimer.o
>>  obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
>>  obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
>>  obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/drivers/clocksource/dmtimer.c
>> similarity index 100%
>> rename from arch/arm/plat-omap/dmtimer.c
>> rename to drivers/clocksource/dmtimer.c
>>
> 
> 
