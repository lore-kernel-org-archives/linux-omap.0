From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for function
 body copying
Date: Mon, 17 Jan 2011 15:02:20 +0100
Message-ID: <AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58100 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab1AQOCV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 09:02:21 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so4770211qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 06:02:20 -0800 (PST)
In-Reply-To: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Fri, Jan 14, 2011 at 10:17 PM, Dave Martin <dave.martin@linaro.org> =
wrote:
> In low-level board support code, there is sometimes a need to
> copy a function body to another location at run-time.
>
> A straightforward call to memcpy doesn't work in Thumb-2,
> because bit 0 of external Thumb function symbols is set to 1,
> indicating that the function is Thumb. =A0Without corrective
> measures, this will cause an off-by-one copy, and the copy
> may be called using the wrong instruction set.
>
> This patch adds an fncpy() macro to help with such copies.
>
> Particular care is needed, because C doesn't guarantee any
> defined behaviour when casting a function pointer to any other
> type. =A0This has been observed to lead to strange optimisation
> side-effects when doing the arithmetic which is required in
> order to copy/move function bodies correctly in Thumb-2.
>
> Thanks to Russell King and Nicolas Pitre for their input
> on this patch.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Tested-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/include/asm/fncpy.h | =A0 96 ++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 96 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/include/asm/fncpy.h
>
> diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncp=
y.h
> new file mode 100644
> index 0000000..8b94b5f
> --- /dev/null
> +++ b/arch/arm/include/asm/fncpy.h
> @@ -0,0 +1,96 @@
> +/*
> + * arch/arm/include/asm/fncpy.h - helper macros for function body co=
pying
> + *
> + * Copyright (C) 2011 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + */
> +
> +/*
> + * These macros are intended for use when there is a need to copy a =
low-level
> + * function body into special memory.
> + *
> + * For example, when reconfiguring the SDRAM controller, the code do=
ing the
> + * reconfiguration may need to run from SRAM.
> + *
> + * NOTE: that the copied function body must be entirely self-contain=
ed and
> + * position-independent in order for this to work properly.
> + *
> + * NOTE: in order for embedded literals and data to get referenced c=
orrectly,
> + * the alignment of functions must be preserved when copying. =A0To =
ensure this,
> + * the source and destination addresses for fncpy() must be aligned =
to a
> + * multiple of 8 bytes: you will be get a BUG() if this condition is=
 not met.
> + * You will typically need a ".align 3" directive in the assembler w=
here the
> + * function to be copied is defined, and ensure that your allocator =
for the
> + * destination buffer returns 8-byte-aligned pointers.

Note that aligning the source and destination pointers to a multiple
of 8 bytes has an impact on the behavio(u)r and so must be carefully
thought and tested on OMAP1/2/3 platforms.

Regards,
Jean

> + *
> + * Typical usage example:
> + *
> + * extern int f(args);
> + * extern uint32_t size_of_f;
> + * int (*copied_f)(args);
> + * void *sram_buffer;
> + *
> + * copied_f =3D fncpy(sram_buffer, &f, size_of_f);
> + *
> + * ... do any required D-side/I-side synchronisation ...
> + *
> + * ... later, call the function: ...
> + *
> + * copied_f(args);
> + *
> + * The size of the function to be copied can't be determined from C:
> + * this must be determined by other means, such as adding assmbler d=
irectives
> + * in the file where f is defined.
> + */
> +
> +#ifndef __ASM_FNCPY_H
> +#define __ASM_FNCPY_H
> +
> +#include <linux/types.h>
> +#include <linux/string.h>
> +
> +#include <asm/bug.h>
> +#include <asm/cacheflush.h>
> +
> +/*
> + * Minimum alignment requirement for the source and destination addr=
esses
> + * for function copying.
> + */
> +#define FNCPY_ALIGN 8
> +
> +#define fncpy(dest_buf, funcp, size) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 uintptr_t __funcp_address; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 typeof(funcp) __result; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 asm("" : "=3Dr" (__funcp_address) : "0" (funcp)); =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 /* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> + =A0 =A0 =A0 =A0* Ensure alignment of source and destination address=
es, =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0* disregarding the function's Thumb bit: =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0*/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 BUG_ON((uintptr_t)(dest_buf) & (FNCPY_ALIGN - 1) || =A0=
 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (__funcp_address & ~(uintptr_t)1 & (FNC=
PY_ALIGN - 1))); \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 memcpy(dest_buf, (void const *)(__funcp_address & ~1), =
size); =A0 \
> + =A0 =A0 =A0 flush_icache_range((unsigned long)(dest_buf), =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)(dest_buf) + (size)); =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 asm("" : "=3Dr" (__result) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : "0" ((uintptr_t)(dest_buf) | (__funcp=
_address & 1))); \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 \
> + =A0 =A0 =A0 __result; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> +})
> +
> +#endif /* !__ASM_FNCPY_H */
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
