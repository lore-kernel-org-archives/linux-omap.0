From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v6 4/5] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Wed, 05 Dec 2012 19:43:03 +0100
Message-ID: <50BF95B7.8030404@gmail.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com> <1354204892-22762-5-git-send-email-zonque@gmail.com> <50B7BE9C.6040506@ti.com> <50B7C677.7090504@ti.com> <50B7C8BE.7050002@gmail.com> <50B7CCB1.6000506@ti.com> <50BF4670.8070602@gmail.com> <20121205171950.GF21682@atomide.com> <50BF83CA.5050007@gmail.com> <20121205174114.GH21682@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39470 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab2LESnI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 13:43:08 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2343222bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Dec 2012 10:43:06 -0800 (PST)
In-Reply-To: <20121205174114.GH21682@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>, x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, avinashphilip@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05.12.2012 18:41, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [121205 09:29]:
>> On 05.12.2012 18:19, Tony Lindgren wrote:
>>>
>>> The plat/cpu.h file will disappear after the merge window, which means
>>> omap2+ related drivers cannot use cpu_is_omap macros.
>>>
>>> For legacy booting systems, this flag should be just passed in the
>>> platform_data from the platform init code. Then device tree can
>>> deal with it based on the compatible flag.
>>>
>>
>> Ok, thanks for explaining.
>>
>> Does that mean this patch series should be postponed until after the
>> merge window and then build upon that change or should we merge the
>> patch in question here as is and then care for the cleanups after the
>> window?
> 
> Well to me it seems that you only have cpu_is_omap usage in
> arch/arm/mach-omap2/gpmc-nand.c, which will be OK. Only the code
> under drivers/* needs to be fixed for that. So your patches may
> be OK, but..
> 
>> I can also rebase this set on top of the removal patches if they exist
>> already somewhere.
> 
> ..please check that your patches work with current linux next.
> 
> It's too late to queue thing for v3.8 merge window at this point,
> as we want the patches sitting in linux next for a week at least
> before they get pulled.
> 
> And we still need the acks for the device tree binding as well.

Ok, I'll resubmit a v7 with the nits fixed that Jon pointed out, and
then hope for the maintainer's Acks.

> So let's plan on queueing these after -rc1.

No problem really. The only thing is that I'll be on vacation when the
merge window closes, hence I'd appreciate if you could already queue
them up on your side, so they'll be taken care for :)


Daniel

