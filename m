From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 17/18][V3] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Fri, 04 May 2012 01:03:32 +0200
Message-ID: <4FA30EC4.6090405@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org> <1335276339-11135-18-git-send-email-daniel.lezcano@linaro.org> <87wr4tj96h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43991 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758952Ab2ECXDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 19:03:34 -0400
Received: by were53 with SMTP id e53so1424173wer.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 16:03:33 -0700 (PDT)
In-Reply-To: <87wr4tj96h.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 05/03/2012 10:34 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> Define a CPU_IDLE section in the makefile, declare the functions in
>> the header files conforming to the kernel coding rules and remove th=
e
>> 'define's in the C files.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>
> This patch breaks compilation for the !CONFIG_PM case:
>
>     arch/arm/mach-omap2/built-in.o: In function `__omap3_enter_idle':
>     /work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle34xx.c:121: undef=
ined reference to `omap_sram_idle'
>
> Since you moved this stuff out of a CONFIG_PM conditional part of the
> Makefile, it broke because pm34xx.c is still compiled conditionally o=
n
> CONFIG_PM.
>
> When changing Makefile/Kconfig dependencies like this, please
> be sure to at least compile test with the various options
> enabled/disabled.
>
> For now, I've dropped this patch from the series.  Feel free to
> update/retest/resend since the idea is fine.

Ok, I will update it with the various options.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
