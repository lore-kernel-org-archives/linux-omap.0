From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Fri, 28 Aug 2015 21:42:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508282122480.15006@nanos>
References: <20150825195830.GH27534@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150825195830.GH27534@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 25 Aug 2015, Felipe Balbi wrote:
> Hi Ingo,

Thanks for not cc'ing the irq maintainer ....
 
> I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when using
> devm_request_*irq().
> 
> If we using devm_request_*irq(), that irq will be freed after device
> drivers' ->remove() gets called. If on ->remove(), we're calling
> pm_runtime_put_sync(); pm_runtime_disable(), device's clocks might get
> gated and, because we do an extra call to the device's IRQ handler when
> CONFIG_DEBUG_SHIRQ=y, we might trigger an abort exception if, inside the
> IRQ handler, we try to read a register which is clocked by the device's
> clock.
> 
> This is, of course, really old code which has been in tree for many,
> many years. I guess nobody has been running their tests in the setup
> mentioned above (CONFIG_DEBUG_SHIRQ=y, pm_runtime_put_sync() on
> ->remove(), a register read on IRQ handler, and a shared IRQ handler),
> so that's why we never caught this before.
> 
> Disabling CONFIG_DEBUG_SHIRQ, of course, makes the problem go away, but
> if driver *must* be ready to receive, and handle, an IRQ even during
> module removal, I wonder what the IRQ handler should do. We can't, in
> most cases, call pm_runtime_put_sync() from IRQ handler.

Well, a shared interrupt handler must handle this situation, no matter
what. Assume the following:

irqreturn_t dev_irq(int irq, void *data)
{
	struct devdata *dd = data;
	u32 state;

	state = readl(dd->base);
	...
}

void module_exit(void)
{	
	/* Write to the device interrupt register */
	disable_device_irq(dd->base);
	/*
	 * After this point the device does not longer
	 * raise an interrupt
	 */
	iounmap(dd->base);
	free_irq();

If the other device which shares the interrupt line raises an
interrupt after the unmap and before free_irq() removed the device
handler from the irq, the machine is toast, because the dev_irq
handler is still called.

If the handler is shut down after critical parts of the driver/device
are shut down, then you can 

 - either can change the setup/teardown ordering

	disable_device_irq(dd->base);
	free_irq();
	iounmap(dd->base);

 - or have a proper flag in the private data which tells the interrupt
   handler to sod off.

irqreturn_t dev_irq(int irq, void *data)
{
	struct devdata *dd = data;

	if (dd->shutdown)
		return IRQ_NONE;
	...

void module_exit(void)
{	
	disable_device_irq(dd->base);
	dd->shutdown = 1;

	/* On an SMP machine you also need: */	
	synchronize_irq(dd->irq);

So for the problem at hand, the devm magic needs to make sure that the
crucial parts are still alive when the devm allocated irq is released.

I have no idea how that runtime PM stuff is integrated into devm (I
fear not at all), so it's hard to give you a proper advise on that.

Thanks,

	tglx
