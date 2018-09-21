From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/3] gpio: omap: Remove custom PM calls and use cpu_pm
 instead
Date: Thu, 20 Sep 2018 19:58:00 -0500
Message-ID: <9fa04a22-0908-b35f-1819-dce4058df155@ti.com>
References: <20180920193532.7714-1-tony@atomide.com>
 <20180920193532.7714-3-tony@atomide.com>
 <35a1dccf-2b15-2d61-9210-7f3893c27795@ti.com>
 <20180920234756.GC5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920234756.GC5662@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Ladislav Michl <ladis@linux-mips.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 09/20/2018 06:47 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [180920 23:05]:
>> On 09/20/2018 02:35 PM, Tony Lindgren wrote:
>>> +static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
>>> +{
>>> +	struct platform_device *pdev = to_platform_device(dev);
>>> +	struct gpio_bank *bank = platform_get_drvdata(pdev);
>>> +	unsigned long flags;
>>> +	int error = 0;
>>> +
>>> +	raw_spin_lock_irqsave(&bank->lock, flags);
>>> +	/* Must be idled only by CPU_CLUSTER_PM_ENTER? */
>>> +	if (bank->irq_usage) {
>>> +		error = -EBUSY;
>>
>> Sry, I didn't get how will it work with suspend to ram?
>> omap_device will call this handler and, seems, abort suspend always
>> if gpio bank has gpios requested as IRQ. Am I missing smth?
> 
> Heh yeah we have _od_suspend_noirq() call pm_generic_suspend_noirq()
> which will succeed. But note how after that omap_device_idle() gets
> called only if pm_generic_runtime_suspend() == 0 and we still allow
> supend with no error.

Ah, sry, You are right - ret not updated in this case

> 
> So for gpio interrupts there's nothing that needs to be done at that
> point and the cpu_pm notifier will take care of things just before
> suspend.

So, just to summarize:
- gpio requested (incl irq) - is_suspended = true: no actions

- no gpio irqs requested - is_suspended = false: idle->omap_gpio_idle/unidle
  suspend->omap_gpio_runtime_suspend/resume

- gpio irqs requested - is_suspended = false: idle->omap_gpio_idle/unidle
  suspend->omap_gpio_idle/unidle
   

> 
> Do you have any better ideas?

No. It's looks good - thanks, but i'd like to try it, so will get back.


-- 
regards,
-grygorii
