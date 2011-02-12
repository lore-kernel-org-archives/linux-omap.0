From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 6/6] ARM: pm: allow generic sleep code to be used with SMP
 CPU idle
Date: Fri, 11 Feb 2011 18:52:55 -0800
Message-ID: <AANLkTik=NTwJHo7CfmbJm+MwjdVPQnvV96fpmk3ymcAL@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:62745 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758199Ab1BLCw7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 21:52:59 -0500
Received: from kpbe16.cbf.corp.google.com (kpbe16.cbf.corp.google.com [172.25.105.80])
	by smtp-out.google.com with ESMTP id p1C2qvka003819
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:52:57 -0800
Received: from vxa40 (vxa40.prod.google.com [10.241.33.40])
	by kpbe16.cbf.corp.google.com with ESMTP id p1C2qtnb005124
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:52:56 -0800
Received: by vxa40 with SMTP id 40so1741402vxa.2
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 18:52:55 -0800 (PST)
In-Reply-To: <E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 8:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Allow the generic sleep code to be used with SMP CPU idle by storing
> N CPU stack pointers rather than just one.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0arch/arm/kernel/sleep.S | =A0 26 +++++++++++++++++++++++++-
> =A01 files changed, 25 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 9f106fa..e10618f 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -25,7 +25,14 @@ ENTRY(cpu_suspend)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r1, r2, r3, ip} =A0 @ save v:p, virt S=
P, retfn, phys resume fn
> =A0 =A0 =A0 =A0ldr =A0 =A0 r3, =3Dsleep_save_sp
> =A0 =A0 =A0 =A0add =A0 =A0 r2, sp, r1 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ co=
nvert SP to phys
> +#ifdef CONFIG_SMP
> + =A0 =A0 =A0 ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
> + =A0 =A0 =A0 ALT_UP(mov lr, #0)
> + =A0 =A0 =A0 and =A0 =A0 lr, lr, #15
> + =A0 =A0 =A0 str =A0 =A0 r2, [r3, lr, lsl #2] =A0 =A0@ save phys SP
> +#else
> =A0 =A0 =A0 =A0str =A0 =A0 r2, [r3] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
save phys SP
> +#endif
> =A0 =A0 =A0 =A0mov =A0 =A0 lr, pc
> =A0 =A0 =A0 =A0ldr =A0 =A0 pc, [r10, #CPU_DO_SUSPEND] @ save CPU stat=
e
> =A0#else
> @@ -36,7 +43,14 @@ ENTRY(cpu_suspend)
> =A0 =A0 =A0 =A0stmfd =A0 sp!, {r1, r2, r3} =A0 =A0 =A0 @ save v:p, vi=
rt SP, return fn
> =A0 =A0 =A0 =A0ldr =A0 =A0 r3, =3Dsleep_save_sp
> =A0 =A0 =A0 =A0add =A0 =A0 r2, sp, r1 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ co=
nvert SP to phys
> +#ifdef CONFIG_SMP
> + =A0 =A0 =A0 ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
> + =A0 =A0 =A0 ALT_UP(mov lr, #0)
> + =A0 =A0 =A0 and =A0 =A0 lr, lr, #15
> + =A0 =A0 =A0 str =A0 =A0 r2, [r3, lr, lsl #2] =A0 =A0@ save phys SP
> +#else
> =A0 =A0 =A0 =A0str =A0 =A0 r2, [r3] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
save phys SP
> +#endif
> =A0 =A0 =A0 =A0bl =A0 =A0 =A0cpu_do_suspend
> =A0#endif
>
> @@ -96,7 +110,15 @@ cpu_resume_after_mmu:
> =A0 =A0 =A0 =A0.data
> =A0 =A0 =A0 =A0.align
> =A0ENTRY(cpu_resume)
> +#ifdef CONFIG_SMP
> + =A0 =A0 =A0 adr =A0 =A0 r0, sleep_save_sp
> + =A0 =A0 =A0 ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
> + =A0 =A0 =A0 ALT_UP(mov r1, #0)
> + =A0 =A0 =A0 and =A0 =A0 r1, r1, #15
> + =A0 =A0 =A0 ldr =A0 =A0 r0, [r0, r1, lsl #2] =A0 =A0@ stack phys ad=
dr
> +#else
> =A0 =A0 =A0 =A0ldr =A0 =A0 r0, sleep_save_sp =A0 =A0 =A0 @ stack phys=
 addr
> +#endif
> =A0 =A0 =A0 =A0msr =A0 =A0 cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE =
@ set SVC, irqs off
> =A0#ifdef MULTI_CPU
> =A0 =A0 =A0 =A0ldmia =A0 r0!, {r1, sp, lr, pc} =A0 @ load v:p, stack,=
 return fn, resume fn
> @@ -107,4 +129,6 @@ ENTRY(cpu_resume)
> =A0ENDPROC(cpu_resume)
>
> =A0sleep_save_sp:
> - =A0 =A0 =A0 .word =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 @ preserve stack phys ptr here
> + =A0 =A0 =A0 .rept =A0 CONFIG_NR_CPUS
> + =A0 =A0 =A0 .long =A0 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 @ preserve stack phys ptr here
> + =A0 =A0 =A0 .endr
> --
> 1.6.2.5

Acked-by: Colin Cross <ccross@android.com>

Tested with idle and suspend on Tegra 2.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
