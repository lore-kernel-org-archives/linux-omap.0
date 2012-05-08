From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP2+: CLEANUP: Remove unnecessary ifdef
 around __omap2_set_globals
Date: Tue, 8 May 2012 09:11:15 -0700
Message-ID: <20120508161114.GW5088@atomide.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
 <1336489364-19200-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34021 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab2EHQLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 12:11:18 -0400
Content-Disposition: inline
In-Reply-To: <1336489364-19200-4-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120508 08:10]:
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -20,12 +20,16 @@ config ARCH_OMAP2PLUS_TYPICAL
>  	help
>  	  Compile a kernel suitable for booting most boards
>  
> +config SOC_HAS_SDRC
> +	bool "SDRAM Controller support"
> +
>  config ARCH_OMAP2
>  	bool "TI OMAP2"
>  	depends on ARCH_OMAP2PLUS
>  	default y
>  	select CPU_V6
>  	select MULTI_IRQ_HANDLER
> +	select SOC_HAS_SDRC
>  
>  config ARCH_OMAP3
>  	bool "TI OMAP3"

These still need to have OMAP in them, and ideally the type
of the block. Something like SOC_HAS_OMAP2_SDRC?

Regards,

Tony
