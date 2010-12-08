From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Date: Tue, 7 Dec 2010 23:43:44 -0800 (PST)
Message-ID: <233071.45934.qm@web180308.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm23-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.224]:25069 "HELO
	nm23-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753250Ab0LHHnq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 02:43:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org


--- On Tue, 12/7/10, Dave Martin <dave.martin@linaro.org> wrote:

> From: Dave Martin <dave.martin@linaro.org>
> Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !C=
PU_V6...

> This makes sense, because Thumb-2
> code can't execute on anything
> prior to ARMv7.

WRONG ... but you may be overlooking the
fact that there are at least three
flavors of Thumb-2 ...

 - Original, as on some ARMv6 chips ARM1156 was
the introductory Thumb2 core).=A0 It's Thumb1
plus a very few 32-bit instructions.=A0 (And
maybe the SIMD instructions too; I forget.=A0 Not
suitable for OS work like IRQ handling, ISTR; or
at least, not as suitable as the ARMv7 flavors.

 -Microcontroller ... ARMv7M chips, and likely
not available on Linux-capable hardware ...=A0=A0=A0Suitable for RTOS w=
ork like IRQ
handling.



- Applications ... ARMv7A chips ... like those V6
chips with THUMB2, but with SIMD "multimedia"
 instructions and maybe a bit more.=A0 Worth tossing
THUMB-EE in this bag too.


>=20
>=A0=20
>=A0 config THUMB2_KERNEL
>=A0 =A0=A0=A0 bool "Compile the kernel in Thumb-2
> mode"
> -=A0=A0=A0 depends on CPU_V7 &&
> EXPERIMENTAL
> +=A0=A0=A0 depends on CPU_V7 && !CPU_V6
> && EXPERIMENTAL
>=A0 =A0=A0=A0 select AEABI
>=A0 =A0=A0=A0 select ARM_ASM_UNIFIED
>=A0 =A0=A0=A0 help
> --=20
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
