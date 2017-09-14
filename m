From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/16] gpio: Add support for banked GPIO controllers
Date: Thu, 14 Sep 2017 16:49:35 -0700
Message-ID: <20170914234934.GV5024@atomide.com>
References: <20170901185736.28051-1-thierry.reding@gmail.com>
 <20170901185736.28051-15-thierry.reding@gmail.com>
 <CACRpkdZ7QwyrqqO8iLXDcDimWk5iwOEKZBvXQ-2mBO5s+vg13A@mail.gmail.com>
 <20170914233731.GU5024@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914233731.GU5024@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170914 16:38]:
> * Linus Walleij <linus.walleij@linaro.org> [170914 07:00]:
> > On Fri, Sep 1, 2017 at 8:57 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Some GPIO controllers are subdivided into multiple logical blocks called
> > > banks (or ports). This is often caused by the design assigning separate
> > > resources, such as register regions or interrupts, to each bank, or some
> > > set of banks.
> > >
> > > This commit adds support for describing controllers that have such a
> > > banked design and provides common code for dealing with them.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > This patch makes me really happy.
> > 
> > It pulls in a lot of weirdness to the OF core and creates a coherent
> > way of handling these "banked" GPIO chips.
> > 
> > CC to Tony to make sure he checks that OMAP is ready to use this
> > too.
> 
> Adding Grygorii to Cc as well, we'll take a look.
> 
> Probably the runtime PM will be an issue here still. We must currently
> do runtime PM on per GPIO bank basis instead of per GPIO pin level as
> we constantly runtime_suspend/resume the whole GPIO bank for idle modes
> on the SoCs that support PM. So the usage count for the bank needs to
> be either 0 or 1 and cannot be the lines used in the bank.

And based on a quick look at this series it should not cause
problems there. For managing the banks in a generic way, I
like the idea too.

Regards,

Tony
