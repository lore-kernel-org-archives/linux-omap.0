From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Thu, 20 Oct 2011 09:27:43 -0700
Message-ID: <20111020162743.GB31337@atomide.com>
References: <20111016145536.GA29885@S2100-06.ap.freescale.net>
	<4E9BAC4D.3010402@ti.com>
	<20111018115836.GC30703@S2100-06.ap.freescale.net>
	<20111018160046.GD28501@opensource.wolfsonmicro.com>
	<20111019053354.GB31162@S2100-06.ap.freescale.net>
	<20111019144734.GI18713@sirena.org.uk>
	<20111019150448.GB32007@S2100-06.ap.freescale.net>
	<20111019151031.GA4275@opensource.wolfsonmicro.com>
	<4E9F9892.9070007@ti.com> <20111020094140.GK18713@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111020094140.GK18713@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, Shawn Guo <shawn.guo@freescale.com>, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [111020 02:07]:
> On Thu, Oct 20, 2011 at 09:12:10AM +0530, Rajendra Nayak wrote:
> > On Wednesday 19 October 2011 08:40 PM, Mark Brown wrote:
> 
> > >I don't see any issue with leaving some things out of the DT bindings;
> > >you were the one raising that as a concern.
> 
> > The problem is, that there doesn't seem to be a clean way to embed
> > *board data* into the kernel with DT, if left out of the DT bindings.
> > There is the auxdata way of still attaching platform_data, but that I
> > thought was a stopgap for just handling function pointers.
> 
> We can always start off just completely omitting the data and then see
> how we go from there.  If we only cover 50% of users that's still 50%
> more than are currently covered with device tree right now and it means
> we can then spin round and look at the bits that are hard again without
> review fatigue on the bits that are easy.

We still need to pass the board configuration somehow, otherwise we can
never remove all the platform data glue layers. And if we can't do that,
we'll forever have all the nasty merge conflicts when adding new drivers.
And there's an unnecessary dependency between adding drivers and the
core SoC code.

So we really need to remove all the platform data glue layers so driver
probe can initialize things automagically.

Kernel cmdline is of course one way to pass options, but probably won't
scale for all the board wirings.. And the kernel cmdline should really
be for user configurable options.

So should we just have a cmdline string for each DT entry to pass the
board specific options from DT to the driver? Something along the
lines module options?

Regards,

Tony
