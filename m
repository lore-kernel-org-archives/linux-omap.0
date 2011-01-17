From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
Date: Mon, 17 Jan 2011 10:15:25 +0000
Message-ID: <AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65038 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1AQKP0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 05:15:26 -0500
Received: by iyj18 with SMTP id 18so4462363iyj.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 02:15:25 -0800 (PST)
In-Reply-To: <20110115161132.GH15996@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 15 January 2011 16:11, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> SMP requires at least the ARMv6K extensions to be present, so if we'r=
e
> running on SMP, the WFE and SEV instructions must be available.
>
> However, when we run on UP, the v6K extensions may not be available,
> and so we don't want WFE/SEV to be in the instruction stream. =C2=A0U=
se the
> SMP alternatives infrastructure to replace these instructions with NO=
Ps
> if we build for SMP but run on UP.
[...]
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -5,17 +5,36 @@
> =C2=A0#error SMP not supported on pre-ARMv6 CPUs
> =C2=A0#endif
>
> +/*
> + * sev and wfe are ARMv6K extensions. =C2=A0Uniprocessor ARMv6 may n=
ot have the K
> + * extensions, so when running on UP, we have to patch these instruc=
tions away.
> + */
> +#define ALT_SMP(smp, up) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 "9998: =C2=A0" smp "\n" =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 .pushsection \".alt.smp=
=2Einit\", \"a\"\n" =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 .long =C2=A0 9998b\n" =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 " up "\n" =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 .popsection\n"
> +
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define SEV =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALT_SMP("sev.w"=
, "nop.w")
> +#define WFE(cond) =C2=A0 =C2=A0 =C2=A0ALT_SMP("wfe" cond ".w", "nop.=
w")
> +#else
> +#define SEV =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALT_SMP("sev", =
"nop")
> +#define WFE(cond) =C2=A0 =C2=A0 =C2=A0ALT_SMP("wfe" cond, "nop")
> +#endif

In the SEV macro definition, can you also include the dsb? This
barrier is only there because of sev, otherwise we don't need it (we
have a dmb prior to releasing the lock).

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
