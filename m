From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 14:45:51 +0000
Message-ID: <AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081311.52004.arnd@arndb.de>
	<20110208121334.GB22877@n2100.arm.linux.org.uk>
	<201102081353.20390.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54085 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab1BHOpx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 09:45:53 -0500
Received: by eye27 with SMTP id 27so2957821eye.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 06:45:52 -0800 (PST)
In-Reply-To: <201102081353.20390.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 8, 2011 at 12:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 February 2011, Russell King - ARM Linux wrote:
>> > I don't see any users of the sev/wfe/wfi macros in the current ker=
nel,
>> > so removing them seems like a good strategy to avoid people from
>> > using them incorrectly.
>>
>> That's because they've only just been added. =A0See the massive 63-p=
atch set
>> from Viresh which has been posting to this mailing list.
>
> Ok, I see. At least that version seems ok because the code is cpu
> specific already.
>
> The omap do_wfi macro is specifically meant to avoid the multi-cpu
> case by using the hexadecimal notation, so it can still be used while
> building a kernel for ARMv6 or lower. Dave's version seems to have
> the opposite intention here (choosing one version per arch level),
> so it wouldn't be a replacement.

I guess there are two problems we're trying to solve here:

1) a lowest-common denominator implementation of things like wfi(),
for use in common code.  This must be based on __LINUX_ARM_ARCH__
(which IIUC gives the lowest arch supported by all the CPUs being
built for -- am I correct?)
2) definitions for specific CPUs, for non-generic code which may be
bundled together in a single kernel build.

=46or (1), We can sensibly try to define a generic macro.  If building
for ARMv6 and ARMv7 CPUs in the same kernel, then we have to use the
lowest-common-denominator definition, i.e., the MCR form.  For ARMv7,
we can use WFI.
=46or (2), I think the best approach is to use the actual "wfi"
instruction and build the affected files with the appropriate -march=3D
flag (omap already does that) - since those CPU-specific files should
by definition never be run if running on another CPU.  We only support
new enough tools these days that this should be supported; so "wfi"
should be preferable to ".long 0xdeadbeef" - otherwise we need lots of
#ifdef CONFIG_THUMB2_KERNEL, or a macro.  If we have a macro, it would
be better for that to be generically implemented somewhere, becasue
the requirements are the same for every BSP supporting v7.

I don't like the practice of pre-assembling bits of code with .long,
in order to allow a file to be built with wrong -march=3D flags, and I
would favour migrating away from this where possible ... but I accept
it's a pragmatic solution to a problem for which gcc/binutils provide
no good alternative.

As to exactly what macros should be defined and where, I don't have a
strong view--- other people's guess is probably better than mine.


I believe that my wfi() modification gets defined suitably for both
cases, with one exception:

If support for a v6K processor is included, we have no way to know
from preprocessor definitions whether a plain v6 processor is also to
be supported.  My proposed definition is incorrect in that we still
get wfi() =3D=3D WFI, whereas we really want the MCR for this case.
Likewise, the definitions of wfe() and sev() may not execute on a
plain v6 processor (though actually, I think they will execute as
NOPs)

So, for v6K we should either always use MCR for wfi(), or we need to
define wfi() using ALT_SMP(wfi) ALT_UP(mcr).  But whether that's a
common enough case to care about, I can't say.


Any thoughts on all that?

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
