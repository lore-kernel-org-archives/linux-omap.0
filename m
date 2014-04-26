From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime
 PM with the PM core
Date: Sat, 26 Apr 2014 03:59:40 +0200
Message-ID: <535B130C.1000007@gmail.com>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>	<1398334403-26181-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFr02yyhGNncYX2AgBXTA3Sc0AGQcExjtLvQ5QU0_=YJwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFr02yyhGNncYX2AgBXTA3Sc0AGQcExjtLvQ5QU0_=YJwg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 24.04.2014 15:11, Ulf Hansson wrote:
> On 24 April 2014 12:13, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> When adding a device from DT, check if its clocks are suitable for Runtime
>> PM, and register them with the PM core.
>> If Runtime PM is disabled, just enable the clock.
>>
>> This allows the PM core to automatically manage gate clocks of devices for
>> Runtime PM.
>
> Normally I don't think it's a good idea to "automatically" manage
> clocks from PM core or any other place but from the driver (and
> possibly the subsystem).
>
> The reason is simply that we hide things that normally is supposed to
> be handled by the driver. Typically a cross SOC driver should work
> fine both with and without a pm_domain. It should also not rely on
> CONFIG_PM_RUNTIME.
>
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>   drivers/of/Makefile    |    1 +
>>   drivers/of/of_clk.c    |  103 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/of/platform.c  |    3 ++
>>   include/linux/of_clk.h |   18 +++++++++
>>   4 files changed, 125 insertions(+)
>>   create mode 100644 drivers/of/of_clk.c
>>   create mode 100644 include/linux/of_clk.h
>>
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index ed9660adad77..49bcd413906f 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -10,3 +10,4 @@ obj-$(CONFIG_OF_PCI)  += of_pci.o
>>   obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
>>   obj-$(CONFIG_OF_MTD)   += of_mtd.o
>>   obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>> +obj-$(CONFIG_COMMON_CLK) += of_clk.o
>> diff --git a/drivers/of/of_clk.c b/drivers/of/of_clk.c
>> new file mode 100644
>> index 000000000000..35f5e9f3dd42
>> --- /dev/null
>> +++ b/drivers/of/of_clk.c
>> @@ -0,0 +1,103 @@
>> +/*
>> + *  Copyright (C) 2014 Glider bvba
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/of_clk.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_clock.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +
>> +#ifdef CONFIG_PM_RUNTIME
>> +
>> +static int of_clk_pm_runtime_suspend(struct device *dev)
>> +{
>> +       int ret;
>> +
>> +       ret = pm_generic_runtime_suspend(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pm_clk_suspend(dev);
>> +       if (ret) {
>> +               pm_generic_runtime_resume(dev);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int of_clk_pm_runtime_resume(struct device *dev)
>> +{
>> +       pm_clk_resume(dev);
>> +       return pm_generic_runtime_resume(dev);
>> +}
>> +
>> +static struct dev_pm_domain of_clk_pm_domain = {
>> +       .ops = {
>> +               .runtime_suspend = of_clk_pm_runtime_suspend,
>> +               .runtime_resume = of_clk_pm_runtime_resume,
>> +               USE_PLATFORM_PM_SLEEP_OPS
>> +       },
>> +};
>> +
>> +static int of_clk_register(struct device *dev, struct clk *clk)
>> +{
>> +       int error;
>> +
>> +       if (!dev->pm_domain) {
>> +               error = pm_clk_create(dev);
>> +               if (error)
>> +                       return error;
>> +
>> +               dev->pm_domain = &of_clk_pm_domain;
>
> I am concerned about how this will work in conjunction with the
> generic power domain.
>
> A device can't reside in more than one pm_domain; thus I think it
> would be better to always use the generic power domain and not have a
> specific one for clocks. Typically the genpd should invoke
> pm_clk_resume|suspend from it's runtime PM callbacks.

I'm not sure about this. A typical use case would be to gate clocks ASAP 
and then wait until device is idle long enough to consider turning off 
the power domain worthwhile. Also sometimes we may want to gate the 
clocks, but prevent power domain from being powered off to retain 
hardware state (e.g. because there is no way to read it and restore later).

I believe, though, that for devices that are not inside a controllable 
power domain, this might be a good solution.

Best regards,
Tomasz
