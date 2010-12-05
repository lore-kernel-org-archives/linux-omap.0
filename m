From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] ARM: implement support for read-mostly sections
Date: Sun, 5 Dec 2010 22:18:27 +0000
Message-ID: <AANLkTin5HiPRd=SF_kdvEnZjV7C3J+6MXKQL02zKKtp=@mail.gmail.com>
References: <20101205114257.GD9138@n2100.arm.linux.org.uk>
	<E1PPCzx-0004yo-MJ@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48346 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab0LEWS2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 17:18:28 -0500
Received: by iwn6 with SMTP id 6so2564228iwn.19
        for <linux-omap@vger.kernel.org>; Sun, 05 Dec 2010 14:18:27 -0800 (PST)
In-Reply-To: <E1PPCzx-0004yo-MJ@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 5 December 2010 11:43, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> As our SMP implementation uses MESI protocols. =C2=A0Grouping togethe=
r data
> which is mostly only read together means that we avoid unnecessary
> cache line bouncing when this code shares a cache line with other dat=
a.
>
> In other words, cache lines associated with read-mostly data are
> expected to spend most of their time in shared state.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =C2=A0arch/arm/include/asm/cache.h =C2=A0| =C2=A0 =C2=A02 ++
> =C2=A0arch/arm/kernel/vmlinux.lds.S | =C2=A0 =C2=A01 +
> =C2=A02 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cach=
e.h
> index 9d61220..75fe66b 100644
> --- a/arch/arm/include/asm/cache.h
> +++ b/arch/arm/include/asm/cache.h
> @@ -23,4 +23,6 @@
> =C2=A0#define ARCH_SLAB_MINALIGN 8
> =C2=A0#endif
>
> +#define __read_mostly __attribute__((__section__(".data..read_mostly=
")))
> +
> =C2=A0#endif
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.=
lds.S
> index cead889..1581f6d 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -167,6 +167,7 @@ SECTIONS
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NOSAVE_DATA
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CACHELINE_ALIG=
NED_DATA(32)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 READ_MOSTLY_DATA(3=
2)

Should we change the alignments to 64?

--=20
Catalin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
