From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND] [PATCH 1/2] OMAP1: allow reserving memory for camera
Date: Fri, 10 Dec 2010 17:03:56 +0000
Message-ID: <20101210170356.GA28472@n2100.arm.linux.org.uk>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl> <201012101159.21845.jkrzyszt@tis.icnet.pl> <201012101203.09441.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36044 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0LJREh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 12:04:37 -0500
Content-Disposition: inline
In-Reply-To: <201012101203.09441.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Fri, Dec 10, 2010 at 12:03:07PM +0100, Janusz Krzysztofik wrote:
>  void __init omap1_camera_init(void *info)
>  {
>  	struct platform_device *dev = &omap1_camera_device;
> +	dma_addr_t paddr = omap1_camera_phys_mempool_base;
> +	dma_addr_t size = omap1_camera_phys_mempool_size;
>  	int ret;
>  
>  	dev->dev.platform_data = info;
>  
> +	if (paddr) {
> +		if (dma_declare_coherent_memory(&dev->dev, paddr, paddr, size,
> +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE))

Although this works, you're ending up with SDRAM being mapped via
ioremap, which uses MT_DEVICE - so what is SDRAM ends up being
mapped as if it were a device.

For OMAP1, which is ARMv5 or lower, device memory becomes 'uncacheable,
unbufferable' which is luckily what is used for the DMA coherent
memory on those platforms - so no technical problem here.

However, on ARMv6 and later, ioremapped memory is device memory, which
has different ordering wrt normal memory mappings, and may appear on
different busses on the CPU's interface.  So, this is something I don't
encourage as it's unclear that the hardware will work.

Essentially, dma_declare_coherent_memory() on ARM with main SDRAM should
be viewed as a 'it might work, it might not, and it might stop working
in the future' kind of interface.  In other words, there is no guarantee
that this kind of thing will be supported in the future.
