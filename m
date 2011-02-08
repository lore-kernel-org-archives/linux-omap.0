From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 15:30:32 +0000
Message-ID: <AANLkTim6aBUJtkQHZBWfTWsjh2+ijFqOgf9cPGSrRtMD@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
	<201102081615.15713.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37930 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428Ab1BHPaf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 10:30:35 -0500
Received: by ewy5 with SMTP id 5so2998042ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 07:30:33 -0800 (PST)
In-Reply-To: <201102081615.15713.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 8, 2011 at 3:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 February 2011, Dave Martin wrote:
>> I guess there are two problems we're trying to solve here:
>>
>> 1) a lowest-common denominator implementation of things like wfi(),
>> for use in common code. =A0This must be based on __LINUX_ARM_ARCH__
>> (which IIUC gives the lowest arch supported by all the CPUs being
>> built for -- am I correct?)
>> 2) definitions for specific CPUs, for non-generic code which may be
>> bundled together in a single kernel build.
>>
>> For (1), We can sensibly try to define a generic macro. =A0If buildi=
ng
>> for ARMv6 and ARMv7 CPUs in the same kernel, then we have to use the
>> lowest-common-denominator definition, i.e., the MCR form. =A0For ARM=
v7,
>> we can use WFI.
>
> But that doesn't work if you build a combined v5/v6/v7 kernel, becaus=
e
> v5 supports neither form, right? I think to do that, it needs the
> same kind of abstraction that we have for a number of other things
> like cache management in arch/arm/mm/.
>
>> For (2), I think the best approach is to use the actual "wfi"
>> instruction and build the affected files with the appropriate -march=
=3D
>> flag (omap already does that) - since those CPU-specific files shoul=
d
>> by definition never be run if running on another CPU. =A0We only sup=
port
>> new enough tools these days that this should be supported; so "wfi"
>> should be preferable to ".long 0xdeadbeef" - otherwise we need lots =
of
>> #ifdef CONFIG_THUMB2_KERNEL, or a macro. =A0If we have a macro, it w=
ould
>> be better for that to be generically implemented somewhere, becasue
>> the requirements are the same for every BSP supporting v7.
>
> Makes sense.
>
>> I don't like the practice of pre-assembling bits of code with .long,
>> in order to allow a file to be built with wrong -march=3D flags, and=
 I
>> would favour migrating away from this where possible ... but I accep=
t
>> it's a pragmatic solution to a problem for which gcc/binutils provid=
e
>> no good alternative.
>
> Yes. Moreover, new instructions may always have to be that way for
> a while, before they can be moved over to the proper inline
> assembly.

Why not have macros for these cases?  (Which kinda brings the
discussion full-circle...)

My immediate concern is that too often, the Thumb-2 case will be
handled incorrectly or not at all ... and the kernel will silently
build without flagging any error.  Macros would allow the fragile
definitions to go in one place.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
