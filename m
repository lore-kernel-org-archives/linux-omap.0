From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: ipu and dsp to use parent clocks
 instead of leaf clocks
Date: Thu, 15 Nov 2012 09:10:31 -0600
Message-ID: <CALLhW=6uwCzAwPLNbjOwVKWVW5KOui=UXZdTUm7HMp=3cZrCNg@mail.gmail.com>
References: <1352860750-20100-1-git-send-email-omar.luna@linaro.org>
	<alpine.DEB.2.00.1211141542280.16047@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52273 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768211Ab2KOPKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:10:32 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1746737vbb.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 07:10:31 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211141542280.16047@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 14 November 2012 09:44, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 13 Nov 2012, Omar Ramirez Luna wrote:
>
>> This prevents hwmod _enable_clocks...omap2_dflt_clk_enable path
>> from enabling modulemode inside CLKCTRL using its clk->enable_reg
>> field. Instead is left to _omap4_enable_module though soc_ops, as
>> the one in charge of this setting.
>>
>> According to comments received[1] for related patches the idea is
>> to get rid of leaf clocks in future. So remove these two while at it.
>>
>> [1] http://lkml.org/lkml/2012/8/20/226
>>
>> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
>
> Does this one belong as part of the "OMAP: iommu: hwmod, reset
> handling and runtime PM" series?  Looks like applying this one separately
> might cause these clocks not to be disabled by either the clock code's
> disable-unused-clocks code, or the hwmod code?

You are right, if applied right now, without the others it will break
the current clocks iommu code uses.

I will put it along with the other series or wait for the acceptance
of the other patches first.

Thanks,

Omar
