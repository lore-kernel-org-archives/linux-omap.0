From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
 regulator_init_data
Date: Wed, 19 Oct 2011 13:33:55 +0800
Message-ID: <20111019053354.GB31162@S2100-06.ap.freescale.net>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
 <1318263578-7407-4-git-send-email-rnayak@ti.com>
 <20111016145536.GA29885@S2100-06.ap.freescale.net>
 <4E9BAC4D.3010402@ti.com>
 <20111018115836.GC30703@S2100-06.ap.freescale.net>
 <20111018160046.GD28501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111018160046.GD28501@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 18, 2011 at 05:00:46PM +0100, Mark Brown wrote:
> On Tue, Oct 18, 2011 at 07:58:37PM +0800, Shawn Guo wrote:
> 
> > I understand that ideally device tree is supposed to describe pure
> > hardware configurations.  But practically, when migrating a driver
> > to device tree probe, we are trying to move the configurations
> > described by platform_data into device tree to save the use of
> > platform_data for device tree probe.  Then some of the configuration
> > may not be so purely hardware related.  But I do not see this is a
> > critical problem.
> 
> It's not just Linux-specific stuff, some of this is even specific to
> what current Linux drivers can do - updating the kernel could mean a
> different set of constraints.
> 
Well, from what I see, the 'struct regulation_constraints' is defined
in machine.h and meant to be the regulator machine/board interface.
With the example I'm looking at, mc13892, the regulation_constraints
configuration is fully passed from machine/board file.  If there is
something specific to what drivers can do, it probably should be encoded
in regulator driver rather than staying in regulation_constraints.

So how do you think we should proceed here?

-- 
Regards,
Shawn
