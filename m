From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
Date: Thu, 31 May 2018 06:45:07 -0700
Message-ID: <20180531134507.GK5705@atomide.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
 <20180530150402.GE5705@atomide.com>
 <2361da91-659d-1aaa-0ab8-d1473bc3a71a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2361da91-659d-1aaa-0ab8-d1473bc3a71a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180531 10:22]:
> On Wednesday 30 May 2018 08:34 PM, Tony Lindgren wrote:
> > Looks good to me except I think the reset won't do anything currently
> > with ti-sysc.c unless you specfify also "ti,hwmods" for the module?
> > 
> > Can you please check? It might be worth adding the reset function to
> > ti-sysc.c for non "ti,hwmods" case and that just might remove the
> > need for any hwmod code for this module.
> > 
> 
> If I understand correctly, this involves adding a (*reset_module) in
> ti_sysc_platform_data and defining a ti_sysc_reset_module() in ti-sysc.c
> similar to ti_sysc_idle_module(). Right?

Well try moving "ti,hwmods" to the module level first. Then reset will
happen with enable.

Then for simple cases we can add reset directly to ti-sysc.c without
pdata callbacks and and drop "ti,hwmods". For more complex cases we
need to use reset-simple for the RSTCTRL registers.

Regards,

Tony
