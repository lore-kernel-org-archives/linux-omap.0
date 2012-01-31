From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
Date: Tue, 31 Jan 2012 12:27:15 +0530
Message-ID: <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:44900 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751669Ab2AaG5g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 01:57:36 -0500
Received: by qadz30 with SMTP id z30so2648679qad.6
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 22:57:35 -0800 (PST)
In-Reply-To: <878vkopw2o.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Tue, Jan 31, 2012 at 5:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>
>> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
>> pwrdm_pre_transition(), which appears a few lines after these calls,
>> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's =
no
>> need to do it twice.
>
> It looks like these two for OMAP4 are surpurfluous since the immediat=
ely
> follow a call to pwrdm_pre_transition() as well.
>
> Santosh/Rajendra, please confirm/ack.
>
> Kevin
>
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mac=
h-omap2/omap-mpuss-lowpower.c
> index 1d5d010..bbabe1d 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -263,12 +263,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsi=
gned int power_state)
> =A0 =A0 =A0 =A0 * In MPUSS OSWR or device OFF, interrupt controller =A0=
contest is lost.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0mpuss_clear_prev_logic_pwrst();
> - =A0 =A0 =A0 pwrdm_clear_all_prev_pwrst(mpuss_pd);
> =A0 =A0 =A0 =A0if ((pwrdm_read_next_pwrst(mpuss_pd) =3D=3D PWRDM_POWE=
R_RET) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pwrdm_read_logic_retst(mpuss_pd) =3D=3D=
 PWRDM_POWER_OFF))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0save_state =3D 2;
>
> - =A0 =A0 =A0 clear_cpu_prev_pwrst(cpu);
> =A0 =A0 =A0 =A0cpu_clear_prev_logic_pwrst(cpu);
> =A0 =A0 =A0 =A0set_cpu_next_pwrst(cpu, power_state);
> =A0 =A0 =A0 =A0set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume=
));

The power domain pre-transition and post transition calls were kept
under the CONFIG_PM_DEBUG in the first few versions of the patches.
These pre and post
transition use to take lot of time once in while when measurement were
done and the only
useful thing they were doing was the counter updates. Later I removed
the PM_DEBUG as
per your suggestion.

As per Pauls comment they are optimised, so that should be good.

In this code the need is to clear only CPU and MPUPD, and hence they ar=
e
explicitly cleared since the pre/post transition calls can be moved to =
PM_DEBUG
in production kernels.

But as you stated in current mainline kernel they are superfluous since=
 the
pre/post calls are not under PM debug. So I am ok either way

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
