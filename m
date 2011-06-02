From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH v4 2/4] OMAP2+: cpufreq: use OPP library
Date: Thu, 2 Jun 2011 18:14:00 -0500
Message-ID: <BANLkTinJksT=PWAuXaKnuauixq_s=X7tfA@mail.gmail.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com> <1306463960-27340-3-git-send-email-nm@ti.com>
 <87zklzq2cs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48088 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755382Ab1FBXOW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jun 2011 19:14:22 -0400
Received: by mail-wy0-f178.google.com with SMTP id 33so1136818wyb.9
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 16:14:20 -0700 (PDT)
In-Reply-To: <87zklzq2cs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, Jun 2, 2011 at 17:45, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> OMAP2 is the only family using clk_[init|exit]_cpufreq_table, howeve=
r,
>> the cpufreq code has does not use clk_init_cpufreq_table. As a resul=
t,
>> it is unusuable for OMAP2 and only usable only on platforms using OP=
P
>> library.
>>
>> So move the compilation for cpufreq only if OPP is available for the
>> architecture and deny OMAP2 in multi-OMAP builds until OMAP2 is fixe=
d.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> I updated this patch slightly, preferring a more generic failure mode=
,
> namely just failing with a warning on init when no OPPs are present.
>
> I tested this on 3430/n900 by simply commenting out the
> omap_init_opp_table() for OMAP3. =A0CPUfreq init fails predictably wi=
th
>
> =A0 platform mpu.0: opp_init_cpufreq_table: Device OPP not found (-19=
)
> =A0 platform mpu.0: omap_cpu_init: cpu0: failed creating freq table[-=
19]
>
> So CPUfreq driver never gets registered.
>
> Updated patch below. =A0If you're OK with this change, I'll apply it =
to
> pm-wip/cpufreq.
>
> Kevin
>
>
> From 22f1704e2ec30816e34b3d46a4c61513441fce8d Mon Sep 17 00:00:00 200=
1
> From: Nishanth Menon <nm@ti.com>
> Date: Thu, 26 May 2011 19:39:18 -0700
> Subject: [PATCH 2/4] OMAP2+: cpufreq: only supports OPP library
>
> OMAP2 is the only family using clk_[init|exit]_cpufreq_table, however=
,
> the cpufreq code does not currently use clk_init_cpufreq_table. As a
> result, it is unusuable for OMAP2 and only usable only on platforms
> using OPP library.
>
> Remove the unbalanced clk_exit_cpufreq_table(). =A0Any platforms wher=
e
> OPPs are not availble will fail on init because a freq table will not
> be properly initialized.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> [khilman@ti.com: changelog edits, and graceful failure mode changes]
> Acked-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-=
omap2/omap2plus-cpufreq.c
> index acf18e8..3af7cda 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -1,7 +1,7 @@
> =A0/*
> =A0* =A0OMAP2PLUS cpufreq driver
> =A0*
> - * =A0CPU frequency scaling for OMAP
> + * =A0CPU frequency scaling for OMAP using OPP information
> =A0*
> =A0* =A0Copyright (C) 2005 Nokia Corporation
> =A0* =A0Written by Tony Lindgren <tony@atomide.com>
> @@ -203,7 +203,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq=
_policy *policy)
>
> =A0static int omap_cpu_exit(struct cpufreq_policy *policy)
> =A0{
> - =A0 =A0 =A0 clk_exit_cpufreq_table(&freq_table);
> =A0 =A0 =A0 =A0clk_put(mpu_clk);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.4
>
>
=46ine with me. thanks for it. it achieves what I needed as well :)

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
