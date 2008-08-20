From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Wed, 20 Aug 2008 13:10:42 +0300 (EEST)
Message-ID: <20080820.131042.200608197.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
	<94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
	<20080819062422.GD17276@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17267 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbYHTKLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 06:11:47 -0400
In-Reply-To: <20080819062422.GD17276@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: felipe.contreras@gmail.com, h-kanigeri2@ti.com, soni.trilok@gmail.com, vpasam@ti.com, linux-omap@vger.kernel.org, r-woodruff2@ti.com, siarhei.siamashka@nokia.com, x00omar@ti.com, grgupta@ti.com

From: "ext Tony Lindgren" <tony@atomide.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 09:24:23 +0300

> * Felipe Contreras <felipe.contreras@gmail.com> [080818 23:09]:
> > On Mon, Aug 18, 2008 at 10:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> > >> If you mean there is separate clock infrastructure for DSPBridge other
> > >> than clock framework we have for OMAP, then DSPBridge should convert
> > >> to the one we have for OMAP. As recent work by Paul for clock
> > >> framework on OMAP3 and Power domains we need centralized code for clk
> > >> and power domains not separate clock infrastructure for DSPBridge.
> > >>
> > > --- Bridge is not implementing separate clock infrastructure. It is just centralizing the calls to clk_enable in one location as this is called from multiple files in Bridge code. This helps because one can then turn on the traces only for clock module to check if the clocks that were expected to be enabled are enabled or not. As I mentioned before, this helps in debugging.
> > 
> > That only makes the code harder to understand.
> > 
> > #define clk_enable(...) my_debug_function(__VA_ARGS__)
> > 
> > Achieves the same thing.
> 
> We must use clk_enable() and clk_disable() in the drivers. That's the
> Linux clock interface. Anything else won't get merged upstream.
> 
> If you need to combine multiple clocks into a single virtual dsp
> clock, please register a new custom clock using clk_register().
> 
> That allows you to do debugging in the custom clock functions too
> if necessary.

I sent some patches based on the above suggestion.

  http://marc.info/?l=linux-omap&m=121922597019873&w=2
  http://marc.info/?l=linux-omap&m=121922593919766&w=2

I think that this virtual clock may allow any arbitrary combination of
clocks and it may be possible to have multiple hierarchy of virtual
clocks like:

   dsp_clocks
   |
   |-- peripheral_clocks
   |     |
   |     |-- gpt5
   |     |    |- gpt5_ick
   |     |    `- gpt5_fck
   |
   |-- ....
   ..

Any comments would be appreciated.

    Hiroshi DOYU

