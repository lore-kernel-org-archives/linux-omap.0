From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] mfd: cpcap: Use handle_reread flag for interrupts
Date: Mon, 3 Apr 2017 20:17:41 -0700
Message-ID: <20170404031741.GL10760@atomide.com>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-3-tony@atomide.com>
 <20170403102122.c6bztacpqmt2xdzw@dell>
 <20170403141454.GG10760@atomide.com>
 <20170403143202.mj3jpi7csdfbpgdy@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170403143202.mj3jpi7csdfbpgdy@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [170403 07:34]:
> On Mon, 03 Apr 2017, Tony Lindgren wrote:
> 
> > Hi,
> > 
> > * Lee Jones <lee.jones@linaro.org> [170403 03:23]:
> > > On Wed, 22 Mar 2017, Tony Lindgren wrote:
> > > 
> > > > On CPCAP we need to keep reading interrupts until there are no
> > > > more interrupts. Otherwise the PMIC interrupt to the SoC will at
> > > > some point stop toggling. This seems to happen because new CPCAP
> > > > device interrupts show up while we're handling.
> > > > 
> > > > Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Cc: Marcel Partap <mpartap@gmx.net>
> > > > Cc: Michael Scott <michael.scott@linaro.org>
> > > > Tested-by: Sebastian Reichel <sre@kernel.org>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > ---
> > > >  drivers/mfd/motorola-cpcap.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > 
> > > Applied, thanks.
> > 
> > Sorry this one depends on patch 1/4 for .handle_reread. So this
> > one should be reverted or dropped. That will cause trivial merge
> > conflicts with patches 2 and 4.
> > 
> > Please let me know if you want me to resend just patches 2 and 4
> > as patches 1 and 2 need more work.
> 
> Yes, I found that out (and replied to the regmap patch).
> 
> I'll revert them all for now.

OK thanks.

> Awaiting a subsequent revision.

Sent as "[PATCHv3 0/3] CPCAP PMIC IRQ fix and related changes"
with regmap changes dropped as I figured out what the real issue
with lost interrupts was :)

Regards,

Tony
