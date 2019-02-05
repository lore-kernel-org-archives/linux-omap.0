From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Tue, 5 Feb 2019 08:41:32 -0800
Message-ID: <20190205164132.GT5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com>
 <5C5959DB.2090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5C5959DB.2090608@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: s-anna@ti.com, ohad@wizery.com, bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190205 09:40]:
> On 04/02/19 18:33, Tony Lindgren wrote:
> > 
> > 	shrdram2: memory@10000 {
> > 		device_type = "memory";
> > 		reg = <0x10000 0x3000>;
> > 	};
> 
> Shared RAM is not so straight forward. Both PRU firmwares and both application drivers
> might need to read/write here. The area split is decided by firmware design and there
> is no hardware protection to prevent from stomping on each others toes.
> 
> We need a carveout based memory allocator at least I think that can do a
> allocate(base_offset, size); into shared RAM.
> 
> This could be used by pru_rproc driver at firmware load time and by application drivers
> at initialization time.
> 
> Thoughts?

That sounds sane to me :)

> > If the ti,pruss-gp-mux-sel and ti,pru-interrupt-map are
> > firmware configuration options, maybe leave them out of
> > the dts completely and make the app-node optional.
> 
> Yes the app-node is optional. I will mention it.
> 
> No, ti,pruss-gp-mux-sel and ti,pru-interrupt-map are not firmware options.
> But these settings are application/firmware specific.
> 
> ti,pru-interrupt-map specifies the configuration to be used for the INTC interrupt
> controller.

OK. So just to see if we have a standard solution available already..
It sounds a bit similar to what we're doing with omap-wakeupgen.c
and stacked interrupts? I wonder if something similar might help
here?

> ti,pruss-gp-mux-sel is used to configure this register.
> "Table 30-20. PRUSS_GPCFG0" in http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf
> "29:26 PR1_PRU0_GP_MUX_SEL"
> 
> It configures how the pins from the PRUSS module are routed internally
> to the various modules.
> 
> see "30.2.1 PRU-ICSS I/O Interface"
> and "Table 30-1. PRU-ICSS1 I/O Signals"

Well these are external signals for PRUSS processor (although not
necessarily external signals for the SoC). So why not handle them
with a standard pinctlr binding with #pinctrl-cells?

Sure it may not even be the Linux pinctrl framework running on the
main SoC handling these pins, but after all you're describing
hardware for a processor. Maybe Linus W has some comments on this?

Regards,

Tony
