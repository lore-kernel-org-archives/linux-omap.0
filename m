From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: Re: [RFC PATCH 05/11] mfd: omap: control: core system control driver
Date: Fri, 01 Jun 2012 17:40:25 +0400
Message-ID: <4FC8C649.10507@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com> <1337934361-1606-6-git-send-email-eduardo.valentin@ti.com> <4FBF8078.9050809@ti.com> <20120528113502.GG3923@besouro> <4FC4CE4B.8020708@ti.com> <20120601112951.GM12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:52164 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759842Ab2FANk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 09:40:27 -0400
In-Reply-To: <20120601112951.GM12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, paul@pwsan.com, amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, eduardo.valentin@ti.com, santosh.shilimkar@ti.com, J Keerthy <j-keerthy@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, amit.kachhap@linaro.org

  Hi, Tony.

On 06/01/2012 03:29 PM, Tony Lindgren wrote:
> * Cousson, Benoit <b-cousson@ti.com> [120529 06:29]:
>> On 5/28/2012 1:35 PM, Eduardo Valentin wrote:
>>>> Mmm, we can have up to 4 control module instances in OMAP4.
>>>>
>>>> Well, I'm not sure it worth considering them as separate devices. Is
>>>> that your plan as well?
>>> At least for now I was focusing on the ctrl_module_core ...
>> OK, that's a good start already :-)
>>
>>>> But since they all have different base address, it will be trick to
>>>> handle them with only a single entry.
>>> Indeed. We can always add the support latter on.
>>>
>>> I am not sure what would be the best way to handle those instances though,
>>> and how they are going to expose APIs. Would need to have an instance bound
>>> to API set?
>> We should not go to that path I guess. We should have an API at
>> children level independent of the underlying control module
>> partitioning.
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
Actually SCM registers window is mapped statically. Mapping is defined in omap44xx_io_desc[] in arch/arm/mach-omap2/io.c:

...
        .virtual    = L4_44XX_VIRT,
        .pfn        = __phys_to_pfn(L4_44XX_PHYS),
        .length        = L4_44XX_SIZE,
        .type        = MT_DEVICE,
...


So ioremap() always returns same virtual address (0xfc002000).

BR,
    Konstantin Baydarov.

>
> Regards,
>
> Tony
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

