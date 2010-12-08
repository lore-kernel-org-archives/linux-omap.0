From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Date: Wed, 8 Dec 2010 11:03:36 +0000
Message-ID: <AANLkTin8r4-ooAUsf-T5SnM_QDHdY_c3XfRL4o=nZkHC@mail.gmail.com>
References: <233071.45934.qm@web180308.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:34917 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0LHLDh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 06:03:37 -0500
Received: by iwn40 with SMTP id 40so1449894iwn.3
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 03:03:36 -0800 (PST)
In-Reply-To: <233071.45934.qm@web180308.mail.gq1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

On Wed, Dec 8, 2010 at 7:43 AM, David Brownell <david-b@pacbell.net> wr=
ote:
>
> --- On Tue, 12/7/10, Dave Martin <dave.martin@linaro.org> wrote:
>
>> From: Dave Martin <dave.martin@linaro.org>
>> Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !=
CPU_V6...
>
>> This makes sense, because Thumb-2
>> code can't execute on anything
>> prior to ARMv7.
>
> WRONG ... but you may be overlooking the
> fact that there are at least three
> flavors of Thumb-2 ...
>
> =A0- Original, as on some ARMv6 chips ARM1156 was
> the introductory Thumb2 core).=A0 It's Thumb1
> plus a very few 32-bit instructions.=A0 (And
> maybe the SIMD instructions too; I forget.=A0 Not
> suitable for OS work like IRQ handling, ISTR; or
> at least, not as suitable as the ARMv7 flavors.
>
> =A0-Microcontroller ... ARMv7M chips, and likely
> not available on Linux-capable hardware ...=A0=A0=A0Suitable for RTOS=
 work like IRQ
> handling.

You're correct on some points ... *but* v7-M is not supported in the
kernel yet, and in any case full linux is not applicable - this will
be ucLinux territory.  v7-M shares much of the instruction set with
v7-A/R, bit it's a substantially different architecture when it comes
to things like exception handling etc.

The v6T2 architecture supported by arm1156 does have comprehensive
Thumb-2 support (not just a few 32-bit instructions), and arm1156
supports taking of exceptions in Thumb-2 etc., so in principle the
complete OS could be built in Thumb-2 as is the case for v7.  But this
particular processor is rare and I believe it's not supported in the
kernel right now ... and not likely to be.  No other processors
implement v6T2, and no new processors will implement it either.

The rules might need to be refined later, but !CPU_V6 seems sensible fo=
r now.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
