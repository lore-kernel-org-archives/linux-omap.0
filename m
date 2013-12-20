From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv11 06/49] clk: add support for low level register ops
Date: Fri, 20 Dec 2013 16:09:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312201603340.16798@utopia.booyaka.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com> <1387452260-23276-7-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312201056560.20802@utopia.booyaka.com> <52B42747.8090408@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54037 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab3LTQJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 11:09:41 -0500
In-Reply-To: <52B42747.8090408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, 20 Dec 2013, Tero Kristo wrote:

> On 12/20/2013 01:00 PM, Paul Walmsley wrote:
> > On Thu, 19 Dec 2013, Tero Kristo wrote:
> > > +/**
> > > + * clk_readl_default - default clock register read support function
> > > + * @reg: register to read
> > > + *
> > > + * Default implementation for reading a clock register.
> > > + */
> > > +static u32 clk_readl_default(u32 __iomem *reg)
> > 
> > Why u32 __iomem rather than void *?  Not that this will affect OMAP, but
> > will this need to be changed later to support 64-bit addresses?
> > __raw_writel() and __raw_readl() are defined with "void __iomem *" as
> > their address argument, which will be 64 bits on arm64, correct?
> 
> Just copy pasting the current implementation from the clk-provider.h file.
> 
> However, pointer is pointer no? This is just used to refer to a 32bit value,
> the pointer itself can be either 32bit or 64bit. 

Yes I think you're right that the impact is simply cosmetic.  That
argument winds up as the address argument to __raw_readl/writel()
which is a void __iomem *, so the type there will be ignored.

> If the registers are changed to be 64 bit though.... but that will
> require changing most of the clock code as it is littered with 'u32
> val;' type declarations. 

Yes, we can count on readl/writel to operate on 32-bit values.

> Anyway, I can change this to be void __iomem.

OK

- Paul
