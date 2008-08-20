From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Wed, 20 Aug 2008 17:34:51 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E12EC5718@dlee03.ent.ti.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
	 <5d5443650808181017w1ad90b9vcc6cc4d8abc6a963@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
	 <94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
	 <20080819062422.GD17276@atomide.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E129DEDAB@dlee03.ent.ti.com>
	 <94a0d4530808191210q59b7ed5ao7601efa553b60f3f@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E129DF01B@dlee03.ent.ti.com>
 <94a0d4530808191645xad82696v2af9980bd6fed741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60576 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753580AbYHTWhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 18:37:03 -0400
In-Reply-To: <94a0d4530808191645xad82696v2af9980bd6fed741@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Felipe,

> We are trying to understand why this is not just a wrapper.

-- Thank you :)

> b) the clock init does the job of obtaining the references to the
> clock ids in its initialization
> 
> Those could be initialized in some other place as well.
>
-- Why can't this some other place be the init function in the current clock module in Bridge ?

> How exactly is "clk_enable(BPWR_Clks[clkIdIndex].intClk)" less
> readable than "CLK_Enable(BPWR_Clks[clkIdIndex].intClk)" ?

-- Did you check the argument of CLK_Enable function ? The argument is not the same as you mentioned above?  One more reason to say that this is not a direct wrapper ;). 

But that's not my point when I mentioned about readability. By removing the code from clk.c and scattering it around will make it difficult to follow and manage the code. I think we can even move the DSPPeripheralClkCtrl function in tiomap_pwr.c to clk.c so that all the clock interfaces from DSP Bridge are in one file, and we can rename this file to bridge_clk_mgr to avoid the impression that clk module in Bridge is implementing its own clock framework or the functions are just acting as wrappers. I think this approach is clean and easy to manage. I see a placeholder for dspbridge clock module considering the number of clocks it has to manage.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Tuesday, August 19, 2008 6:46 PM
> To: Kanigeri, Hari
> Cc: Tony Lindgren; Trilok Soni; Pasam, Vijay; Hiroshi DOYU; linux-
> omap@vger.kernel.org; Woodruff, Richard; siarhei.siamashka@nokia.com;
> Ramirez Luna, Omar; Gupta, Ramesh
> Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
> 
> Hi Hari,
> 
> On Tue, Aug 19, 2008 at 11:46 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > Felipe,
> >
> > Thanks for your comments.
> >
> >> DSPPeripheralClkCtrl is already mapping some clock ids to some other
> >> clock ids (SERVICES_ClkId) before calling the functions in clk.c. This
> >> clk_enable/disable can be called there.
> >
> > - DSPPeripheralClkCtrl is used for managing the peripheral clock
> requests that come from DSP. You cannot use this function to enable IVA2
> and mailbox clocks.
> 
> That's right, you call clk_enable directly for iva2 and mailbox
> clocks. You already know the clock, no need to translate.
> 
> > Felipe, I see your point of removing the clock module, but please don't
> view this just as a wrapper; it provides more functionality than just
> being the direct wrapper. It does hide the implementation to translate the
> clock id to kernel clock structure, the clock init does the job of
> obtaining the references to the clock ids in its initialization, and more
> importantly isolates the tracing to one module.
> 
> We are trying to understand why this is not just a wrapper.
> 
> a) It does hide the implementation to translate the clock id to kernel
> clock structure
> 
> I already mentioned that DSPPeripheralClkCtrl is doing that translation.
> 
> {(u32) BPWR_GPTimer5, SERVICESCLK_gpt5_fck, SERVICESCLK_gpt5_ick},
> 
> Those SERVICESCLK_* are used to find the clk handle, but if you
> already have BPWR_GPTimer5 you know which clk handles you need, why
> not store them in some place where DSPPeripheralClkCtrl can find them?
> 
> if (BPWR_GPTimer5) { clk_enable(gpt5_fck_handle);
> clk_enable(gpt5_ick_handle); }
> 
> Or if you store the clk handle directly into the BPWR_Clk_t structure:
> 
> clk_enable(BPWR_Clks[clkIdIndex].intClk);
> clk_enable(BPWR_Clks[clkIdIndex].funClk);
> 
> b) the clock init does the job of obtaining the references to the
> clock ids in its initialization
> 
> Those could be initialized in some other place as well.
> 
> c) and more importantly isolates the tracing to one module.
> 
> I already mentioned how to enable debugging while using clk_enable,
> just enable a macro with the same name.
> 
> > There are multiple ways to implement, and yes we can remove the clock
> module in Bridge and move the code in these functions to other places, but
> in the end we will have the new code that has lesser code readability and
> debugging ability :).
> 
> How exactly is "clk_enable(BPWR_Clks[clkIdIndex].intClk)" less
> readable than "CLK_Enable(BPWR_Clks[clkIdIndex].intClk)" ?
> 
> >> Didn't Tony just explained how to do that without a wrapper?
> > -- I was under the impression that Tony is thinking that the DSP Bridge
> is not calling kernel's clk_enable function. My above explanation holds
> here about the wrappers.
> 
> I'm not sure, but in any case I also explained an alternative.
> 
> Best regards.
> 
> --
> Felipe Contreras

