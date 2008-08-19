From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 13:24:45 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E129DEDAB@dlee03.ent.ti.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
 <5d5443650808181017w1ad90b9vcc6cc4d8abc6a963@mail.gmail.com>
 <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
 <94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
 <20080819062422.GD17276@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57089 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbYHSSY6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 14:24:58 -0400
In-Reply-To: <20080819062422.GD17276@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi All,

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


--- The clock manager in DSP Bridge is in charge of translating the clock requests that come from tasks that are running on DSP to the clk structure that is understandable to the kernel's clk_enable function.

The request for clocks from DSP side of the Bridge comes in the form of the clock ids that are defined in clk.h (The Bridge clk.h file). So, for example, if the DSP task wants GPT6 clocks to be enabled, then a request comes to MPU Bridge with the id for that clock. The Clock module in the MPU Bridge does an internal lookup to translate this id to the proper clock structure and then calls the kernel's clk_enable function with this clock structure as the argument. So, in a way we can call this clock module as the clock manager.

One another reason for centralizing the calls to kernel's clk_enable function in one module is to debug the cases where a task running on the DSP is expecting some clock to be enabled but it might not have been enabled. 

Example: If there is an issue with the load monitoring not working as expected on the DSP, the first thing you may want to check is if the clocks that are used for the load monitoring is enabled or not. The easiest way is just enabling the traces only for clock module and based on that you can tell if the right clocks were enabled or not.  This feature is extremely useful when debugging multimedia test cases, where there are multiple tasks running on DSP sending requests to clocks.

Refer to clk.c and clk.h files in DSP Bridge.

I suggest we keep this clock module in DSP Bridge. May be we can change its name to dsp clock manager if that makes more sense.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, August 19, 2008 1:24 AM
> To: Felipe Contreras
> Cc: Kanigeri, Hari; Trilok Soni; Pasam, Vijay; Hiroshi DOYU; linux-
> omap@vger.kernel.org; Woodruff, Richard; siarhei.siamashka@nokia.com;
> Ramirez Luna, Omar; Gupta, Ramesh
> Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
> 
> * Felipe Contreras <felipe.contreras@gmail.com> [080818 23:09]:
> > On Mon, Aug 18, 2008 at 10:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > >> If you mean there is separate clock infrastructure for DSPBridge
> other
> > >> than clock framework we have for OMAP, then DSPBridge should convert
> > >> to the one we have for OMAP. As recent work by Paul for clock
> > >> framework on OMAP3 and Power domains we need centralized code for clk
> > >> and power domains not separate clock infrastructure for DSPBridge.
> > >>
> > > --- Bridge is not implementing separate clock infrastructure. It is
> just centralizing the calls to clk_enable in one location as this is
> called from multiple files in Bridge code. This helps because one can then
> turn on the traces only for clock module to check if the clocks that were
> expected to be enabled are enabled or not. As I mentioned before, this
> helps in debugging.
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
> 
> Regards,
> 
> Tony

