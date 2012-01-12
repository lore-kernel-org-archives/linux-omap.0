From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
Date: Thu, 12 Jan 2012 14:44:24 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201121441580.2722@xanadu.home>
References: <20120112184256.GA2287@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:64739 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab2ALToh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 14:44:37 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LXP00EAQARO93A0@VL-VM-MR001.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Thu, 12 Jan 2012 14:43:00 -0500 (EST)
In-reply-to: <20120112184256.GA2287@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu, 12 Jan 2012, Tony Lindgren wrote:

> Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
> (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
> into devel-stable) merged generic ioremap changes.
> 
> Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
> (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
> added a workaround for omap4.
> 
> In order for the errata to work, we now need the following
> patch or else we'll get:
> 
> kernel BUG at mm/vmalloc.c:1134!
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -132,6 +132,7 @@ void omap3_map_io(void);
>  void am33xx_map_io(void);
>  void omap4_map_io(void);
>  void ti81xx_map_io(void);
> +int omap_barriers_init(void);
>  
>  /**
>   * omap_test_timeout - busy-loop, testing a condition
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -306,7 +306,12 @@ void __init omapam33xx_map_common_io(void)
>  #ifdef CONFIG_ARCH_OMAP4
>  void __init omap44xx_map_common_io(void)
>  {
> +	int res;
> +
>  	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
> +	res = omap_barriers_init();
> +	if (res)
> +		pr_err("Barriers broken\n");

Do you really need that return code?

It was initially hooked to core_initcall() which requires a return code.  
Now that you call it directly you could get rid of it.


Nicolas
