From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/16] gpio: Tight IRQ chip integration and banked
 infrastructure
Date: Fri, 15 Sep 2017 09:57:51 -0700
Message-ID: <20170915165750.GW5024@atomide.com>
References: <20170901185736.28051-1-thierry.reding@gmail.com>
 <CACRpkdaRsG-9YU2ufb+FxGOO38+x=AAfVUqxH5s56NH2iLw7oA@mail.gmail.com>
 <20170914185233.GA6410@aiwendil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914185233.GA6410@aiwendil>
Sender: linux-gpio-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Thierry Reding <thierry.reding@gmail.com> [170915 08:10]:
> On Thu, Sep 14, 2017 at 03:54:56PM +0200, Linus Walleij wrote:
> > Sorry about that. Let's move ahead with this now, it is neat and
> > clean.
> > 
> > What I want (as maintainer) is a bit of fingerpointing at the drivers
> > that need to be converted to use the new banking infrastructure
> > so they don't stay with their old crappy design pattern. OMAP is
> > a clear candidate right? (Added Tony to CC...)
> 
> OMAP should be able to use this infrastructure, but it may not want to
> because the semantics would change slightly. Currently OMAP registers a
> GPIO chip for each bank, whereas this infrastructure exposes multiple
> banks via a single chip.

Oh so you don't have separate interrupts for the instances?
Thanks for clarifying that.

> There might be some userspace that relies on the existence of multiple
> chips, but Tony can probably knows that better than I.

On omaps, each bank is a separate driver instance with it's own
interrupt. Maybe really all we need to do is get rid of the "bank"
naming, I think that's left over from 15 years ago when we did not
have separate driver instances. It seems we should s/bank/ddata/
on the driver to avoid confusion.

Grygorii, any comments?

Regards,

Tony
