From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Wed, 19 Oct 2011 23:04:49 +0800
Message-ID: <20111019150448.GB32007@S2100-06.ap.freescale.net>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111016145536.GA29885@S2100-06.ap.freescale.net>
	<4E9BAC4D.3010402@ti.com>
	<20111018115836.GC30703@S2100-06.ap.freescale.net>
	<20111018160046.GD28501@opensource.wolfsonmicro.com>
	<20111019053354.GB31162@S2100-06.ap.freescale.net>
	<20111019144734.GI18713@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111019144734.GI18713@sirena.org.uk>
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
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 19, 2011 at 03:47:34PM +0100, Mark Brown wrote:
> On Wed, Oct 19, 2011 at 01:33:55PM +0800, Shawn Guo wrote:
> > On Tue, Oct 18, 2011 at 05:00:46PM +0100, Mark Brown wrote:
> 
> > > It's not just Linux-specific stuff, some of this is even specific to
> > > what current Linux drivers can do - updating the kernel could mean a
> > > different set of constraints.
> 
> > Well, from what I see, the 'struct regulation_constraints' is defined
> > in machine.h and meant to be the regulator machine/board interface.
> 
> ...which will depend on the system integrator's understanding of what
> their system is capable of right now.
> 
> > With the example I'm looking at, mc13892, the regulation_constraints
> > configuration is fully passed from machine/board file.  If there is
> > something specific to what drivers can do, it probably should be encoded
> > in regulator driver rather than staying in regulation_constraints.
> 
> I don't think you're quite understanding the issue - it's an integration
> problem with three different variables.  It's a combination of what the
> chips can do, what the drivers can do and if the board design affects
> any of this stuff.
>
Honestly, I'm still pretty new to regulator subsystem, so really need
your help to understand the situation.

> Only the board can come to a final decision.
> 
The dts is very capable and suitable to describe the board's decision.
But you disagree that we put all constraints description into DT.  I'm
a pretty confused here.  So again, what is your suggestion to this
'problem'?

-- 
Regards,
Shawn
