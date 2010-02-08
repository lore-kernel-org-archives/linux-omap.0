From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: Re: [PATCH v2 2/3] OMAP: SDP: Introducing 'board-sdp-flash.c' for
	flash init
Date: Mon, 8 Feb 2010 14:52:09 +0100
Message-ID: <20100208135209.GA11847@localhost.localdomain>
References: <ce9ab5791002080347q3c8a73bvf80736b125cfac1@mail.gmail.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.76.43]:59525 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab0BHMwO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 07:52:14 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5791002080347q3c8a73bvf80736b125cfac1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
> b/arch/arm/mach-omap2/board-sdp-flash.c
> new file mode 100644
> index 0000000..54ef19f
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-sdp-flash.c
[snip]
> +static void omap_set_vpp(struct map_info *map, int enable)
> +{
> +	static int      count;
> +	u32 l;
> +
> +	if (cpu_class_is_omap1()) {
> +		if (enable) {
> +			if (count++ == 0) {
> +				l = omap_readl(EMIFS_CONFIG);
> +				l |= OMAP_EMIFS_CONFIG_WP;
> +				omap_writel(l, EMIFS_CONFIG);
> +			}
> +		} else {
> +			if (count && (--count == 0)) {
> +				l = omap_readl(EMIFS_CONFIG);
> +				l &= ~OMAP_EMIFS_CONFIG_WP;
> +				omap_writel(l, EMIFS_CONFIG);
> +			}
> +		}
> +	}
> +}

Hmm, as you are adding files into arch/arm/mach-omap2 directory, is there
a chance cpu_class_is_omap1() ever returns non-zero?

> +static struct physmap_flash_data sdp_nor_data = {
> +	.width		= 2,
> +	.set_vpp	= omap_set_vpp,
> +};

... and in case there is not, just leave set_vpp set to NULL and delete this
incarnation of omap_set_vpp.

