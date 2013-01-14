From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: OMAP baseline test results for v3.8-rc3
Date: Tue, 15 Jan 2013 00:42:22 +0200
Message-ID: <20130114224222.GC18224@blackmetal.musicnaut.iki.fi>
References: <alpine.DEB.2.00.1301141756460.20390@utopia.booyaka.com>
 <20130114184018.GA18224@blackmetal.musicnaut.iki.fi>
 <20130114191459.GA9402@arwen.pp.htv.fi>
 <20130114204654.GB18224@blackmetal.musicnaut.iki.fi>
 <20130114211846.GA10699@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:35086 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216Ab3ANWmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 17:42:25 -0500
Content-Disposition: inline
In-Reply-To: <20130114211846.GA10699@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 14, 2013 at 11:18:46PM +0200, Felipe Balbi wrote:
> On Mon, Jan 14, 2013 at 10:46:54PM +0200, Aaro Koskinen wrote:
> > [    0.207946] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
> > [    0.208129] twl 1-0048: power (irq 343) chaining IRQs 346..353
> > [    0.209350] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
> > [    1.218749] omap_i2c omap_i2c.1: timeout waiting for bus ready
> > [    1.218811] omap_i2c omap_i2c.1: SA 0049 CON 9602 CNT 0004
> 
> here's the issue, there is unloaded data in the FIFO. Can you enable
> full I2C debugging logs ?

If I enable I2C DEBUGs, the problem is not reproducible. Everything
looks normal:

[    0.270141] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.270294] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.270477] i2c i2c-1: master_xfer[0] W, addr=0x49, len=1
[    0.270538] i2c i2c-1: master_xfer[1] R, addr=0x49, len=1
[    0.270568] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop: 0
[    0.270629] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.270690] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.270751] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop: 1
[    0.270843] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[    0.270874] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.270935] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[    0.270965] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop: 1
[    0.271026] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    0.271118] omap_i2c omap_i2c.1: IRQ (ISR = 0x0004)
[    0.272155] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371

> > >   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-deferred-STP
> > 
> > I could not reproduce the issue with these. Tested around 20 boots.
> > There's a noticeable delay (over 4 secs!) around where I2C is initialized
> > and used for the first time, but no errors and the boot completes:
> > 
> > [    0.187530] SCSI subsystem initialized
> > [    0.188110] usbcore: registered new interface driver usbfs
> > [    0.188415] usbcore: registered new interface driver hub
> > [    0.188781] usbcore: registered new device driver usb
> > [    0.189453] musb-omap2430 musb-omap2430: invalid resource
> > [    4.296905] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
> > [    4.297088] twl 1-0048: power (irq 343) chaining IRQs 346..353
> > [    4.329010] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
> > [    4.470123] VUSB1V5: 1500 mV normal standby
> > [    4.470916] VUSB1V8: 1800 mV normal standby
> 
> cool, at least it works, but looks like there is something still weird
> going on. Can you enable full logs so I see what's happening ?

With your patches, all DEBUG logs are identical (there is same
amount I2C of transfers), except there is only a single interrupt per
transfer. Still, the transfers are taking considerably longer, and we
see those delays in the boot:

[    4.281280] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    4.281433] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    4.281616] i2c i2c-1: master_xfer[0] W, addr=0x49, len=1
[    4.281677] i2c i2c-1: master_xfer[1] R, addr=0x49, len=1
[    4.281707] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x0, stop: 0
[    4.281799] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    4.281829] omap_i2c omap_i2c.1: addr: 0x0049, len: 1, flags: 0x1, stop: 1
[    4.281921] omap_i2c omap_i2c.1: IRQ (ISR = 0x0008)
[    4.296905] i2c i2c-1: master_xfer[0] W, addr=0x49, len=2
[    4.296936] omap_i2c omap_i2c.1: addr: 0x0049, len: 2, flags: 0x0, stop: 1
[    4.296997] omap_i2c omap_i2c.1: IRQ (ISR = 0x0010)
[    4.313476] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371

This log excerpt has only 3 transfers, but the time duration is already
10x longer compared to vanilla 3.8-rc3.

A.
