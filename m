From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions
 void
Date: Thu, 23 Jan 2014 21:04:40 +1300
Message-ID: <52E0CD18.5080104@prisktech.co.nz>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>   <52E0C889.6000106@prisktech.co.nz> <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yijing Wang <wangyijing@huawei.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux <linux@lists.openrisc.net>, Sekhar Nori <nsekhar@ti.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, the arch/x86 maintainers <x86@kernel.org>, Tony Lindgren <tony@atomide.com>, Ingo
List-Id: linux-omap@vger.kernel.org

On 23/01/14 20:58, Geert Uytterhoeven wrote:
> On Thu, Jan 23, 2014 at 8:45 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>>    -static inline int clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>> +static inline void clocksource_register_hz(struct clocksource *cs, u32
>>> hz)
>>>    {
>>>          return __clocksource_register_scale(cs, 1, hz);
>>>    }
>>
>> This doesn't make sense - you are still returning a value on a function
>> declared void, and the return is now from a function that doesn't return
>> anything either ?!?!
>> Doesn't this throw a compile-time warning??
> No, passing on void in functions returning void doesn't cause compiler
> warnings.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
Doesn't seem right to me (even if there is no warning) but that's 
probably because I used to program in Pascal where functions with no 
return were 'procedures' :)
Whether it needs to be changed or not:

For the vt8500 part -
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony Prisk
