From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Build breakage with omap2plus_defconfig
Date: Fri, 7 Jan 2011 18:18:51 +0530
Message-ID: <8663c7bb00ba574693af177a10e24043@mail.gmail.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41485 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752588Ab1AGMsw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 07:48:52 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so10866559fxm.12
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:48:51 -0800 (PST)
In-Reply-To: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Friday, January 07, 2011 6:09 PM
> To: Russell King; Tony Lindgren
> Cc: Linux OMAP Mailing List; Linux ARM Kernel Mailing List
> Subject: Build breakage with omap2plus_defconfig
>
> Hi all,
>
> Today's Linus' tree (01539ba2a706ab7d35fc0667dff919ade7f87d63) fails
> to
> build with omap2plus_defconfig:
>
> $ crossmake
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: `include/generated/mach-types.h' is up to date.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      arch/arm/kernel/swp_emulate.o
> /tmp/cc2V7p5j.s: Assembler messages:
> /tmp/cc2V7p5j.s:161: Error: selected processor does not support ARM
> mode `ldrexb r3,[r4]'
> /tmp/cc2V7p5j.s:162: Error: selected processor does not support ARM
> mode `strexb r0,r2,[r4]'

Well it's not toolchain issue but the omap2plus_defconfig which
selects ARMv6 and ARMV7 together.

If you remove ARCH_OMAP2 from build, it will go through.

> make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
> make: *** [arch/arm/kernel] Error 2
>
> Compiler is:
>
> $ arm-linux-gcc --version
> arm-linux-gcc (Sourcery G++ Lite 2010q1-202) 4.4.1
> Copyright (C) 2009 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There
> is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
>
> I'm downloading Sourcery G++ Lite 2010.09-50 for ARM GNU/Linux to
> check
> if it's not a bug on the compiler.

Santosh
