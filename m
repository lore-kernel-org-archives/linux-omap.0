From: David Rivshin <drivshin@awxrd.com>
Subject: Re: [PATCH 2/2] gpio: omap: compute debounce-time from actual
 debounce-clock rate
Date: Thu, 20 Apr 2017 09:53:41 -0400
Message-ID: <20170420095341.6c919e40.drivshin@awxrd.com>
References: <20170317005704.11971-1-drivshin@awxrd.com>
 <20170317005704.11971-3-drivshin@awxrd.com>
 <adc98bfd-ebce-49f0-5991-3c6a1e99ec25@ti.com>
 <20170317191419.021bdd84.drivshin@awxrd.com>
 <5d0fab0d-bc9d-5148-063c-8bfe9e26f9a5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d0fab0d-bc9d-5148-063c-8bfe9e26f9a5@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 17 Mar 2017 19:06:47 -0500
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

> CC: Tero
 
Gentle ping. Any thoughts on this? Is there anything I should 
investigate, or other information you'd like me to provide?

> On 03/17/2017 06:14 PM, David Rivshin wrote:
> > On Fri, 17 Mar 2017 14:43:02 -0500
> > Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> >  
> >> On 03/16/2017 07:57 PM, David Rivshin wrote:  
> >>> From: David Rivshin <DRivshin@allworx.com>
> >>>
> >>> omap2_set_gpio_debounce() assumes the debounce clock runs at 32768Hz,
> >>> leading to 31us granularity. In reality the debounce clock (which
> >>> is provided by other modules) could be at different rate, leading to
> >>> an incorrect computation of the number of debounce clock cycles for
> >>> GPIO_DEBOUNCINGTIME[DEBOUNCETIME].
> >>>
> >>> Also, even with a standard 32768Hz input clock, the actual granularity
> >>> is ~30.5us. This leads to the actual debounce time being ~1.5% too
> >>> short.
> >>>
> >>> Fix both issues by simply querying the dbck rate, rather than
> >>> hardcoding.  
> >>
> >> Pls, hold on with this - I'm trying to check it, as it doesn't follow TRMs.  
> >
> > Yes, the TRMs are somewhat cryptic about the details, perhaps I can give
> > some more background on how I came to this. I think the chapters for the
> > GPIO block are written with a strong assumption that the input debounce
> > clock is 32768Hz, and further round 1/32768Hz to the nearest whole
> > microsecond (~30.5us->31us).
> >
> > However, at least on AM335x the debounce clock (i.e. the CLK_32KHZ) can
> > be made to run at other rates via the Control Module.
> >
> > Here is an example from clk_summary:
> >  clk_24mhz                    1            1    24000000          0 0
> >     clkdiv32k_ck              1            1       65536          0 0
> >        clkdiv32k_ick          2            6       65536          0 0
> >           timer7_fck          1            1       65536          0 0
> >           wdt1_fck            0            1       65536          0 0
> >           gpio3_dbclk         0            2       65536          0 0
> >           gpio2_dbclk         0            2       65536          0 0
> >           gpio1_dbclk         0            2       65536          0 0
> >
> > This is accomplished by setting clk32kdivratio_ctl[clkdivopp50_en] to 1
> > even while in OPP100, and adjusting the devicetree to match. Timer7 is
> > known to truly have a 65536Hz fck by configuring it as a 50% duty cycle
> > PWM and measuring with an oscilloscope.
> >
> > Here are some relevant sections from the AM335x TRM (spruh73o):
> >   25.2.2 GPIO Clock and Reset Management
> >     Debounce Functional clock (GPIO[123]) comes from CLK_32KHZ.
> >   8.1.6.8 Peripheral PLL Description
> >     CLK_32KHZ is CLK_24 divided by either 732.4219 or 366.2109.
> >     In OPP100 this results in either 32768Hz or 65536Hz.
> >     In OPP50 this results in either 16384Hz or 32768Hz.
> >   9.3.1.8 clk32kdivratio_ctrl Register
> >     Names of the register and field differ from 8.1.6.8, but it's
> >      clear they are the same.
> >
> > I'm not sure if other devices can be similarly cajoled into running
> > their equivalent 32KHZ clocks at a different rate, but it certainly
> > works for AM335x. Checking OMAP4430 TRM as an example makes it look
> > like OMAP44xx has a fixed 32768Hz clock with no adjustment possible
> > (backed up by omap44xx-clocks.dtsi having it just be a fixed-clock).
> >
> >  
> >>>
> >>> Fixes: e85ec6c3047b ("gpio: omap: fix omap2_set_gpio_debounce")
> >>> Cc: <stable@vger.kernel.org> # 4.3+
> >>> Signed-off-by: David Rivshin <drivshin@allworx.com>
> >>> ---
> >>>
> >>> This logical bug existed before e85ec6c3047b, but if backporting
> >>> further it's probably best to just cherry-pick/backport e85ec6c3047b
> >>> first.
> >>>
> >>>  drivers/gpio/gpio-omap.c | 8 +++++---
> >>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> >>> index 33ec02d..865a831 100644
> >>> --- a/drivers/gpio/gpio-omap.c
> >>> +++ b/drivers/gpio/gpio-omap.c
> >>> @@ -205,8 +205,8 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
> >>>   * @offset: the gpio number on this @bank
> >>>   * @debounce: debounce time to use
> >>>   *
> >>> - * OMAP's debounce time is in 31us steps
> >>> - *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) x 31
> >>> + * OMAP's debounce time is in 1/DBCK steps
> >>> + *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) / DBCK
> >>>   * so we need to convert and round up to the closest unit.
> >>>   *
> >>>   * Return: 0 on success, negative error otherwise.
> >>> @@ -223,7 +223,9 @@ static int omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
> >>>  		return -ENOTSUPP;
> >>>
> >>>  	if (enable) {
> >>> -		debounce = DIV_ROUND_UP(debounce, 31) - 1;
> >>> +		u64 tmp = (u64)debounce * clk_get_rate(bank->dbck);
> >>> +
> >>> +		debounce = DIV_ROUND_UP_ULL(tmp, 1000000) - 1;
> >>>  		if ((debounce & OMAP4_GPIO_DEBOUNCINGTIME_MASK) != debounce)
> >>>  			return -EINVAL;
> >>>  	}
> >>>  
> >>  
> >  
> 
