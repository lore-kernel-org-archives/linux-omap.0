From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 1/5] ARM: omap4: Correct definition of do_wfi() forCONFIG_THUMB2_KERNEL
Date: Fri, 4 Feb 2011 10:58:06 +0000
Message-ID: <AANLkTin_mc2e=xaotifjix_ii5iaugVFo1RuAkzZEWwF@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-2-git-send-email-dave.martin@linaro.org>
	<b0242fa556f17e47222fa7f30a36d75b@mail.gmail.com>
	<20110203190758.GA15004@n2100.arm.linux.org.uk>
	<d813cf9e0b404d0243c3973841baa6dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48129 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1BDK6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 05:58:08 -0500
Received: by eye27 with SMTP id 27so1164004eye.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 02:58:07 -0800 (PST)
In-Reply-To: <d813cf9e0b404d0243c3973841baa6dc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

On Thu, Feb 3, 2011 at 7:30 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
>> Sent: Friday, February 04, 2011 12:38 AM
>> To: Santosh Shilimkar
>> Cc: Dave Martin; linux-arm-kernel@lists.infradead.org; Tony
>> Lindgren; Nicolas Pitre; linux-omap@vger.kernel.org; Jean Pihet-XID
>> Subject: Re: [PATCH v2 1/5] ARM: omap4: Correct definition of
>> do_wfi() forCONFIG_THUMB2_KERNEL
>>
>> On Fri, Feb 04, 2011 at 12:09:34AM +0530, Santosh Shilimkar wrote:
>> > > -----Original Message-----
>> > > From: Dave Martin [mailto:dave.martin@linaro.org]
>> > > Sent: Thursday, February 03, 2011 11:33 PM
>> > > To: linux-arm-kernel@lists.infradead.org
>> > > Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
>> > > linux-omap@vger.kernel.org; Nicolas Pitre
>> > > Subject: [PATCH v2 1/5] ARM: omap4: Correct definition of
>> do_wfi()
>> > > for CONFIG_THUMB2_KERNEL
>> > >
>> > > For the Thumb-2 case, the "wfi" mnemonic is used, since in this
>> > > case the tools will necessarily be new enough to support it.
>> > >
>> > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> >
>> > I guess, we discussed this patch in your previous post.
>> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >
>> > > ---
>> > > =A0arch/arm/mach-omap2/include/mach/omap4-common.h | =A0 =A05 ++=
+++
>> > > =A01 files changed, 5 insertions(+), 0 deletions(-)
>> > >
>> > > diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > b/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > index 5b0270b..68ce058 100644
>> > > --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
>> > > @@ -17,8 +17,13 @@
>> > > =A0 * wfi used in low power code. Directly opcode is used instea=
d
>> > > =A0 * of instruction to avoid mulit-omap build break
>> > > =A0 */
>> > > +#ifdef CONFIG_THUMB2_KERNEL
>> > > +#define do_wfi() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > > + =A0 =A0 =A0 =A0 __asm__ __volatile__ ("wfi" : : : "memory")
>> > > +#else
>> > > =A0#define do_wfi() =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > > =A0 =A0 =A0 =A0 =A0 __asm__ __volatile__ (".word =A0 =A00xe320f0=
03" : : :
>> > > "memory")
>> > > +#endif
>>
>> We actually have this:
>>
>> #if __LINUX_ARM_ARCH__ >=3D 7 || =A0 =A0 =A0 =A0 =A0\
>> =A0 =A0 =A0 =A0 (__LINUX_ARM_ARCH__ =3D=3D 6 && defined(CONFIG_CPU_3=
2v6K))
>> #define sev() =A0 __asm__ __volatile__ ("sev" : : : "memory")
>> #define wfe() =A0 __asm__ __volatile__ ("wfe" : : : "memory")
>> #define wfi() =A0 __asm__ __volatile__ ("wfi" : : : "memory")
>> #endif
>>
>> in asm/system.h, so maybe it should be using wfe() from asm/system.h
>> ?
> I assume you mean wfi here.
> The problem is, omap2plus build breaks because it builds
> CPU_32v6 and CPU_32v7 as well which doesn't support the wfi
> instruction. Hence I used opcode directly to keep build
> working.

I guess that's right, OMAP2 is ARM1136 and doesn't have the K extension=
s.

Would it make sense to have the v6 MCR equivalent as an altetnative?
Something like:

#elseif __LINUX_ARM_ARCH__ >=3D 6
#define wfi()   __asm__ __volatile__ ( \
    "mov     r0, #0\n\t" \
    "mcr     p15, 0, r0, c7, c0, 4\n\t" \
    ::: "r0"
)
#endif

This MCR is a mandatory part of the architecture for v6, but it's not
mandatory for older processors.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
