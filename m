From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Build breakage with omap2plus_defconfig
Date: Fri, 7 Jan 2011 18:35:39 +0530
Message-ID: <48d62e319848b713fc70a8298c32710d@mail.gmail.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
 <8663c7bb00ba574693af177a10e24043@mail.gmail.com> <20110107125929.GD9592@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:52103 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753128Ab1AGNFn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:05:43 -0500
Received: by mail-fx0-f53.google.com with SMTP id 11so10878007fxm.12
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 05:05:42 -0800 (PST)
In-Reply-To: <20110107125929.GD9592@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Friday, January 07, 2011 6:30 PM
> To: Santosh Shilimkar
> Cc: balbi@ti.com; Russell King; Tony Lindgren; Linux OMAP Mailing
> List; Linux ARM Kernel Mailing List
> Subject: Re: Build breakage with omap2plus_defconfig
>
> On Fri, Jan 07, 2011 at 06:18:51PM +0530, Santosh Shilimkar wrote:
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Felipe Balbi
> > > Sent: Friday, January 07, 2011 6:09 PM
> > > To: Russell King; Tony Lindgren
> > > Cc: Linux OMAP Mailing List; Linux ARM Kernel Mailing List
> > > Subject: Build breakage with omap2plus_defconfig
> > >
> > > Hi all,
> > >
> > > Today's Linus' tree (01539ba2a706ab7d35fc0667dff919ade7f87d63)
> fails
> > > to
> > > build with omap2plus_defconfig:
> > >
> > > $ crossmake
> > >   CHK     include/linux/version.h
> > >   CHK     include/generated/utsrelease.h
> > > make[1]: `include/generated/mach-types.h' is up to date.
> > >   CALL    scripts/checksyscalls.sh
> > >   CHK     include/generated/compile.h
> > >   CC      arch/arm/kernel/swp_emulate.o
> > > /tmp/cc2V7p5j.s: Assembler messages:
> > > /tmp/cc2V7p5j.s:161: Error: selected processor does not support
> ARM
> > > mode `ldrexb r3,[r4]'
> > > /tmp/cc2V7p5j.s:162: Error: selected processor does not support
> ARM
> > > mode `strexb r0,r2,[r4]'
> >
> > Well it's not toolchain issue but the omap2plus_defconfig which
> > selects ARMv6 and ARMV7 together.
> >
> > If you remove ARCH_OMAP2 from build, it will go through.
>
> I like Catalin's approach:
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 49db8b3..0fe2389 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -644,7 +644,7 @@ config ARM_THUMBEE
>
>  config SWP_EMULATE
>         bool "Emulate SWP/SWPB instructions"
> -       depends on CPU_V7
> +       depends on CPU_V7 && !CPU_V6
>         select HAVE_PROC_CPU if PROC_FS
>         default y if SMP
>         help
>
> Simple.
>
This patch is good but it does tell you that if
you will V6 and v7 together, the feature can't be used.

Like omap2plus_defconfig, and if booted on
say omap3 or omap4(v7), swp emulation can't be used
even though its supported.

Regards,
Santosh
