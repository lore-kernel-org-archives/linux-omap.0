From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
 regulator_init_data
Date: Wed, 19 Oct 2011 16:10:32 +0100
Message-ID: <20111019151031.GA4275@opensource.wolfsonmicro.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
 <1318263578-7407-4-git-send-email-rnayak@ti.com>
 <20111016145536.GA29885@S2100-06.ap.freescale.net>
 <4E9BAC4D.3010402@ti.com>
 <20111018115836.GC30703@S2100-06.ap.freescale.net>
 <20111018160046.GD28501@opensource.wolfsonmicro.com>
 <20111019053354.GB31162@S2100-06.ap.freescale.net>
 <20111019144734.GI18713@sirena.org.uk>
 <20111019150448.GB32007@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111019150448.GB32007@S2100-06.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 19, 2011 at 11:04:49PM +0800, Shawn Guo wrote:
> On Wed, Oct 19, 2011 at 03:47:34PM +0100, Mark Brown wrote:

> > Only the board can come to a final decision.

> The dts is very capable and suitable to describe the board's decision.
> But you disagree that we put all constraints description into DT.  I'm
> a pretty confused here.  So again, what is your suggestion to this
> 'problem'?

The problem is that the DT is supposed to be separate to the kernel and
the decisions can depend on what the kernel is currently capable of.
When the data is embedded in the kernel it's not an issue as the data is
attached to the rest of the code, when the data becomes detatched from
the kernel it becomes an issue.

I don't see any issue with leaving some things out of the DT bindings;
you were the one raising that as a concern.
