From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Wed, 20 Aug 2008 02:45:53 +0300
Message-ID: <94a0d4530808191645xad82696v2af9980bd6fed741@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:20817 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbYHSXpy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 19:45:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so203027rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 16:45:53 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E129DF01B@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hari,

On Tue, Aug 19, 2008 at 11:46 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Felipe,
>
> Thanks for your comments.
>
>> DSPPeripheralClkCtrl is already mapping some clock ids to some other
>> clock ids (SERVICES_ClkId) before calling the functions in clk.c. This
>> clk_enable/disable can be called there.
>
> - DSPPeripheralClkCtrl is used for managing the peripheral clock requests that come from DSP. You cannot use this function to enable IVA2 and mailbox clocks.

That's right, you call clk_enable directly for iva2 and mailbox
clocks. You already know the clock, no need to translate.

> Felipe, I see your point of removing the clock module, but please don't view this just as a wrapper; it provides more functionality than just being the direct wrapper. It does hide the implementation to translate the clock id to kernel clock structure, the clock init does the job of obtaining the references to the clock ids in its initialization, and more importantly isolates the tracing to one module.

We are trying to understand why this is not just a wrapper.

a) It does hide the implementation to translate the clock id to kernel
clock structure

I already mentioned that DSPPeripheralClkCtrl is doing that translation.

{(u32) BPWR_GPTimer5, SERVICESCLK_gpt5_fck, SERVICESCLK_gpt5_ick},

Those SERVICESCLK_* are used to find the clk handle, but if you
already have BPWR_GPTimer5 you know which clk handles you need, why
not store them in some place where DSPPeripheralClkCtrl can find them?

if (BPWR_GPTimer5) { clk_enable(gpt5_fck_handle); clk_enable(gpt5_ick_handle); }

Or if you store the clk handle directly into the BPWR_Clk_t structure:

clk_enable(BPWR_Clks[clkIdIndex].intClk);
clk_enable(BPWR_Clks[clkIdIndex].funClk);

b) the clock init does the job of obtaining the references to the
clock ids in its initialization

Those could be initialized in some other place as well.

c) and more importantly isolates the tracing to one module.

I already mentioned how to enable debugging while using clk_enable,
just enable a macro with the same name.

> There are multiple ways to implement, and yes we can remove the clock module in Bridge and move the code in these functions to other places, but in the end we will have the new code that has lesser code readability and debugging ability :).

How exactly is "clk_enable(BPWR_Clks[clkIdIndex].intClk)" less
readable than "CLK_Enable(BPWR_Clks[clkIdIndex].intClk)" ?

>> Didn't Tony just explained how to do that without a wrapper?
> -- I was under the impression that Tony is thinking that the DSP Bridge is not calling kernel's clk_enable function. My above explanation holds here about the wrappers.

I'm not sure, but in any case I also explained an alternative.

Best regards.

-- 
Felipe Contreras
