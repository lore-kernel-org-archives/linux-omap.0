From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
Date: Fri, 11 Feb 2011 09:43:45 +0000
Message-ID: <AANLkTimMdFPpjdO_A1yyYUpSnSbo9gkn_-D5132KWKyQ@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-6-git-send-email-dave.martin@linaro.org>
	<87d3mzh6vq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37048 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1BKJnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 04:43:47 -0500
Received: by wyb28 with SMTP id 28so2281788wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 01:43:46 -0800 (PST)
In-Reply-To: <87d3mzh6vq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

On Thu, Feb 10, 2011 at 10:17 PM, Kevin Hilman <khilman@ti.com> wrote:
> Dave Martin <dave.martin@linaro.org> writes:
>
>> =A0* Use BSYM() to get the correct Thumb branch address
>> =A0 =A0for adr <Rd>, <label>
>>
>> =A0* Fix an out-of-range ADR when building for ARM
>>
>> =A0* Correctly call es3_sdrc_fix as Thumb when copied to SRAM.
>>
>> =A0* Remove deprecated/undefined PC-relative stores
>>
>> =A0* Add the required ENDPROC() directive for each ENTRY().
>>
>> =A0* .align before data words
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>
> I'm attempting to test this series with OMAP PM, but some changes her=
e
> don't compile for me.
>
> My toolchain is: gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50)
>
> First, I merged your arm/omap-thumb2+merged branch with my pm branch
> from git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap=
-pm.git
>
> There were some minor conflicts here, but they looked simple enough a=
nd
> I just resolved in favor of your branch.

Thanks for giving it a try.

>
> Trying to build with CONFIG_THUMB2_KERNEL=3Dy, I ran into a compile
> problem...
>
>

[...]

>> + =A0 =A0 adr =A0 =A0 r0, es3_sdrc_fix =A0 =A0 =A0 =A0@ Not using BS=
YM clears the Thumb bit.
>
> This fails to compile:
>
> /work/kernel/omap/pm/arch/arm/mach-omap2/sleep34xx.S: Assembler messa=
ges:
> /work/kernel/omap/pm/arch/arm/mach-omap2/sleep34xx.S:361: Error: inva=
lid immediate for address calculation (value =3D 0x00000004)

Unfortunately, this is caused by a bug in the assembler.
arch/arm/kernel/relocate_kernel.S also suffers from the same bug when
built with CONFIG_THUMB2_KERNEL.

If you had got as far a linking, it's likely you would hit a
'reference to discarded section problem' error in the linker, due to
discarding of some sections referenced by SMP_ON_UP fixups.

If you merge the 3 extra patches from dirty/arm/omap-thumb2+merged it
should resolve these issues, but how to fix these things upstream is
still under discussion.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
