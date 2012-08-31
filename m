From: Tony Lindgren <tony@atomide.com>
Subject: Re: Without MACH_ option Early printk (DEBUG_LL)
Date: Fri, 31 Aug 2012 10:06:14 -0700
Message-ID: <20120831170614.GP1303@atomide.com>
References: <5040D03B.2050304@ti.com>
 <20120831155226.GL1303@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA9EB0F@DBDE01.ent.ti.com>
 <20120831161122.GO1303@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA9EBD1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31736 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754286Ab2HaRGd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 13:06:33 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA9EBD1@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120831 09:47]:
> > On Fri, Aug 31, 2012 at 21:41:22, Tony Lindgren wrote:
> 
> Can you please review below patch? If you think its ok, I will send the 
> patch -

Yeah thanks looks OK to me, at least I can't think of better options for now.

Regards,

Tony
 
 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index fccbdf0..eccafb4 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -104,6 +104,9 @@ config SOC_AM33XX
>         select CPU_V7
>         select ARM_CPU_SUSPEND if PM
>         select MULTI_IRQ_HANDLER
> +       select MACH_AM335XEVM
> +       select MACH_AM335XIAEVM
> +       select MACH_TAM335X
> 
>  config OMAP_PACKAGE_ZAF
>         bool
> @@ -140,6 +143,15 @@ config MACH_OMAP_GENERIC
>           Support for generic TI OMAP2+ boards using Flattened Device Tree.
>           More information at Documentation/devicetree
> 
> +config MACH_AM335XEVM
> +       bool
> +
> +config MACH_AM335XIAEVM
> +       bool
> +
> +config MACH_TAM335X
> +       bool
> +
>  config MACH_OMAP2_TUSB6010
>         bool
>         depends on ARCH_OMAP2 && SOC_OMAP2420
> 
> Thanks,
> Vaibhav
