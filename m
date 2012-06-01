From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 05/11] mfd: omap: control: core system control driver
Date: Fri, 1 Jun 2012 20:30:35 +0800
Message-ID: <CAMQu2gyn_Fir=Jp0cQR_t7yc_JkwajFMvR1yDx-VYv9JOOwivw@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
 <4FBF8078.9050809@ti.com> <20120528113502.GG3923@besouro> <4FC4CE4B.8020708@ti.com>
 <20120601112951.GM12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47220 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759545Ab2FAMa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 08:30:57 -0400
Received: by qcsq13 with SMTP id q13so1448929qcs.3
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 05:30:55 -0700 (PDT)
In-Reply-To: <20120601112951.GM12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, eduardo.valentin@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, paul@pwsan.com, balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, J Keerthy <j-keerthy@ti.com>

On Fri, Jun 1, 2012 at 7:29 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Cousson, Benoit <b-cousson@ti.com> [120529 06:29]:
>> On 5/28/2012 1:35 PM, Eduardo Valentin wrote:
>> >>
>> >>Mmm, we can have up to 4 control module instances in OMAP4.
>> >>
>> >>Well, I'm not sure it worth considering them as separate devices. Is
>> >>that your plan as well?
>> >
>> >At least for now I was focusing on the ctrl_module_core ...
>>
>> OK, that's a good start already :-)
>>
>> >>But since they all have different base address, it will be trick to
>> >>handle them with only a single entry.
>> >
>> >Indeed. We can always add the support latter on.
>> >
>> >I am not sure what would be the best way to handle those instances though,
>> >and how they are going to expose APIs. Would need to have an instance bound
>> >to API set?
>>
>> We should not go to that path I guess. We should have an API at
>> children level independent of the underlying control module
>> partitioning.
>
> These should be separate driver instances for the control modules.
>
> And then the ioremapped area should ignore at least the padconf
> registers so drivers/pinctrl/pinctrl-simple can handle those. There
> should not be any dependencies to the SCM driver from pinctrl-simple,
> the core SCM driver can manage the clocks and trigger the save of
> padconf regs.
>
> Also we should allow MMC driver handle the MMC specific registers
> and USB driver(s) handle the USB specific registers if possible. Those
> should not live under drivers/mfd unless there are some dependencies
> other than trying to ioremap the whole SCM module instead of ioremapping
> in each driver.
>
> We can have a static map for the SCM, so ioremapping each driver
> individually should not be an issue.
>
This sounds a good idea. With this we may not even need a core control
module drivers if all the individual drivers take care of the registers they
care. Mapping shouldn't be a problem as you mentioned.

Regards
Santosh
