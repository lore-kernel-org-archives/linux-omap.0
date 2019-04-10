From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: gpio-omap: take pm_runtime usage while IRQs are
 claimed
Date: Wed, 10 Apr 2019 12:38:04 -0700
Message-ID: <20190410193804.GM2839@atomide.com>
References: <20190408194506.25821-1-tony@atomide.com>
 <f32435a8-7b1d-30f6-83d5-2d0ccec5c173@ti.com>
 <4915fcdd-fb07-28c4-e530-d2559b8518ad@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4915fcdd-fb07-28c4-e530-d2559b8518ad@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [190410 18:17]:
> I'm very sorry, but what was the regression exactly?
> Can't enter RTC+DDR state? some crash?

AFAIK fails to enter RTC+DDR suspend because of conditional
PM runtime handling.

> We have in driver:
>  irqc->parent_device = dev;
> 
> which means:
>  request_threaded_irq()
>    irq_chip_pm_get()
> 	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device) {
> 		retval = pm_runtime_get_sync(data->chip->parent_device);
> 
> and power.usage_count will be incremented every time GPIO irq is requested.
> 
> only in free_irq() (or in case of error) power.usage_count is decremented.
> 
> Now above change will introduce just another incrementation of power.usage_count
> How is it helping?

Oh OK, that means we can simplify things further and drop those
changes then. I'll post v2 version shortly with updated subject
and description.

Regards,

Tony
