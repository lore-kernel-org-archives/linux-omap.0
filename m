From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 14:42:07 +0100
Message-ID: <CABxcv=n+FSuZemxQb2=wFM8m6xmWUKACnrCWFG-LevToU_UVHg@mail.gmail.com>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
	<54991A25.2030804@compulab.co.il>
	<20141223161936.GA9147@saruman>
	<549AA94A.8030209@compulab.co.il>
	<20141224154948.GA423@saruman>
	<20141224190401.GN23854@atomide.com>
	<549BE333.9060709@compulab.co.il>
	<20141226044246.GB7661@saruman>
	<549D4CEA.6090009@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33035 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaLZNmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 08:42:09 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so17099588wiv.11
        for <linux-omap@vger.kernel.org>; Fri, 26 Dec 2014 05:42:07 -0800 (PST)
In-Reply-To: <549D4CEA.6090009@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hello all,

On Fri, Dec 26, 2014 at 12:56 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>>>> Tony, your call.
>>>>
>>>> I think we should move omap2plus_defconfig to be mostly modular and
>>>> usable for distros as a base. Most distros prefer to build almost
>>>> everything as loadable modules. And my preference is that we should
>>>> only keep the minimum rootfs for devices and serial support as
>>>> built-in and rely on initramfs for most drivers. And slowly move
>>>> also the remaining built-in drivers to be loadable modules.
>>>>
>>>> The reasons for having drivers as loadable modules are many. It
>>>> allows distros to use the same kernel for all the devices without
>>>> bloating the kernel. It makes developing drivers easier as just the
>>>> module needs to be reloaded. And loadable modules protect us from
>>>> cross-framework spaghetti calls in the kernel as the interfaces are
>>>> clearly defined.
>>>>

I do agree with Tony and Felipe that we should try to build as much
stuff as possible as a module instead of built-in to match what
distros do and what has been done for x86 for years.

However, if that's the case I wonder what's the point of having both
an omap2plus_defconfig and a multi_v7_defconfig? Would it make sense
to get rid of the SoC specific configs then and just use the single
ARMv7 defconfig for all SoCs with most of the options enabled as a
module?

FYI, some time ago I posted a patch to enable SBS-compliant batteries
support as a module for Exynos defconfig and was told to re-spin the
patch and enabling it as built-in instead since the most popular use
case for exynos_defconfig was development and people usually just copy
the kernel binary and not the modules [0].

So it seems that each ARM SoC community has a different opinion about
how things should be configured and do it differently.

>>
>> bullshit, you would never ship a product with omap2plus_defconfig. You'd
>> build your own at which point you would switch SATA to built-in.
>

There are different opinions but let please try to keep the discussion
constructive and use a polite tone.

>>>
>>> Right now, we tell our customers that they can use mainline with
>>> omap2plus_defconfig.
>>
>> that's the worst thing you can do.
>

I'm confused, Felipe said that customers should not base their config
from omap2plus_defconfig but AFAUI Tony's argument is exactly the
opposite, that everything should be configured as a module so distros
can use omap2plus_defconfig as a base. So, is or is not expected that
people will use omap2plus_defconfig as a base for their own config?

I think the problem is that there isn't an agreement about what is the
purpose of the per SoC (e.g: oma2plus_defconfig) and the multi_v7
defconfigs (or at least is not well documented since I could not find
it). So, IMHO this concern should be raised to the ARM SoC maintainers
and there should be an agreement in the ARM community as a whole about
how things should be configured on each defconfig, and all SoCs should
follow the agreed rule.

Otherwise it seems that the motivation for each kconfig symbol enabled
is just to make the workflow of the developer posting the patches
easier and wins whoever shouts louder.

Thanks a lot and best regards,
Javier

[0]: http://www.spinics.net/lists/arm-kernel/msg353808.html
