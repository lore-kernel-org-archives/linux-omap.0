From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3] clk: ti: omap36xx: Work around sprz319 advisory 2.1
Date: Mon, 05 Dec 2016 13:08:20 +0200
Message-ID: <3176488.xoM6adFiVO@avalon>
References: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com> <2239782.MNuANFihMe@avalon> <20161205093649.GA31898@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161205093649.GA31898@localhost.localdomain>
Sender: linux-clk-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Tony Lindgren <tony@atomide.com>, Alexander Kinzer <a.kinzer@plusoptix.de>
List-Id: linux-omap@vger.kernel.org

Hi Ladislav,

On Monday 05 Dec 2016 10:36:49 Ladislav Michl wrote:
> On Mon, Dec 05, 2016 at 10:46:43AM +0200, Laurent Pinchart wrote:
> > On Monday 05 Dec 2016 09:22:10 Ladislav Michl wrote:
>
> [snip]
> 
> >> Table 36 list two options with 26MHz clocks: m=443, n=11 and m=480, n=12
> >> with a statement: "The choice between these two options with a 26 MHz
> >> input should be based on characterization on the end system."
> >> 
> >> Shall we care about that?
> > 
> > I'd like to, but at the moment I don't see how. Proposals are welcome :-)
> > I
> 
> One of proposals raised earlier was DT property, but that idea was scratched
> later.

It might not be such a bad idea, given that the decision should be made based 
on the characterization of the whole system. One could argue that such 
platform information could have its place in DT.

> > don't think addressing that issue should be a blocker to get this patch
> > merged though.
> 
> Of course not. I'd like to even see it in stable ;-)
> 
> [snip]
> 
> > I had tried that, but I find the code less readable :-S
> 
> Oh... Please reconsider (I really do not like that extra test and extra
> assignment to local variables (also I had 'precomputed' as mixed definition,
> but Tero did not quite like that)) :-)

I still like to favour code readability when possible (especially when the 
compiler should optimize both versions the same way). I'm not the maintainer 
of this driver though, so I'll let Tero decides what he prefers.

> Also, checked if the same values are written to clk as with my patch, so
> here's my:
> Tested-by: Ladislav Michl <ladis@linux-mips.org>

Thank you.

-- 
Regards,

Laurent Pinchart

