From: Rob Herring <rob.herring@linaro.org>
Subject: Re: [PATCH] ARM: omap: rework platform selection
Date: Mon, 16 Jun 2014 10:53:17 -0500
Message-ID: <CABGGisxdKznLzR+0b0oYrN+aiWM0gNFbzYwfPtAZF=AiapU=eQ@mail.gmail.com>
References: <5701099.0P1SIXsHc1@wuerfel> <20140616110042.GD17845@atomide.com>
 <7892694.KrnV5uCBX6@wuerfel> <20140616112610.GE17845@atomide.com> <20140616141712.GL17845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:63990 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbaFPPxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 11:53:39 -0400
Received: by mail-la0-f41.google.com with SMTP id hz20so3173743lab.0
        for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2014 08:53:38 -0700 (PDT)
In-Reply-To: <20140616141712.GL17845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, arm@kernel.org

On Mon, Jun 16, 2014 at 9:17 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [140616 04:31]:
>> * Arnd Bergmann <arnd@arndb.de> [140616 04:18]:
>> >
>> > Let's see if others have similar opinions Rob's patch as a whole.
>> > I'd still like to keep all the parts aside from the OMAP change
>> > and just back out the change that caused the problems.
>> >
>> > Does that seem reasonable to you?
>>
>> Yes makes sense to me if others don't have similar issues. I guess
>> it should be possible to verify that by diffing the generated
>> .config files compared to the old ones.

Other than exynos (which is new to MP) and OMAP, the rest are
straightforward user config to menuconfig conversions.

> If you update Rob's patch and undo the omap2+ changes, you might
> want to fold in something like the following to hide the omap
> options behind a menu.

This or reverting the OMAP part seems like the best change for now.

> So far I have not come up with no great ideas on fixing this
> properly short of requiring all omap .config files to add
> CONFIG_ARCH_OMAP=y manually. Anybody got good ideas for that?

I've failed to come up with anything...

Rob

>
> Regards,
>
> Tony
>
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -1,3 +1,5 @@
> +menu "TI OMAP/AM/DM/DRA Family"
> +
>  config ARCH_OMAP
>         bool
>
> @@ -342,3 +344,5 @@ config OMAP4_ERRATA_I688
>  endmenu
>
>  endif
> +
> +endmenu
