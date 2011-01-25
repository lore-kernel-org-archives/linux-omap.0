From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in asm/spinlock.h
Date: Tue, 25 Jan 2011 16:43:52 +0000
Message-ID: <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44127 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1AYQny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 11:43:54 -0500
Received: by eye27 with SMTP id 27so2665278eye.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 08:43:53 -0800 (PST)
In-Reply-To: <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi there,

On Mon, Jan 17, 2011 at 7:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> SMP requires at least the ARMv6K extensions to be present, so if we'r=
e
> running on SMP, the WFE and SEV instructions must be available.
>
> However, when we run on UP, the v6K extensions may not be available,
> and so we don't want WFE/SEV to be in the instruction stream. =A0Use =
the
> SMP alternatives infrastructure to replace these instructions with NO=
Ps
> if we build for SMP but run on UP.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0arch/arm/include/asm/spinlock.h | =A0 37 +++++++++++++++++++++++++=
------------
> =A01 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/s=
pinlock.h
> index 17eb355..da1af52 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -5,17 +5,36 @@
> =A0#error SMP not supported on pre-ARMv6 CPUs
> =A0#endif
>
> +/*
> + * sev and wfe are ARMv6K extensions. =A0Uniprocessor ARMv6 may not =
have the K
> + * extensions, so when running on UP, we have to patch these instruc=
tions away.
> + */
> +#define ALT_SMP(smp, up) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 "9998: =A0" smp "\n" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 " =A0 =A0 =A0 .pushsection \".alt.smp.init\", \"a\"\n" =
=A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 " =A0 =A0 =A0 .long =A0 9998b\n" =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 " =A0 =A0 =A0 " up "\n" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 " =A0 =A0 =A0 .popsection\n"
> +
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define SEV =A0 =A0 =A0 =A0 =A0 =A0ALT_SMP("sev.w", "nop.w")
> +#define WFE(cond) =A0 =A0 =A0ALT_SMP("wfe" cond ".w", "nop.w")
> +#else
> +#define SEV =A0 =A0 =A0 =A0 =A0 =A0ALT_SMP("sev", "nop")
> +#define WFE(cond) =A0 =A0 =A0ALT_SMP("wfe" cond, "nop")
> +#endif
> +
> =A0static inline void dsb_sev(void)
> =A0{
> =A0#if __LINUX_ARM_ARCH__ >=3D 7
> =A0 =A0 =A0 =A0__asm__ __volatile__ (
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dsb\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sev"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEV
> =A0 =A0 =A0 =A0);
> -#elif defined(CONFIG_CPU_32v6K)
> +#else
> =A0 =A0 =A0 =A0__asm__ __volatile__ (
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mcr p15, 0, %0, c7, c10, 4\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sev"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SEV
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: : "r" (0)
> =A0 =A0 =A0 =A0);
> =A0#endif
> @@ -46,9 +65,7 @@ static inline void arch_spin_lock(arch_spinlock_t *=
lock)
> =A0 =A0 =A0 =A0__asm__ __volatile__(
> =A0"1: =A0 =A0ldrex =A0 %0, [%1]\n"
> =A0" =A0 =A0 =A0teq =A0 =A0 %0, #0\n"
> -#ifdef CONFIG_CPU_32v6K
> -" =A0 =A0 =A0wfene\n"
> -#endif
> + =A0 =A0 =A0 WFE("ne")
> =A0" =A0 =A0 =A0strexeq %0, %2, [%1]\n"
> =A0" =A0 =A0 =A0teqeq =A0 %0, #0\n"
> =A0" =A0 =A0 =A0bne =A0 =A0 1b"
> @@ -107,9 +124,7 @@ static inline void arch_write_lock(arch_rwlock_t =
*rw)
> =A0 =A0 =A0 =A0__asm__ __volatile__(
> =A0"1: =A0 =A0ldrex =A0 %0, [%1]\n"
> =A0" =A0 =A0 =A0teq =A0 =A0 %0, #0\n"
> -#ifdef CONFIG_CPU_32v6K
> -" =A0 =A0 =A0wfene\n"
> -#endif
> + =A0 =A0 =A0 WFE("ne")
> =A0" =A0 =A0 =A0strexeq %0, %2, [%1]\n"
> =A0" =A0 =A0 =A0teq =A0 =A0 %0, #0\n"
> =A0" =A0 =A0 =A0bne =A0 =A0 1b"
> @@ -176,9 +191,7 @@ static inline void arch_read_lock(arch_rwlock_t *=
rw)
> =A0"1: =A0 =A0ldrex =A0 %0, [%2]\n"
> =A0" =A0 =A0 =A0adds =A0 =A0%0, %0, #1\n"
> =A0" =A0 =A0 =A0strexpl %1, %0, [%2]\n"
> -#ifdef CONFIG_CPU_32v6K
> -" =A0 =A0 =A0wfemi\n"
> -#endif
> + =A0 =A0 =A0 WFE("mi")
> =A0" =A0 =A0 =A0rsbpls =A0%0, %1, #0\n"
> =A0" =A0 =A0 =A0bmi =A0 =A0 1b"
> =A0 =A0 =A0 =A0: "=3D&r" (tmp), "=3D&r" (tmp2)
> --
> 1.6.2.5

A couple of questions on this:

1) I notice these spinlock functions are generally marked inline.

Is that likely to happen in modules?  If so, there would be a need to
do SMP_ON_UP fixups at module load time -- I don't think that's
currently implemented.

2) When building with this patch and CONFIG_SMP_ON_UP=3Dy, I've seen
vmlinux link errors like this:

  LD      .tmp_vmlinux1
`.exit.text' referenced in section `.alt.smp.init' of
drivers/built-in.o: defined in discarded section `.exit.text' of
drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1

I don't know whether this is caused by the patch directly or as a
side-effect -- I've only noticed it in the linaro-2.6.37 tree so far.
git bisect indentified this above patch as the first one with the
error in that case.

I don't understand the section discarding logic too well, so I'm not
sure how to fix it for now...

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
