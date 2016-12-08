From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3] clk: ti: omap36xx: Work around sprz319 advisory 2.1
Date: Thu, 8 Dec 2016 13:14:35 -0800
Message-ID: <20161208211435.GJ5423@codeaurora.org>
References: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161208001654.GD5423@codeaurora.org>
 <20161208071155.GA7530@localhost.localdomain>
 <3225321.q72K2erxPs@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3225321.q72K2erxPs@avalon>
Sender: linux-clk-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Richard Watts <rrw@kynesim.co.uk>, Tony Lindgren <tony@atomide.com>, Alexander Kinzer <a.kinzer@plusoptix.de>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On 12/08, Laurent Pinchart wrote:
> Hi Ladislav,
> 
> On Thursday 08 Dec 2016 08:11:55 Ladislav Michl wrote:
> > On Wed, Dec 07, 2016 at 04:16:54PM -0800, Stephen Boyd wrote:
> > > On 12/05, Tero Kristo wrote:
> > > > The compiler should ideally generate same size code for these both.
> > > > Personally, I don't mind which version goes in; I'd say both are as
> > > > readable.
> > > > 
> > > > Stephen, Mike, is one of you going to pick this up? I don't think I
> > > > have anything else to pull due to the ongoing discussion with the
> > > > other pending stuff.
> > > 
> > > I have no problem picking up either version. Please send it with
> > > the appropriate tags added and I can merge it.
> > 
> > Here it is for your convenience. Of course I'd like to see smaller code
> > to go in as exactly those sneaky tiny incremental code size increases
> > made Linux kernel unusable on most of my hardware over time ;-)
> > However, if Laurent is unhappy with changes I made, I will not object
> > merging his version any more.
> 
> I'd rather keep my version, thank you. Let's not spend time chasing bytes.
> 

Ok so I'll go apply the original patch v3 in this thread and dig
out the tags myself.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
