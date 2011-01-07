From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: Build breakage with omap2plus_defconfig
Date: Fri, 7 Jan 2011 18:20:43 +0530
Message-ID: <d36c47cf71accc194040e98d74f768c0@mail.gmail.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42797 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751899Ab1AGMuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 07:50:44 -0500
Received: by mail-gw0-f43.google.com with SMTP id 17so7766178gwb.16
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:50:44 -0800 (PST)
In-Reply-To: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi wrote:
> Hi all,
>
> Today's Linus' tree
> (01539ba2a706ab7d35fc0667dff919ade7f87d63) fails to
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
> /tmp/cc2V7p5j.s:161: Error: selected processor does not support ARM mode
`ldrexb r3,[r4]'
> /tmp/cc2V7p5j.s:162: Error: selected processor does not support ARM mode
`strexb r0,r2,[r4]'
> make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
> make: *** [arch/arm/kernel] Error 2

I haven't found a way around this other than to turn off
CONFIG_SWP_EMULATE. Here's a patch doing that [1].

The discussion thread is here [2].

- Anand

[1] http://marc.info/?l=linux-omap&m=129140165126953&w=2
[2] http://marc.info/?t=128748412500003&r=1&w=2
