From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 15:09:18 +0000
Message-ID: <AANLkTim90DF1pE0As_vNO-c4dn7S=2jVq+hkRo8CYsx4@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081311.52004.arnd@arndb.de>
	<20110208121334.GB22877@n2100.arm.linux.org.uk>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
	<19a3630aad67b496a4e36354abc63c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54810 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab1BHPJU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 10:09:20 -0500
Received: by ewy5 with SMTP id 5so2977300ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 07:09:19 -0800 (PST)
In-Reply-To: <19a3630aad67b496a4e36354abc63c4a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

On Tue, Feb 8, 2011 at 2:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Dave,
>
>> -----Original Message-----
>> From: Dave Martin [mailto:dave.martin@linaro.org]

[...]

>> I don't like the practice of pre-assembling bits of code with .long,
>> in order to allow a file to be built with wrong -march= flags, and I
>> would favour migrating away from this where possible ... but I
>> accept
>> it's a pragmatic solution to a problem for which gcc/binutils
>> provide
>> no good alternative.
>>
> How about C files where 'wfi' used using inline assembly.
> Can we also specify the " -march=" for the C files as well ?

Kbuild looks like it can do it, e.g. in mach-omap2/Makefile:

CFLAGS_pm_bus.o                         += -DDEBUG

... so we could:

CFLAGS_cpu_specific_object.o        += -march=armv7-a

Whether it's _safe_ to do it depends on whether code from that file
could ever get run on other processors.  I'm not so sure of the answer
to that..., but perhaps someone else has a better idea.

Cheers
---Dave
