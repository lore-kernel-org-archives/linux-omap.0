From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix prm2xxx_3xxx.c INT_34XX_PRCM_MPU_IRQ
 build error
Date: Thu, 9 Feb 2012 21:05:57 +0100
Message-ID: <4F342725.5050704@ti.com>
References: <4F3417F5.2090901@ti.com> <20120209191547.GD19159@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40248 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235Ab2BIUGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 15:06:07 -0500
In-Reply-To: <20120209191547.GD19159@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "Kristo, Tero" <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2/9/2012 8:15 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 09, 2012 at 08:01:09PM +0100, Cousson, Benoit wrote:
>> If CONFIG_OF is not defined, the following error will happen.
>>
>> arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error:
>>   =E2=80=98INT_34XX_PRCM_MPU_IRQ=E2=80=99 undeclared here (not in a =
function)
>>
>> This is due to some hidden headers path from linux/of.h to plat/irqs=
=2Eh
>> already reported by Russell for prm4xxx.c.
>
> I have the following commit from mainline.  I suspect you have an old
> tree.

OK, it was part of the fixes Tony sent for for v3.3-rc2 but that are=20
were not in mainline until now.
I've just pulled -rc3 and this is indeed there.

Thanks,
Benoit

>
> Note: for the next merge window, I'm removing the asm/irq.h include f=
rom
> asm/prom.h so that this kind of thing doesn't happen in the future.
>
> commit d19e8f2e44a34b2a461f67ce9d0cb5bd43197c1e
> Author: Paul Walmsley<paul@pwsan.com>
> Date:   Wed Jan 25 12:57:49 2012 -0700
>
>      ARM: OMAP2/3: PRM: fix missing plat/irqs.h build breakage
>
>      Commit 22f51371f8c35869ed850f46aa76b6cc2b502110 ("ARM: OMAP3: pm=
: use
>      prcm chain handler") breaks the build on a 2420-only config, due=
 to
>      a missing include for plat/irqs.h:
>
>        CC      arch/arm/mach-omap2/prm2xxx_3xxx.o
>      arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error: 'INT_34XX_PRCM_=
MPU_IRQ' undeclared here (not in a function)
>
>      Fix by explicitly including it.
>
>      Signed-off-by: Paul Walmsley<paul@pwsan.com>
>      Cc: Tero Kristo<t-kristo@ti.com>
>      Cc: Kevin Hilman<khilman@ti.com>
>
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2=
/prm2xxx_3xxx.c
> index c1c4d86..9ce7654 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -19,6 +19,7 @@
>   #include "common.h"
>   #include<plat/cpu.h>
>   #include<plat/prcm.h>
> +#include<plat/irqs.h>
>
>   #include "vp.h"
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
