From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 15:46:53 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E129DF01B@dlee03.ent.ti.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
	 <5d5443650808181017w1ad90b9vcc6cc4d8abc6a963@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
	 <94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
	 <20080819062422.GD17276@atomide.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E129DEDAB@dlee03.ent.ti.com>
 <94a0d4530808191210q59b7ed5ao7601efa553b60f3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:55303 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbYHSUrJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 16:47:09 -0400
In-Reply-To: <94a0d4530808191210q59b7ed5ao7601efa553b60f3f@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Felipe,

Thanks for your comments.

> DSPPeripheralClkCtrl is already mapping some clock ids to some other
> clock ids (SERVICES_ClkId) before calling the functions in clk.c. This
> clk_enable/disable can be called there.

- DSPPeripheralClkCtrl is used for managing the peripheral clock requests that come from DSP. You cannot use this function to enable IVA2 and mailbox clocks. 
Felipe, I see your point of removing the clock module, but please don't view this just as a wrapper; it provides more functionality than just being the direct wrapper. It does hide the implementation to translate the clock id to kernel clock structure, the clock init does the job of obtaining the references to the clock ids in its initialization, and more importantly isolates the tracing to one module. 
There are multiple ways to implement, and yes we can remove the clock module in Bridge and move the code in these functions to other places, but in the end we will have the new code that has lesser code readability and debugging ability :). 

> Didn't Tony just explained how to do that without a wrapper?
-- I was under the impression that Tony is thinking that the DSP Bridge is not calling kernel's clk_enable function. My above explanation holds here about the wrappers.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Tuesday, August 19, 2008 2:10 PM
> To: Kanigeri, Hari
> Cc: Tony Lindgren; Trilok Soni; Pasam, Vijay; Hiroshi DOYU; linux-
> omap@vger.kernel.org; Woodruff, Richard; siarhei.siamashka@nokia.com;
> Ramirez Luna, Omar; Gupta, Ramesh
> Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
> 
> On Tue, Aug 19, 2008 at 9:24 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > Hi All,
> >
> >> >
> >> > That only makes the code harder to understand.
> >> >
> >> > #define clk_enable(...) my_debug_function(__VA_ARGS__)
> >> >
> >> > Achieves the same thing.
> >>
> >> We must use clk_enable() and clk_disable() in the drivers. That's the
> >> Linux clock interface. Anything else won't get merged upstream.
> >>
> >> If you need to combine multiple clocks into a single virtual dsp
> >> clock, please register a new custom clock using clk_register().
> >>
> >> That allows you to do debugging in the custom clock functions too
> >> if necessary.
> >
> >
> > --- The clock manager in DSP Bridge is in charge of translating the
> clock requests that come from tasks that are running on DSP to the clk
> structure that is understandable to the kernel's clk_enable function.
> >
> > The request for clocks from DSP side of the Bridge comes in the form of
> the clock ids that are defined in clk.h (The Bridge clk.h file). So, for
> example, if the DSP task wants GPT6 clocks to be enabled, then a request
> comes to MPU Bridge with the id for that clock. The Clock module in the
> MPU Bridge does an internal lookup to translate this id to the proper
> clock structure and then calls the kernel's clk_enable function with this
> clock structure as the argument. So, in a way we can call this clock
> module as the clock manager.
> 
> DSPPeripheralClkCtrl is already mapping some clock ids to some other
> clock ids (SERVICES_ClkId) before calling the functions in clk.c. This
> clk_enable/disable can be called there.
> 
> > One another reason for centralizing the calls to kernel's clk_enable
> function in one module is to debug the cases where a task running on the
> DSP is expecting some clock to be enabled but it might not have been
> enabled.
> >
> > Example: If there is an issue with the load monitoring not working as
> expected on the DSP, the first thing you may want to check is if the
> clocks that are used for the load monitoring is enabled or not. The
> easiest way is just enabling the traces only for clock module and based on
> that you can tell if the right clocks were enabled or not.  This feature
> is extremely useful when debugging multimedia test cases, where there are
> multiple tasks running on DSP sending requests to clocks.
> 
> Didn't Tony just explained how to do that without a wrapper?
> 
> Best regards.
> 
> --
> Felipe Contreras

