From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2 07/14] genirq: Add runtime power management support for
 IRQ chips
Date: Thu, 21 Apr 2016 10:19:05 +0100
Message-ID: <57189B09.4030402@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-8-git-send-email-jonathanh@nvidia.com>
 <7h37qgb3xi.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7h37qgb3xi.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 20/04/16 18:11, Kevin Hilman wrote:
> Jon Hunter <jonathanh@nvidia.com> writes:
> 
>> Some IRQ chips may be located in a power domain outside of the CPU
>> subsystem and hence will require device specific runtime power
>> management. In order to support such IRQ chips, add a pointer for a
>> device structure to the irq_chip structure, and if this pointer is
>> populated by the IRQ chip driver and CONFIG_PM is selected in the kernel
>> configuration, then the pm_runtime_get/put APIs for this chip will be
>> called when an IRQ is requested/freed, respectively.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> [...]
> 
>> @@ -1891,10 +1906,18 @@ int setup_percpu_irq(unsigned int irq, struct irqaction *act)
>>  
>>  	if (!desc || !irq_settings_is_per_cpu_devid(desc))
>>  		return -EINVAL;
>> +
>> +	retval = irq_chip_pm_get(&desc->irq_data);
>> +	if (retval < 0)
>> +		return retval;
>> +
>>  	chip_bus_lock(desc);
>>  	retval = __setup_irq(irq, desc, act);
>>  	chip_bus_sync_unlock(desc);
>>  
>> +	if (retval)
>> +		irq_chip_pm_get(&desc->irq_data);
>> +
> 
> Shouldn't this one be a _put() ?

Good grief! Yes it should. Sorry, will fix :-(

> Otherwise, LGTM
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Thanks!
Jon
