From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] OMAP/pinmux: remove misuse of IRQF_NO_SUSPEND flag
Date: Tue, 8 Mar 2016 09:09:09 -0800
Message-ID: <20160308170909.GC9329@atomide.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYzJ9Hy0sH6gK6RzpLE6juS4WfPjbt7nh43vR9YTuGZWA@mail.gmail.com>
 <56C1A1FE.3080403@arm.com>
 <20160215152751.GT19432@atomide.com>
 <56DEB82F.5050703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56DEB82F.5050703@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160308 03:32]:
> 
> Yeah. As I mentioned before patches 2/3 will not work.
> I've tried to test suspend with diff I posted [1], but I did it only on 
> dra7 and am43 where suspend i more simple than on omap3. Also, I worry
> that with such approach some irq can be missed (especially edge ones), 
> because PRCM irqs will be re-enabled at very late resume stage 
> (right before thaw).

Yeah any tests not done with PM on omap3 with the mainline kernel
are clearly incomplete in this case :)

> Second option, I see, is to rework PRCM to be threaded IRQ, but in this case
> all children IRQs will need to be threaded/nested threaded
> (including PCS, legacy OMAP mux, OMAP3 _prcm_int_handle_wakeup/_prcm_int_handle_io).
> 
> Are there any objection to convert PCS to threaded IRQ, for example? ;)

For PRCM interrupt, I don't think that can be threaded IRQ as
that thing is firing all the time. The consumers for the chained
PRCM interrupt consumers like PCS could probably use threaded IRQ.
When the PCS interrupts fire, we're already in some sleeper
idle state so the extra latency thre does not matter.

Regards,

Tony

> [1] https://patchwork.ozlabs.org/patch/578915/

