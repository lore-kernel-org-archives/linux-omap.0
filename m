From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 10:37:12 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E12EC5BDC@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
	<94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
	<20080819062422.GD17276@atomide.com>
 <20080820.131042.200608197.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbYHUPh0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 11:37:26 -0400
In-Reply-To: <20080820.131042.200608197.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Doyu-san,

> I think that this virtual clock may allow any arbitrary combination of
> clocks and it may be possible to have multiple hierarchy of virtual
> clocks like:
> 
>    dsp_clocks
>    |
>    |-- peripheral_clocks
>    |     |
>    |     |-- gpt5
>    |     |    |- gpt5_ick
>    |     |    `- gpt5_fck
>    |
>    |-- ....
>    ..
> 
> Any comments would be appreciated.


The feature looks good, but I think we cannot use this in DSP Bridge for following reasons.

This implementation is under the assumption that we will either enable or disable all the registered Bridge Peripherals clocks, which is not the case in reality.

In Bridge, we cannot make the assumption that all the registered clocks will be enabled. Bridge cannot use the vclk_enable function because this will enable all the registered clocks, which is not accepted. The clocks should be enabled only based on the request from DSP...it is use case driven.

Similarly, we cannot call vclk_disable(struct clk *clk) as this will result in calling clk_disable for the clocks that might not have been enabled.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Wednesday, August 20, 2008 5:11 AM
> To: tony@atomide.com
> Cc: felipe.contreras@gmail.com; Kanigeri, Hari; soni.trilok@gmail.com;
> Pasam, Vijay; linux-omap@vger.kernel.org; Woodruff, Richard;
> siarhei.siamashka@nokia.com; Ramirez Luna, Omar; Gupta, Ramesh
> Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
> 
> From: "ext Tony Lindgren" <tony@atomide.com>
> Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
> Date: Tue, 19 Aug 2008 09:24:23 +0300
> 
> > * Felipe Contreras <felipe.contreras@gmail.com> [080818 23:09]:
> > > On Mon, Aug 18, 2008 at 10:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > > >> If you mean there is separate clock infrastructure for DSPBridge
> other
> > > >> than clock framework we have for OMAP, then DSPBridge should
> convert
> > > >> to the one we have for OMAP. As recent work by Paul for clock
> > > >> framework on OMAP3 and Power domains we need centralized code for
> clk
> > > >> and power domains not separate clock infrastructure for DSPBridge.
> > > >>
> > > > --- Bridge is not implementing separate clock infrastructure. It is
> just centralizing the calls to clk_enable in one location as this is
> called from multiple files in Bridge code. This helps because one can then
> turn on the traces only for clock module to check if the clocks that were
> expected to be enabled are enabled or not. As I mentioned before, this
> helps in debugging.
> > >
> > > That only makes the code harder to understand.
> > >
> > > #define clk_enable(...) my_debug_function(__VA_ARGS__)
> > >
> > > Achieves the same thing.
> >
> > We must use clk_enable() and clk_disable() in the drivers. That's the
> > Linux clock interface. Anything else won't get merged upstream.
> >
> > If you need to combine multiple clocks into a single virtual dsp
> > clock, please register a new custom clock using clk_register().
> >
> > That allows you to do debugging in the custom clock functions too
> > if necessary.
> 
> I sent some patches based on the above suggestion.
> 
>   http://marc.info/?l=linux-omap&m=121922597019873&w=2
>   http://marc.info/?l=linux-omap&m=121922593919766&w=2
> 
> I think that this virtual clock may allow any arbitrary combination of
> clocks and it may be possible to have multiple hierarchy of virtual
> clocks like:
> 
>    dsp_clocks
>    |
>    |-- peripheral_clocks
>    |     |
>    |     |-- gpt5
>    |     |    |- gpt5_ick
>    |     |    `- gpt5_fck
>    |
>    |-- ....
>    ..
> 
> Any comments would be appreciated.
> 
>     Hiroshi DOYU
> 

