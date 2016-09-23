From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
Date: Fri, 23 Sep 2016 07:26:34 -0700
Message-ID: <20160923142634.zkaqxmiif22kws2e@atomide.com>
References: <20160922180718.kmttyt26t56fa3kp@atomide.com>
 <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160923 00:21]:
> On 09/22/16 21:07, Tony Lindgren wrote:
> > Hi,
> > 
> > Looks like commit 7a17e47f6403 ("mfd: twl6040: The chip does not
> > support bulk access") breaks at least omap4-duovero.
> 
> That's odd. I see no such errors on omap4 PandaBoard-ES nor on omap5 uEVM.
> The IRQ status is one register so even in bulk access it is one read. So the
> use_single_rw should have no effect on the access.

Oh it's just one register.

> The only time when regmap would try to use bulk access to twl6040 is when we
> execute regcache_sync() on it after resuming the chip and this would fail at
> the first time when it tries to restore more than one consecutive registers.
> 
> I just tested things on next-20160915 and I see no errors at all.

OK interesting.

> > I now get tons of errors:
> > 
> > Skipping twl internal clock init and using bootloader value (unknown osc rate)
> > twl 0-0048: PIH (irq 332) nested IRQs
> > of_get_named_gpiod_flags: parsed 'ti,audpwron-gpio' property of node '/ocp/i2c@48070000/t
> > wl@4b[0]' - status (0)
> > omap_i2c 48070000.i2c: bus 0 rev0.10 at 400 kHz
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > twl6040 0-004b: Failed to read IRQ status: -16
> > 
> > It seems the regmap irqs don't work with use_single_rw?

So obviously that's a wrong conclusion then.

> > Also seems that twl6040 does support bulk access as things have been
> > working earlier?
> 
> Things kind of worked as we had single register reads and writes, but when I
> tried to power down/up the twl6040 the regcache_sync() would fail to restore
> the registers at the first place when we had two or more registers to update
> in bulk mode. In that case regmap gives an error, but I have not been checking
> the return of the regcache_sync() so the chip comes up, but not all settings
> were restored.
> 
> > Anyways, can you please revert?
> 
> Please don't.
> 
> On which linux-next version you are seeing this?

This was with next-20160922. But testing it again this is just another
regression caused by "softirq: fix tasklet_kill() and its users", so adding
Santosh to Cc.

So no need to revert $subject patch.

Regards,

Tony
