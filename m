From: Felipe Balbi <balbi@ti.com>
Subject: Re: Build breakage with omap2plus_defconfig
Date: Fri, 7 Jan 2011 14:44:45 +0200
Message-ID: <20110107124445.GB9592@legolas.emea.dhcp.ti.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45921 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803Ab1AGMo4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 07:44:56 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so7619378eye.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:44:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, Jan 07, 2011 at 02:38:59PM +0200, Felipe Balbi wrote:
> Today's Linus' tree (01539ba2a706ab7d35fc0667dff919ade7f87d63) fails to
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
> /tmp/cc2V7p5j.s:161: Error: selected processor does not support ARM mode `ldrexb r3,[r4]'
> /tmp/cc2V7p5j.s:162: Error: selected processor does not support ARM mode `strexb r0,r2,[r4]'
> make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> 
> Compiler is:
> 
> $ arm-linux-gcc --version
> arm-linux-gcc (Sourcery G++ Lite 2010q1-202) 4.4.1
> Copyright (C) 2009 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> I'm downloading Sourcery G++ Lite 2010.09-50 for ARM GNU/Linux to check
> if it's not a bug on the compiler.

Just tested with newer compiler and it also fails to compile.

$ arm-linux-gcc --version
arm-linux-gcc (Sourcery G++ Lite 2010.09-50) 4.5.1
Copyright (C) 2010 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

-- 
balbi
