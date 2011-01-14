From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v3 1/1] ARM: Thumb-2: Symbol manipulation macros for
 function body copying
Date: Fri, 14 Jan 2011 15:53:55 +0100
Message-ID: <AANLkTin21EU3_dgB9Q1G32YrjadvxGdtzBMRmADQ6YyU@mail.gmail.com>
References: <1294958503-6537-1-git-send-email-dave.martin@linaro.org>
	<1294958503-6537-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33368 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab1ANOx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 09:53:56 -0500
Received: by qyk12 with SMTP id 12so3441558qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 06:53:55 -0800 (PST)
In-Reply-To: <1294958503-6537-2-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Thu, Jan 13, 2011 at 11:41 PM, Dave Martin <dave.martin@linaro.org> =
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
> This patch adds macros to help with such cases.
>
> Particular care is needed, because C doesn't guarantee any
> defined behaviour when casting a function pointer to any other
> type. =A0This has been observed to lead to strange optimisation
> side-effects when doing the arithmetic which is required in
> order to copy/move function bodies correctly in Thumb-2.
>
> Thanks to Russell King and Nicolas Pitre for their input.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Tested OK on OMAP3 in low power modes (RET/OFF) with !CONFIG_THUMB2_KER=
NEL.

Tested-by: Jean Pihet <j-pihet@ti.com>

> ---
> KernelVersion: v2.6.37
>
> =A0arch/arm/include/asm/fncpy.h | =A0110 ++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 110 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/include/asm/fncpy.h
>
> diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncp=
y.h
> new file mode 100644
> index 0000000..6399265
> --- /dev/null
> +++ b/arch/arm/include/asm/fncpy.h
> @@ -0,0 +1,110 @@
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
> +#include <asm/cacheflush.h>
> +
> +/* Function pointer casting macros */
> +
> +/* Cast function pointer to integer: */
> +#define __funcp_to_uint(funcp) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uintptr_t __result; =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 asm("" : "=3Dr" (__result) : "0" (funcp=
)); =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __result; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 })
> +
> +/* Cast integer to function pointer with type matching funcp: */
> +#define __uint_to_funcp(i, funcp) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 typeof(funcp) __result; =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 asm("" : "=3Dr" (__result) : "0" (i)); =
=A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __result; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 })
> +
> +
> +/* Function symbol manipulation macros */
> +
> +/*
> + * FSYM_REBASE: Determine the correct function pointer for funcp,
> + * after the function has been copied to dest_buf:
> + */
> +#define FSYM_REBASE(funcp, dest_buf) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 __uint_to_funcp((uintptr_t)(dest_buf) | FSYM_TYPE(funcp=
), funcp)
> +
> +/*
> + * FSYM_BASE: Determine the base address in memory of the function f=
uncp
> + * FSYM_TYPE: Determine the instruction set type (ARM/Thumb) of func=
p
> + * (both defined below)
> + */
> +
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define FSYM_BASE(funcp) ((void *)(__funcp_to_uint(funcp) & ~(uintpt=
r_t)1))
> +#define FSYM_TYPE(funcp) (__funcp_to_uint(funcp) & 1)
> +#else /* !CONFIG_THUMB2_KERNEL */
> +#define FSYM_BASE(funcp) ((void *)__funcp_to_uint(funcp))
> +#define FSYM_TYPE(funcp) 0
> +#endif /* !CONFIG_THUMB2_KERNEL */
> +
> +/* Function copy helper */
> +#define fncpy(dest_buf, funcp, size) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(dest_buf, FSYM_BASE(funcp), size=
); =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_icache_range((unsigned long)(dest=
_buf), =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)(dest_bu=
f) + (size)); =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FSYM_REBASE(funcp, dest_buf); =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 })
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
