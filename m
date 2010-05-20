From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 3/3 v2] musb: AM35x: Workaround for fifo read issue
Date: Thu, 20 May 2010 15:11:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322EAE899@dbde02.ent.ti.com>
References: <1274184586-28843-1-git-send-email-ajay.gupta@ti.com>
 <19F8576C6E063C45BE387C64729E7394044E535C95@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43395 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755131Ab0ETJl2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 05:41:28 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E535C95@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "andrea.marson@dave.eu" <andrea.marson@dave.eu>, Tony Lindgren <tony@atomide.com>

 
Gupta, Ajay Kumar wrote:
> Fixes/workaround based on CONFIG_MACH_OMAP3517EVM will be good only for
> OMAP3517EVM and would not scale well to other boards based on AM35x.
> (As commented earlier by Sergei)
> 
> I just got to know of another board "LIZARD" based on AM35x so we really
> need to find a solution for this. 
> 
> This problem is due to the fact that AM35x is based on OMAP35x but musb ip
> Is updated to RTL1.8 using CPPI4.1 DMA engine thus we need to have a
> config option to differentiate musb ips between actual OMAP3 and AM35x
> platforms.
> 
> I am thinking of adding new config option OMAP_MUSB_RTL18 which should be
> selected by all the boards based on AM35x in arch/arm/mach-omap2/Kconfig.
> 
> The same config option can be used for all the workaround/fixes specific
> to AM35x musb platform.
>  
> ------------------
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b72ae06..3ab1156 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -95,6 +95,7 @@ config MACH_OMAP3517EVM
>         bool "OMAP3517/ AM3517 EVM board"
>         depends on ARCH_OMAP3 && ARCH_OMAP34XX
>         select OMAP_PACKAGE_CBB
> +       select OMAP_MUSB_RTL18
> 
>  config PMIC_TPS65023
>         bool "TPS65023 Power Module"
> ------------------
> 
> Does anyone has a better option to fix this issue or any 
> comment on this approach?
> 

It would not scale very well - we already have multi-omap builds
that select support for multiple boards. If the AM35x boards are
part of such builds, then mutually exclusive config options won't
work - already n8x0 MUSB is exclusive with 243x/omap3.

If it is possible to detect the AM35x at runtime, then we could
handle this well. Also, a similar set of changes will be needed for
the DMA code as well (right now we can pick only one of the DMA
engines at a time).

- Anand
