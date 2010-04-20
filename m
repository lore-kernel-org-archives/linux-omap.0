From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v3 0.1/5(7)] OMAP: add missing FIQ_START definition required for arch/arm/kernel/fiq.c compilation (was: OMAP: add missing FIQ_START definition required for arch/arm/plat-omap/fiq.c compilation)
Date: Tue, 20 Apr 2010 11:14:27 +0200
Message-ID: <201004201114.29198.jkrzyszt@tis.icnet.pl>
References: <201004150419.05038.jkrzyszt@tis.icnet.pl> <201004150423.06202.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:36066 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754065Ab0DTJRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 05:17:41 -0400
In-Reply-To: <201004150423.06202.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li

Thursday 15 April 2010 04:23:04 Janusz Krzysztofik napisa=C5=82(a):
> Several ARM platforms/machines that use FIQ define their value of
> FIQ_START. Since FIQ is not implemented for OMAP yet, this definition=
 is
> missing from OMAP header files.
>
> Put an arbitrary value for FIQ_START into plat/irqs.h for OMAP. Even =
if not
> used by the WiP FIQ handler for Amstrad Delta, this is required for
> successfull compilation of arch/arm/plat-omap/fiq.c that provides sev=
eral
> usefull functions.


Hi,
I've just noticed that I messsed up the file name. It's arch/arm/kernel=
/fiq.c=20
that does not compile without platform provided FIQ_START definition.=20
Sorry for this.

Thanks,
Janusz

> Even if prepended in front of the Amstrad Delta FIQ patch set, can be
> applied alone in advance as well, possibly as a fix.
>
> Created and tested against linux-2.6.34-rc4.
>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>
>  arch/arm/plat-omap/include/plat/irqs.h |    4 ++++
>  1 file changed, 4 insertions(+)
>
> --- git.orig/arch/arm/plat-omap/include/plat/irqs.h	2010-04-14 03:07:=
16.000000000 +0200
> +++ > git/arch/arm/plat-omap/include/plat/irqs.h	2010-04-14 22:28:05.=
000000000 +0200
> @@ -430,4 +430,8 @@ void omap3_intc_resume_idle(void);=20
>
>  #include <mach/hardware.h>
>
> +#ifdef CONFIG_FIQ
> +#define FIQ_START		1024
> +#endif
> +
>  #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
