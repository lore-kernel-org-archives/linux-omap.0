From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: tps65217: Drop call to irq_set_parent()
Date: Wed, 26 Oct 2016 13:58:54 +0100
Message-ID: <20161026125854.GA12618@dell>
References: <1476479886-10208-1-git-send-email-linux@roeck-us.net>
 <20161026123516.GC11267@dell>
 <alpine.DEB.2.20.1610261437320.4983@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610261437320.4983@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On Wed, 26 Oct 2016, Thomas Gleixner wrote:

> On Wed, 26 Oct 2016, Lee Jones wrote:
> > On Fri, 14 Oct 2016, Guenter Roeck wrote:
> > 
> > > The call to irq_set_parent() causes the following build error if tps65217
> > > is built as module.
> > > 
> > > ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
> > > 
> > > The problem was introduced with commit 6556bdacf646f ("mfd: tps65217: Add
> > > support for IRQs").
> > > 
> > > The author states: "I have added irq_set_parent() similarly as in
> > > drivers/base/regmap/regmap-irq.c. But to be honest I am not sure what it
> > > really does in case of tps65217."
> > > 
> > > So let's drop it.
> > > 
> > > Fixes: 6556bdacf646f ("mfd: tps65217: Add support for IRQs")
> > > Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/mfd/tps65217.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > 
> > This has been fixed now.
> 
> It was not fixed. The export was a work around as everyone was bitching
> about the build robots failing forever.
>  
> So if the irq_set_parent() call is not required for functionality of the
> driver then it should not be there in the first place.

Ah, I thought this was just another one of the many hacks I received
in response to the auto-builder's complains.  I've just been NACKing
them out of habit.

However, if is it true that we can simply just remove the call to
irq_set_parent(), then I'm happy to apply the patch.

Even happier with an Ack from you!

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
