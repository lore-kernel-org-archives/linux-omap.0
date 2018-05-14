From: Greg Ungerer <gerg@uclinux.org>
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Date: Tue, 15 May 2018 09:03:08 +1000
Message-ID: <40bb677a-e6e1-7906-28fe-9e74cdfbefd7@uclinux.org>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
 <20180514213719.o6ceftp2quem3s7f@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180514213719.o6ceftp2quem3s7f@ninjato>
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
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, James Hogan <jhogan@kernel.org>, Sergey Lapin <slapin@ossfans.org>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Lee Jones <lee.jones@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-omap@vger.kernel.org


Hi Wolfram,

On 15/05/18 07:37, Wolfram Sang wrote:
>>   arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>>   arch/arm/mach-sa1100/simpad.c                    | 2 +-
>>   arch/mips/alchemy/board-gpr.c                    | 2 +-
> 
> Those still need acks...
> 
>> diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
>> index 937eb1d47e7b..ef835d82cdb9 100644
>> --- a/arch/arm/mach-ks8695/board-acs5k.c
>> +++ b/arch/arm/mach-ks8695/board-acs5k.c
>> @@ -19,7 +19,7 @@
>>   #include <linux/gpio/machine.h>
>>   #include <linux/i2c.h>
>>   #include <linux/i2c-algo-bit.h>
>> -#include <linux/i2c-gpio.h>
>> +#include <linux/platform_data/i2c-gpio.h>
>>   #include <linux/platform_data/pca953x.h>
>>   
>>   #include <linux/mtd/mtd.h>
> 
> ...
> 
>> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
>> index ace010479eb6..49a61e6f3c5f 100644
>> --- a/arch/arm/mach-sa1100/simpad.c
>> +++ b/arch/arm/mach-sa1100/simpad.c
>> @@ -37,7 +37,7 @@
>>   #include <linux/input.h>
>>   #include <linux/gpio_keys.h>
>>   #include <linux/leds.h>
>> -#include <linux/i2c-gpio.h>
>> +#include <linux/platform_data/i2c-gpio.h>
>>   
>>   #include "generic.h"
>>   
>> diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
>> index 4e79dbd54a33..fa75d75b5ba9 100644
>> --- a/arch/mips/alchemy/board-gpr.c
>> +++ b/arch/mips/alchemy/board-gpr.c
>> @@ -29,7 +29,7 @@
>>   #include <linux/leds.h>
>>   #include <linux/gpio.h>
>>   #include <linux/i2c.h>
>> -#include <linux/i2c-gpio.h>
>> +#include <linux/platform_data/i2c-gpio.h>
>>   #include <linux/gpio/machine.h>
>>   #include <asm/bootinfo.h>
>>   #include <asm/idle.h>
> 
> ... and this was the shortened diff for those.
> 
> Greg, Russell, Ralf, James? Is it okay if I take this via my tree?

Yes, I have no problem with that for the ks8695 part.

Acked-by: Greg Ungerer <gerg@uclinux.org>

Thanks
Greg


> Thanks,
> 
>     Wolfram
> 
