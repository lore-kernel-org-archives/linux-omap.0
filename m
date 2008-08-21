From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Thu, 21 Aug 2008 11:10:18 +0300
Message-ID: <94a0d4530808210110t38fb6e42x8760707b3a21e33@mail.gmail.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	 <5d5443650808181017w1ad90b9vcc6cc4d8abc6a963@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
	 <94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
	 <20080819062422.GD17276@atomide.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E129DEDAB@dlee03.ent.ti.com>
	 <94a0d4530808191210q59b7ed5ao7601efa553b60f3f@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E129DF01B@dlee03.ent.ti.com>
	 <94a0d4530808191645xad82696v2af9980bd6fed741@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E12EC5718@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:33377 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbYHUIKT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 04:10:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so838935rvb.1
        for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 01:10:18 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E12EC5718@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

On Thu, Aug 21, 2008 at 1:34 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Felipe,
>
>> We are trying to understand why this is not just a wrapper.
>
> -- Thank you :)
>
>> b) the clock init does the job of obtaining the references to the
>> clock ids in its initialization
>>
>> Those could be initialized in some other place as well.
>>
> -- Why can't this some other place be the init function in the current clock module in Bridge ?

That depends on what is left of clk.c after reorganization.

>> How exactly is "clk_enable(BPWR_Clks[clkIdIndex].intClk)" less
>> readable than "CLK_Enable(BPWR_Clks[clkIdIndex].intClk)" ?
>
> -- Did you check the argument of CLK_Enable function ? The argument is not the same as you mentioned above?  One more reason to say that this is not a direct wrapper ;).

Did you read what I wrote?

>> Or if you store the clk handle directly into the BPWR_Clk_t structure:
>>
>> clk_enable(BPWR_Clks[clkIdIndex].intClk);
>> clk_enable(BPWR_Clks[clkIdIndex].funClk);

So .intClk wouldn't be "enum SERVICES_ClkId", but "struct clk".

> But that's not my point when I mentioned about readability. By removing the code from clk.c and scattering it around will make it difficult to follow and manage the code. I think we can even move the DSPPeripheralClkCtrl function in tiomap_pwr.c to clk.c so that all the clock interfaces from DSP Bridge are in one file, and we can rename this file to bridge_clk_mgr to avoid the impression that clk module in Bridge is implementing its own clock framework or the functions are just acting as wrappers. I think this approach is clean and easy to manage. I see a placeholder for dspbridge clock module considering the number of clocks it has to manage.

If you see clk_enable there's nothing more to follow, so it's not hard
to follow. Others explained why virtual clocks make sense, which would
make the code even easier to follow.

The only two places where clock functions are used are tiomap3430.c
and tiomap3430_pwr.c. In tiomap3430.c, clk_enable functions can be
used directly, there's no translation needed, and I already explained
before, you can add debugging quite easily, so no need of clk.c for
that. In tiomap3430_pwr.c the translation can happen in
DSPPeripheralClkCtrl already, so again, no need of clk.c.

If you reorganize the code this way the only thing left in clk.c would
be clock initialization. I don't think it makes sense to keep one file
for one small function which would be even smaller with virtual
clocks.

Best regards.

-- 
Felipe Contreras
