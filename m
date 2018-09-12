From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
Date: Tue, 11 Sep 2018 19:29:13 -0500
Message-ID: <01f5b04a-82ed-fafe-5b90-3e662f21d0db@ti.com>
References: <20180911183729.17110-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180911183729.17110-1-tony@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 09/11/2018 01:37 PM, Tony Lindgren wrote:
> For a long time the gpio-omap custom PM calls have been annoying me so
> let's replace them with cpu_pm instead. This will enable GPIO PM for
> deeper idle states on omap4. And we can handle GPIO PM for omap2/3/4
> in the same way.
> 
> Note that with this patch we are also slightly changing GPIO PM to be
> less aggressive for omap3 and only will idle GPIO when PER context
> may be lost.
> 
> For omap2, we don't need to save context and don't want to remove any
> triggering so let's add a quirk flag for that.
> 
> Let's do this all in a single patch to avoid a situation where old
> custom calls still are used with new code.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Ladislav Michl <ladis@linux-mips.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Note that this depends on previously posted patch:
> 
> [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
> 
> Linus, once people are happy with these, can you maybe set up an
> immutable branch with both patches in it?
> 

[...]

>   }
>   
> +static int gpio_omap_cpu_notifier(struct notifier_block *nb,
> +				  unsigned long cmd, void *v)
> +{
> +	struct gpio_bank *bank;
> +	struct device *dev;
> +	int error;
> +
> +	bank = container_of(nb, struct gpio_bank, nb);
> +	dev = bank->chip.parent;
> +
> +	switch (cmd) {
> +	case CPU_CLUSTER_PM_ENTER:
> +		/* Gets cleard on runtime_suspend */
> +		bank->power_mode = OFF_MODE;

It has to be reset somewhere.

> +
> +		error = pm_runtime_put_sync(dev);
> +		if (error < 0)
> +			dev_warn(dev, "CPU PM enter: %i\n", error);
> +		break;
> +	case CPU_CLUSTER_PM_ENTER_FAILED:
> +	case CPU_CLUSTER_PM_EXIT:
> +		error = pm_runtime_get_sync(dev);
> +		if (error < 0) {
> +			dev_err(dev, "CPU PM exit %i\n", error);
> +			pm_runtime_put_noidle(dev);
> +		}
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
[...]


-- 
regards,
-grygorii
