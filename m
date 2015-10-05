From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
Date: Mon, 5 Oct 2015 04:03:36 -0700
Message-ID: <20151005110336.GX23801@atomide.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-10-git-send-email-balbi@ti.com>
 <560DACD8.8000301@linaro.org>
 <20151005105034.GU23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151005105034.GU23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, John Stultz <john.stultz@linaro.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151005 03:56]:
> * Daniel Lezcano <daniel.lezcano@linaro.org> [151001 15:04]:
> > >+	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> > >+			32768, NSEC_PER_SEC, 120000);
> > >+
> > >+	ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
> > >+				250, 32, clocksource_mmio_readl_up);
> > >+	if (ret) {
> > >+		pr_err("32k_counter: can't register clocksource\n");
> > >+		return;
> > >+	}
> > >+
> > >+	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
> > >+	register_persistent_clock(NULL, omap_read_persistent_clock64);
> > 
> > I will let John Stultz to have a look at this part because I have doubt
> > regarding the usage of the persistent clock.
> 
> The persistent clock we want to keep for deeper idle states..
> Especially when we start changing clocksource for the duration of
> deeper idle states. I'll post some updated patches on that when I
> get a chance.

But sounds like we can just have read_persistent_clock() check
for the CLOCK_SOURCE_SUSPEND_NONSTOP like I pointed in the other
patch in this series.

Tony
