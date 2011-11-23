From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Wed, 23 Nov 2011 19:09:54 +0000
Message-ID: <20111123190954.GA4365@opensource.wolfsonmicro.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
 <20111122191347.GB4844@kroah.com>
 <20111123165903.GF31337@atomide.com>
 <20111123180651.GB19739@n2100.arm.linux.org.uk>
 <20111123185518.GG31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111123185518.GG31337@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, Mike Turquette <mturquette@linaro.org>, linaro-dev@lists.linaro.org, eric.miao@linaro.org, grant.likely@secretlab.ca, jeremy.kerr@canonical.com, Mike Turquette <mturquette@ti.com>, sboyd@quicinc.com, magnus.damm@gmail.com, dsaxena@linaro.org, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, tglx@linutronix.de, linux-omap@vger.kernel.org, richard.zhao@linaro.org, shawn.guo@freescale.com, paul@pwsan.com, linus.walleij@stericsson.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, skannan@quicinc.com
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 23, 2011 at 10:55:19AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111123 09:31]:

> > Keep the clk API as a fundamental thing which should be initialized early
> > so we don't have to invent new clk APIs to get around its unavailability.

> What else are you aware of that is really needed early for clocks other
> than clockevent?

If nothing else we'd have to resolve all the device probe ordering
issues (Grant's patches seem a bit stalled) and convert all the systems
using the API to handle deferring probes until their clocks appear.
Using an early initcall of some kind would help with that but it does
seem like a lot of trouble and I'd expect it'll end up getting forced in
on most systems anyway.
