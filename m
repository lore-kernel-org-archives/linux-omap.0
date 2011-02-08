From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 20:24:00 +0530
Message-ID: <19a3630aad67b496a4e36354abc63c4a@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org><201102081311.52004.arnd@arndb.de><20110208121334.GB22877@n2100.arm.linux.org.uk><201102081353.20390.arnd@arndb.de>
 <AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57502 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752457Ab1BHOyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 09:54:04 -0500
Received: by mail-ww0-f43.google.com with SMTP id 17so5722344wwi.24
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 06:54:02 -0800 (PST)
In-Reply-To: <AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

Dave,

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Tuesday, February 08, 2011 8:16 PM
> To: Arnd Bergmann
> Cc: linux-arm-kernel@lists.infradead.org; Russell King - ARM Linux;
> Nicolas Pitre; Tony Lindgren; Santosh Shilimkar; linux-
> omap@vger.kernel.org; Jean Pihet
> Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
>
[....]

> For (2), I think the best approach is to use the actual "wfi"
> instruction and build the affected files with the appropriate -
> march=
> flag (omap already does that) - since those CPU-specific files
> should
> by definition never be run if running on another CPU.  We only
> support
> new enough tools these days that this should be supported; so "wfi"
> should be preferable to ".long 0xdeadbeef" - otherwise we need lots
> of
> #ifdef CONFIG_THUMB2_KERNEL, or a macro.  If we have a macro, it
> would
> be better for that to be generically implemented somewhere, becasue
> the requirements are the same for every BSP supporting v7.
>
> I don't like the practice of pre-assembling bits of code with .long,
> in order to allow a file to be built with wrong -march= flags, and I
> would favour migrating away from this where possible ... but I
> accept
> it's a pragmatic solution to a problem for which gcc/binutils
> provide
> no good alternative.
>
How about C files where 'wfi' used using inline assembly.
Can we also specify the " -march=" for the C files as well ?

Regards,
Santosh
