From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 2/2] clocksource: Make clocksource register functions
 void
Date: Thu, 23 Jan 2014 11:40:35 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D46489C@AcuExch.aculab.com>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0C889.6000106@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <52E0C889.6000106@prisktech.co.nz>
Content-Language: en-US
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: 'Tony Prisk' <linux@prisktech.co.nz>, Yijing Wang <wangyijing@huawei.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux@lists.openrisc.net" <linux@lists.openrisc.net>, Sekhar Nori <nsekhar@ti.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, "x86@kernel.org" <x86@kernel.org>, Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, David Brown <davidb@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

From: Linuxppc-dev Tony Prisk
> On 23/01/14 20:12, Yijing Wang wrote:
> > Currently, clocksource_register() and __clocksource_register_scale()
> > functions always return 0, it's pointless, make functions void.
> > And remove the dead code that check the clocksource_register_hz()
> > return value.
> ......
> > -static inline int clocksource_register_hz(struct clocksource *cs, u32 hz)
> > +static inline void clocksource_register_hz(struct clocksource *cs, u32 hz)
> >   {
> >   	return __clocksource_register_scale(cs, 1, hz);
> >   }
> 
> This doesn't make sense - you are still returning a value on a function
> declared void, and the return is now from a function that doesn't return
> anything either ?!?!
> Doesn't this throw a compile-time warning??

It depends on the compiler.
Recent gcc allow it.
I don't know if it is actually valid C though.

There is no excuse for it on lines like the above though.

	David
