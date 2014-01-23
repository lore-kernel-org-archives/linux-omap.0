From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions
 void
Date: Thu, 23 Jan 2014 20:45:13 +1300
Message-ID: <52E0C889.6000106@prisktech.co.nz>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Yijing Wang <wangyijing@huawei.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Daniel Lezcano <dan>
List-Id: linux-omap@vger.kernel.org

On 23/01/14 20:12, Yijing Wang wrote:
> Currently, clocksource_register() and __clocksource_register_scale()
> functions always return 0, it's pointless, make functions void.
> And remove the dead code that check the clocksource_register_hz()
> return value.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
......
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 67301a4..5a17c5e 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -282,7 +282,7 @@ static inline s64 clocksource_cyc2ns(cycle_t cycles, u32 mult, u32 shift)
>   }
>   
>   
> -extern int clocksource_register(struct clocksource*);
> +extern void clocksource_register(struct clocksource *);
>   extern int clocksource_unregister(struct clocksource*);
>   extern void clocksource_touch_watchdog(void);
>   extern struct clocksource* clocksource_get_next(void);
> @@ -301,17 +301,17 @@ clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 minsec);
>    * Don't call __clocksource_register_scale directly, use
>    * clocksource_register_hz/khz
>    */
> -extern int
> +extern void
>   __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq);
>   extern void
>   __clocksource_updatefreq_scale(struct clocksource *cs, u32 scale, u32 freq);
>   
> -static inline int clocksource_register_hz(struct clocksource *cs, u32 hz)
> +static inline void clocksource_register_hz(struct clocksource *cs, u32 hz)
>   {
>   	return __clocksource_register_scale(cs, 1, hz);
>   }

This doesn't make sense - you are still returning a value on a function 
declared void, and the return is now from a function that doesn't return 
anything either ?!?!
Doesn't this throw a compile-time warning??

Regards
Tony Prisk
