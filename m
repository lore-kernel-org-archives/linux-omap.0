From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 16:21:46 +0000
Message-ID: <AANLkTimDTVypBFCoO9G72TzKToAThdXm_aEi56O+w9nY@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081615.15713.arnd@arndb.de>
	<AANLkTim6aBUJtkQHZBWfTWsjh2+ijFqOgf9cPGSrRtMD@mail.gmail.com>
	<201102081642.52774.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45819 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab1BHQVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 11:21:48 -0500
Received: by eye27 with SMTP id 27so3053173eye.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 08:21:47 -0800 (PST)
In-Reply-To: <201102081642.52774.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 8, 2011 at 3:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 February 2011, Dave Martin wrote:
>> Why not have macros for these cases? =A0(Which kinda brings the
>> discussion full-circle...)
>>
>> My immediate concern is that too often, the Thumb-2 case will be
>> handled incorrectly or not at all ... and the kernel will silently
>> build without flagging any error. =A0Macros would allow the fragile
>> definitions to go in one place.
>
> A macro to handle the thumb2 case and weird toolchains sounds good,
> but if we want to build code for multiple CPUs, we need multiple
> macros, not one macro that works on a specific CPU.
>
> We could put all those macros unconditionally into a arch
> specific header, e.g.
>
> arch/arm/include/asm/system-v7.h:
> #define wfi() __asm__ __volatile__ ("wfi" : : : "memory")
>
>
> arch/arm/include/asm/system-v6k.h:
> #define wfi() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c0, 4" \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: : "r" (0) : "memory")
>
> And then have each C file using them be CPU specific and include
> only one (you get an gcc warning if you try to include both).
> This should work fine, but it's different again from how we handle
> other things like spinlocks or cache management across multiple
> CPUs.

Such a solution could work...

I have a (possibly silly) question ... are the definitions in
arm/system.h intended to be fully generic, or not?  Some features
suggest an attempt at genericness, but not everything there is
generic.  Maybe I have misconstrued the purpose of this header.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
