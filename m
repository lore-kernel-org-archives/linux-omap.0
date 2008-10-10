From: Tony Lindgren <tony@atomide.com>
Subject: Re: Failures with rc9
Date: Fri, 10 Oct 2008 13:13:08 +0300
Message-ID: <20081010101307.GL3044@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B020C2CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54421 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYJJKNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 06:13:13 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B020C2CF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [081010 13:02]:
> Hi all,
> 
> Noticed build failures with v2.6.27-rc9-5073-g5b99e69, when building for omap3_evm.
> 
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
> /home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:50: undefined reference to `twl4030_get_gpio_datain'
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_cleanup':
> /home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:82: undefined reference to `twl4030_free_gpio'
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_late_init':
> /home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:63: undefined reference to `twl4030_request_gpio'
> /home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:67: undefined reference to `twl4030_set_gpio_debounce'
> make: *** [.tmp_vmlinux1] Error 1

Sorry, you need to manually enable CONFIG_GPIO_TWL4030=y in your
.config until we have all the defconfigs updated.

Tony
