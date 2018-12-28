From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Date: Fri, 28 Dec 2018 12:02:29 -0800
Message-ID: <20181228200229.GY6707@atomide.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
 <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
 <20181203153910.GA6707@atomide.com>
 <20181203172246.0e767a16@kemnade.info>
 <20181204164556.GB6707@atomide.com>
 <20181227211222.5996c356@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181227211222.5996c356@aktux>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>, bcousson@baylibre.com, letux-kernel@openphoenux.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [181227 20:13]:
> Hi,
> 
> On Tue, 4 Dec 2018 08:45:57 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
> > > On Mon, 3 Dec 2018 07:39:10 -0800
> > > Tony Lindgren <tony@atomide.com> wrote:  
> > > > The consumer device stays active just fine with PM runtime
> > > > calls. So yes, the problem is keeping a clock controller forced
> > > > active for the period of consumer device reset. Other than
> > > > that typically autoidle can be just kept enabled.
> > > >   
> > > Are we still talking about the same problem? Maybe I am losing track
> > > here. Just to make sure. 
> > > The patch series was about disabling autoidle for devices which cannot
> > > work with it during normal operation. Not during reset or something
> > > like that. 
> > > Or is the keep-clock-active-during-reset just a requirement for bigger
> > > restructuring ideas?  
> > 
> > Yeah there are two issues: The fix needed for the issue you brought up,
> > and also how to let a reset driver to block autoidle for reset.
> > 
> Hmm, is this set now waiting for the famous "somebody" fixing all
> the stuff?

Well I think we're still waiting on Tero to comment on this.

> What are currently visible symptoms for the driver not blocking
> autoidle for reset? Maybe I can at least test something there. I have
> also omap5 here.

Oh that's just for making drivers/reset drivers to work in
the long run. Let's keep that separate from these fixes..

Regards,

Tony
