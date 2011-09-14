From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
Date: Wed, 14 Sep 2011 22:43:48 +0530
Message-ID: <4E70E0CC.80300@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com> <20110913203616.GG24252@atomide.com> <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com> <20110914152116.GM24252@atomide.com> <4E70DB33.5070501@ti.com> <20110914170803.GN24252@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34099 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757095Ab1INROA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 13:14:00 -0400
Received: by pzk37 with SMTP id 37so3626048pzk.29
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 10:13:58 -0700 (PDT)
In-Reply-To: <20110914170803.GN24252@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, "Woodruff, Richard" <r-woodruff2@ti.com>

On Wednesday 14 September 2011 10:38 PM, Tony Lindgren wrote:
> * Santosh<santosh.shilimkar@ti.com>  [110914 09:16]:
>>
>> First and foremost, I have to go with the approach here because MPUSS
>> hardware team put a requirement that GIC and wakeupgen should always be
>> kept in sync. If needed we can discuss this off-the list with Richard.
>>
>> Below is the extract from the veyron func specs.
>> -------------------------------------
>> Version 1.6 of veyron spec has this.
>>
>>  From page 95, paragraph 2 on version 1.6:
>>
>> "It is SW responsibility to program interrupt enabling/disabling
>> coherently in the GIC and in the Wugen enable registers. That is, a
>> given interrupt for a given CPU is either enable at both GIC and Wugen,
>> or disable at both, but no mix."
>> -------------------------------------
>>
>> The way understand this IP is, even in normal scenario's every IRQ
>> will come to wakeupgen and then it will pass that to GIC. CPU clock
>> domains are kept under HW supervised always and they can enter inactive
>> any time without WFI. Only wakeup gen can bring the CPU out of inactive
>> state.
>>
>> That's requirement really lead to this design choice. Just to add
>> all ARM SOC's using GIC has a gic extension interrupt controller and
>> follow the same approach for the secondary IRQCHIPO.
>
> Thanks for the clarification. It seems to me the spec is most likely
> wrong as we've had the GIC working for over two years now without
> doing anything with the wakeup gen registers :)
>
It's working because CPU clockdomain are never put under HW
supervised mode and they are kept in force wakeup. Clock-domain
never idles on mainline code. PM series will put the clock-domains
under HW supervison as needed to achieve any low power states and
then all sorts of corner cases will come out.

Regards
Santosh

