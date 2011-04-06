From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Wed, 06 Apr 2011 12:13:54 +0530
Message-ID: <4D9C0BAA.40602@ti.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>	<201104031726.37420.arnd@arndb.de>	<20110403160324.GA8050@n2100.arm.linux.org.uk>	<201104040259.26601.arnd@arndb.de>	<1301915022.15819.28.camel@e102109-lin.cambridge.arm.com>	<20110404112104.GB19854@n2100.arm.linux.org.uk>	<1301923457.417.34.camel@e102391-lin.cambridge.arm.com>	<20110404133104.GA23266@n2100.arm.linux.org.uk>	<1301925445.417.54.camel@e102391-lin.cambridge.arm.com>	<BANLkTi=d-rQpinSW9YPsZbkh9tDK5FLS+w@mail.gmail.com>	<4D9AB958.5010304@ti.com> <BANLkTinZ+3PqkbbJp3fFs_Z8JBHQdPYM_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTinZ+3PqkbbJp3fFs_Z8JBHQdPYM_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: david@lang.hm, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Detlef Vollmann <dv@vollmann.ch>, David Brown <davidb@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On 4/6/2011 3:46 AM, Linus Walleij wrote:
> 2011/4/5 Santosh Shilimkar<santosh.shilimkar@ti.com>:
>> [Me]
>>> (And third it will also eventually need to hook into the timer-based
>>> delay framework that I think Nokia is working on to be really
>>> useful, else all delays become unpredictable.)
>>>
>> Do you mean udelay()/mdelay() here ?
>
> Yes. Stephen Boyd from Qualcomm has floated patches to fix it for the
> ARM architecture, I just pushed him again. We use it in our
> ST-Ericsson products.
>
I remember the post.

> Ideally you'd want that to go along with the A15 timer stuff so that this
> monotonic high-precision timer is also used for udelay()/mdelay().
>
The A15 counter which is always available and running can be used
to emulate this.

Regards
Santosh
