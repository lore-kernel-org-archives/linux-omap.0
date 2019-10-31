From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 1/3] ARM: dts: am43xx: add support for clkout1 clock
Date: Thu, 31 Oct 2019 07:25:13 -0700
Message-ID: <20191031142513.GB5610@atomide.com>
References: <20191016184954.14048-1-bparrot@ti.com>
 <20191016184954.14048-2-bparrot@ti.com>
 <20191022154816.GO5610@atomide.com>
 <20191022162134.fpawonjdjvd5kxza@ti.com>
 <586dcabb-0400-50d6-5488-16bddc059286@ti.com>
 <20191022165516.GE5610@atomide.com>
 <20191023155657.GL5610@atomide.com>
 <20191030195946.ouexmis632nb7lqj@ti.com>
 <39b79438-ad82-0840-b2a5-36856d0ac520@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <39b79438-ad82-0840-b2a5-36856d0ac520@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Benoit Parrot <bparrot@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [191031 14:07]:
> On 30/10/2019 21:59, Benoit Parrot wrote:
> > Tony Lindgren <tony@atomide.com> wrote on Wed [2019-Oct-23 08:56:57 -0700]:
> > > Hmm maybe in this case just doing this is enough:
> > > 
> > > clkout1_osc_div_ck: clock@4100 {
> > > 	...
> > > }
> > 
> > But then we would end up with 6 clock node with the same name "clock@4100",
> > doesn't pose a problem somewhere?
> 
> Yeah, clk core would not know which one to use then.

So we have two issues with the non-standard devicetree use
for omap clocks:

1. Multiple clock nodes with the same reg property

This we sorted out for the clkctrl binding, but we still
have other clocks with this issue.

I guess some of them can be now removed if they are just
legacy clkctrl clocks.

For the rest we could maybe group them under a node with
just one reg property?

The clocks could just look up the reg property from parent
in this case.

2. Dependency to using custom clock node names

This can be sorted out by adding custom compatibles to
the parent node for both clkctrl clock manger nodes and
for the clocks grouped in step #1 above I think.

> > > Or do all the TI clocks we have have a dependency to the
> > > node naming?
> 
> This is a feature of clock core. Clock parents need to have distinct names,
> otherwise it won't work.

With steps #1 and #2 above I think this issue would
also disappear, the clock framework naming could be like
what we already use for the clkctrl clocks.

Regards,

Tony
