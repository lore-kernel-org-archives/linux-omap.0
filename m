From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFT 1/3] ARM: OMAP2+: powerdomain: allow pre/post
 transtion to be per pwrdm
Date: Tue, 24 Apr 2012 20:01:42 +0530
Message-ID: <CAMQu2gyGziG6SHuFrSnPgxubLPN5Sr-ZF3giT8b--jcJvVPD=w@mail.gmail.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com> <1335277420-29124-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51552 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754971Ab2DXOcF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:32:05 -0400
Received: by qabg40 with SMTP id g40so108518qab.4
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:32:03 -0700 (PDT)
In-Reply-To: <1335277420-29124-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Apr 24, 2012 at 7:53 PM, Kevin Hilman <khilman@ti.com> wrote:
> Iteration over all power domains in the idle path is unnecessary sinc=
e
> only power domains that are transitioning need to be accounted for.
> Also PRCM register accesses are known to be expensive, so the
> additional latency added to the idle path is signficiant.
>
> In order allow the pre/post transitions to be isolated and called
> per-pwrdm, change the API so passing in a specific power domain will
> trigger the pre/post transtion accounting for only that specific powe=
r
> domain. =A0Passing NULL means iterating over all power domains as is
> current behavior.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c | =A0 =A04 ++--
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 ++--
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 | =A0 16 +++++++=
+++++----
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 | =A0 =A04 ++--
> =A04 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mac=
h-omap2/omap-mpuss-lowpower.c
> index 13670aa..e35a86b 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -255,7 +255,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsign=
ed int power_state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENXIO;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 pwrdm_pre_transition();
> + =A0 =A0 =A0 pwrdm_pre_transition(NULL);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Check MPUSS next state and save interrupt controlle=
r if needed.
> @@ -287,7 +287,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsign=
ed int power_state)
> =A0 =A0 =A0 =A0wakeup_cpu =3D smp_processor_id();
> =A0 =A0 =A0 =A0set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
>
> - =A0 =A0 =A0 pwrdm_post_transition();
> + =A0 =A0 =A0 pwrdm_post_transition(NULL);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}

Now since the   pwrdm_[pre\post]_transition() takes
power domain pointer, OMAP4 can limit this
to CPU and MPUSS PD's only.

Will create that patch on top of this series and test
it out.

Thanks for the API change.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
