From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 3/7] OMAP: mux: Add support for control module split
 in several partitions
Date: Thu, 11 Nov 2010 08:35:47 -0800
Message-ID: <20101111163547.GO9264@atomide.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
 <1287526956-21853-4-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56874 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0KKQfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 11:35:54 -0500
Content-Disposition: inline
In-Reply-To: <1287526956-21853-4-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Benoit Cousson <b-cousson@ti.com> [101019 15:14]:
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> +
> +/**
> + * struct mux_partition - contain partition related information
> + * @name: name of the current partition
> + * @flags: flags specific to this partition
> + * @phys: physical address
> + * @size: partition size
> + * @base: virtual address after ioremap
> + * @muxmodes: list of nodes that belong to a partition
> + * @node: list node for the partitions linked list
> + */
> +struct omap_mux_partition {
> +	const char		*name;
> +	u32			flags;
> +	u32			phys;
> +	u32			size;
> +	void __iomem		*base;
> +	struct list_head	muxmodes;
> +	struct list_head	node;
> +};

With the omap_mux_parition..
  
>  /**
>   * struct omap_mux - data for omap mux register offset and it's value
>   * @reg_offset:	mux register offset from the mux base
>   * @gpio:	GPIO number
> + * @id:		Partition identifier
>   * @muxnames:	available signal modes for a ball
>   */
>  struct omap_mux {
> @@ -82,6 +114,7 @@ struct omap_mux {
>  	char	*muxnames[OMAP_MUX_NR_MODES];
>  #ifdef CONFIG_DEBUG_FS
>  	char	*balls[OMAP_MUX_NR_SIDES];
> +	struct omap_mux_partition *partition;
>  #endif
>  #endif
>  };
> @@ -89,6 +122,7 @@ struct omap_mux {
>  /**
>   * struct omap_ball - data for balls on omap package
>   * @reg_offset:	mux register offset from the mux base
> + * @id:		Partition identifier
>   * @balls:	available balls on the package
>   */
>  struct omap_ball {
> @@ -100,6 +134,7 @@ struct omap_ball {
>   * struct omap_board_mux - data for initializing mux registers
>   * @reg_offset:	mux register offset from the mux base
>   * @mux_value:	desired mux value to set
> + * @id:		Partition identifier
>   */
>  struct omap_board_mux {
>  	u16	reg_offset;

..I think the above changes are no longer needed.

Regards,

Tony
