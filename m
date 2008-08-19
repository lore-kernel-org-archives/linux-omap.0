From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RFC][DRAFT] TODO list for TI DSP BRIDGE
Date: Tue, 19 Aug 2008 22:10:02 +0300
Message-ID: <94a0d4530808191210q59b7ed5ao7601efa553b60f3f@mail.gmail.com>
References: <20080818.163519.194678809.Hiroshi.DOYU@nokia.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E03434FF2@dlee15.ent.ti.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B3121EE@dlee03.ent.ti.com>
	 <5d5443650808181017w1ad90b9vcc6cc4d8abc6a963@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E0B38DC7B@dlee03.ent.ti.com>
	 <94a0d4530808181308i53a9b11fyb20af0b21785c0d9@mail.gmail.com>
	 <20080819062422.GD17276@atomide.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E129DEDAB@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:1524 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYHSTKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 15:10:03 -0400
Received: by rv-out-0506.google.com with SMTP id k40so102979rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 12:10:03 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E129DEDAB@dlee03.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "siarhei.siamashka@nokia.com" <siarhei.siamashka@nokia.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

On Tue, Aug 19, 2008 at 9:24 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi All,
>
>> >
>> > That only makes the code harder to understand.
>> >
>> > #define clk_enable(...) my_debug_function(__VA_ARGS__)
>> >
>> > Achieves the same thing.
>>
>> We must use clk_enable() and clk_disable() in the drivers. That's the
>> Linux clock interface. Anything else won't get merged upstream.
>>
>> If you need to combine multiple clocks into a single virtual dsp
>> clock, please register a new custom clock using clk_register().
>>
>> That allows you to do debugging in the custom clock functions too
>> if necessary.
>
>
> --- The clock manager in DSP Bridge is in charge of translating the clock requests that come from tasks that are running on DSP to the clk structure that is understandable to the kernel's clk_enable function.
>
> The request for clocks from DSP side of the Bridge comes in the form of the clock ids that are defined in clk.h (The Bridge clk.h file). So, for example, if the DSP task wants GPT6 clocks to be enabled, then a request comes to MPU Bridge with the id for that clock. The Clock module in the MPU Bridge does an internal lookup to translate this id to the proper clock structure and then calls the kernel's clk_enable function with this clock structure as the argument. So, in a way we can call this clock module as the clock manager.

DSPPeripheralClkCtrl is already mapping some clock ids to some other
clock ids (SERVICES_ClkId) before calling the functions in clk.c. This
clk_enable/disable can be called there.

> One another reason for centralizing the calls to kernel's clk_enable function in one module is to debug the cases where a task running on the DSP is expecting some clock to be enabled but it might not have been enabled.
>
> Example: If there is an issue with the load monitoring not working as expected on the DSP, the first thing you may want to check is if the clocks that are used for the load monitoring is enabled or not. The easiest way is just enabling the traces only for clock module and based on that you can tell if the right clocks were enabled or not.  This feature is extremely useful when debugging multimedia test cases, where there are multiple tasks running on DSP sending requests to clocks.

Didn't Tony just explained how to do that without a wrapper?

Best regards.

-- 
Felipe Contreras
