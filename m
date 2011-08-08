From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Build failure: bisected: v3.1-rc1 with config ARCH_OMAP &&
 !ARCH_OMAP4 fails with linker error
Date: Mon, 8 Aug 2011 14:36:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108081435340.4764@utopia.booyaka.com>
References: <1312819724.14483.29.camel@morsingpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38782 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab1HHUgs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 16:36:48 -0400
In-Reply-To: <1312819724.14483.29.camel@morsingpad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Morsing <daniel.morsing@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi

On Mon, 8 Aug 2011, Daniel Morsing wrote:

> Building the v3.1-rc1 kernel with ARCH_OMAP && !ARCH_OMAP4 support fails
> on linking with the following error
> 
> ...
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o:(.data+0xf7d8): undefined reference to `omap4430_phy_init'
> arch/arm/mach-omap2/built-in.o:(.data+0xf7dc): undefined reference to `omap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0xf7e0): undefined reference to `omap4430_phy_power'
> arch/arm/mach-omap2/built-in.o:(.data+0xf7e4): undefined reference to `omap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0xf7e8): undefined reference to `omap4430_phy_suspend'
> 
> I've bisected the first bad commit to "OMAP4: Move common twl6030
> configuration to twl-common" (commit-id
> b22f954bae35be115a10c6426dc070f7d652b32e). The problem seems to be
> unconditionally taking a function pointer to an omap4430 specific
> function in arch/arm/mach-omap2/twl-common.c. The definition for
> omap4430_phy_init and friends is in
> arch/arm/mach-omap2/omap_phy_internal.c, which is only compiled when
> building with support for one of the omap4430 boards.

Thanks for the bisect; this should be fixed by 

https://patchwork.kernel.org/patch/963462/


- Paul
