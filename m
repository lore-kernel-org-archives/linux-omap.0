From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2 14/14] irqchip/gic: Add support for tegra AGIC
 interrupt controller
Date: Fri, 22 Apr 2016 11:21:35 +0100
Message-ID: <5719FB2F.10708@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-15-git-send-email-jonathanh@nvidia.com>
 <5719F5A1.6060301@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5719F5A1.6060301@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 22/04/16 10:57, Marc Zyngier wrote:
> On 20/04/16 12:03, Jon Hunter wrote:
>> Add a driver for the Tegra-AGIC interrupt controller which is compatible
>> with the ARM GIC-400 interrupt controller.
>>
>> The Tegra AGIC (Audio GIC) is part of the Audio Processing Engine (APE) on
>> Tegra210 and can route interrupts to either the GIC for the CPU subsystem
>> or the Audio DSP (ADSP) within the APE. The AGIC uses CPU interface 0 to
>> route interrupts to the CPU GIC and CPU interface 1 to route interrupts to
>> the ADSP.
>>
>> The APE is located within its own power domain on the chip and so the
>> AGIC needs to manage both the power domain and its clocks. Commit
>> afbbd2338176 ("irqchip/gic: Document optional Clock and Power Domain
>> properties") has already added clock and power-domain properties to the
>> GIC binding and so we can make use of these for the AGIC.
>>
>> With the AGIC being located in a different power domain to the main CPU
>> cluster this means that:
>> 1. The interrupt controller cannot be registered via IRQCHIP_DECLARE()
>>    because it needs to be registered as a platform device so that the
>>    generic PM domain core will ensure that the power domain is available
>>    before probing.
>> 2. The interrupt controller cannot be suspended/restored based upon
>>    changes in the CPU power state and needs to use runtime-pm instead.
>>
>> The GIC platform driver has been implemented by making the following
>> changes to the core GIC driver:
>> 1. Remove the dependency on CONFIG_CPU_PM from PM specific variables and
>>    functions so that they can be used by the platform driver even when
>>    CONFIG_CPU_PM is not selected.
>> 2. Move the code that maps the GIC registers and parses the device-tree
>>    blob into a new function called gic_of_setup() that can be used by
>>    both the platform driver as well as the existing driver.
>> 3. Add and register platform driver for the GIC. The platform driver
>>    uses the PM_CLK framework for managing the clocks used by the GIC
>>    and so select CONFIG_PM_CLK.
>>
>> Finally, a couple other notes on the implementation are:
>> 1. Currently the GIC platform driver only supports non-root GICs and
>>    assumes that the GIC has a parent interrupt. It is assumed that
>>    root interrupt controllers need to be initialised early.
>> 2. There is no specific suspend handling for GICs registered as platform
>>    devices. Non-wakeup interrupts will be disabled by the kernel during
>>    late suspend, however, this alone will not power down the GIC if
>>    interrupts have been requested and not freed. Therefore, requestors
>>    of non-wakeup interrupts will need to free them on entering suspend
>>    in order to power-down the GIC.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>
>> Please note that so far I have not added all the clock names for the
>> various GIC versions (as described by the DT documentation). I thought
>> we could add these as they are needed.
> 
> So while the code looks OK, I'd like to stop adding more code to this
> poor GIC driver, because it is starting to look like a huge mess.

Agree.

> What is preventing us to move this to a separate irq-gic-pm.c file?

Absolutely nothing. Once we sort out the clocking, I will do that.

Cheers
Jon
