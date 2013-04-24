From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH V4 1/6] clk: OMAP: introduce device tree binding to kernel clock
 data
Date: Wed, 24 Apr 2013 09:28:47 -0700
Message-ID: <20130424162847.8998.73264@quantum>
References: <1365807278-554-1-git-send-email-nm@ti.com>
 <1365807278-554-2-git-send-email-nm@ti.com>
 <20130412233142.GE10155@atomide.com> <20130412233900.GA1599@kahuna>
 <20130413172210.GM10155@atomide.com> <20130414211917.GA3275@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130414211917.GA3275@snafu>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

Quoting Nishanth Menon (2013-04-14 14:19:17)
> Overall strategy introduced here is simple: a clock node described in
> device tree blob is used to identify the exact clock provided in the
> SoC specific data. This is then linked back using of_clk_add_provider
> to the device node to be accessible by of_clk_get.
> 
> Based on discussion contributions from Roger Quadros, Grygorii Strashko
> and others.
> 
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> [tony@atomide.com: co-developed]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

I can take this into clk-next after the merge window.  Please refresh it
for -rc1 as we discussed on irc.

As an aside, will Tero's series for migrating to drivers/clk/omap[1] and
Rajendra's patch for registering clocks late[2] be refreshed after the
merge window?  It would be nice to combine these efforts.

Thanks,
Mike

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/95948
[2] http://www.spinics.net/lists/arm-kernel/msg231288.html
