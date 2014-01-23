From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register
	functions void
Date: Thu, 23 Jan 2014 08:58:09 +0100
Message-ID: <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
	<52E0C889.6000106@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <52E0C889.6000106@prisktech.co.nz>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Tony Prisk <linux@prisktech.co.nz>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, the arch/x86 maintainers <x86@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux <linux@lists.openrisc.net>, Sekhar Nori <nsekhar@ti.com>, Michal Simek <monstr@monstr.eu>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, "H. Peter Anvin" <hpa@zytor.com>, Yijing Wang <wangyijing@huawei.com>, Daniel Walker <dwalker@fifo99.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>, microblaze-uclinux@itee.uq.edu.au, David Brown <davidb@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 23, 2014 at 8:45 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>   -static inline int clocksource_register_hz(struct clocksource *cs, u32
>> hz)
>> +static inline void clocksource_register_hz(struct clocksource *cs, u32
>> hz)
>>   {
>>         return __clocksource_register_scale(cs, 1, hz);
>>   }
>
>
> This doesn't make sense - you are still returning a value on a function
> declared void, and the return is now from a function that doesn't return
> anything either ?!?!
> Doesn't this throw a compile-time warning??

No, passing on void in functions returning void doesn't cause compiler
warnings.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
