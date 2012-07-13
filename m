From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Fri, 13 Jul 2012 09:07:41 -0500
Message-ID: <50002BAD.3010600@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <20120713140021.GS18079@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60973 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab2GMOHz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 10:07:55 -0400
In-Reply-To: <20120713140021.GS18079@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Will,

On 07/13/2012 09:00 AM, Will Deacon wrote:
> Jon,
> 
> [cutting out realms of context!]

Thanks! My inbox thanks you too ;-)

> On Fri, Jul 13, 2012 at 02:54:59PM +0100, Jon Hunter wrote:
>> Another proposal I also thought of is re-working the flags to describe
>> the HW mode to be used when turning on the CLKDM, when the CLKDM is
>> active and when the CLKDM is shut down. So instead of saying what modes
>> the CLKDM supports, specify what modes should be used for pre-ON (i.e.
>> turn ON), ON and OFF. Right now software is trying to decide for us by
>> what is available (which is ideal) but makes working around such nuances
>> a little more painful.
>>
>> By the way, I did do some testing on OMAP3, but I don't recall now
>> whether I was having such problems with OMAP3. I need to go back and
>> test perf again on OMAP3 to see if such a flag is needed.
> 
> If you do test on OMAP3, please kill the OMAP3_EMU option as I think this
> has the effect of keeping the EMU power domain up via the etm code (look at
> etb_probe).
> 
> Will
> 
> ---8<---
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a91009c..d02054c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1139,8 +1139,7 @@ config XSCALE_PMU
>         default y
>  
>  config CPU_HAS_PMU
> -       depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
> -                  (!ARCH_OMAP3 || OMAP3_EMU)
> +       depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU)
>         default y
>         bool

Ah-ha! May be this is why is worked without issue. I will look at that
and check the power states. I must admit that my testing was quick to
ensure no breakages but no thorough to check what was going on with power.

Cheers
Jon



