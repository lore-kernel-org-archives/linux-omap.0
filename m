From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/5] OMAP: mux: Add support for control module split in
 several partitions
Date: Fri, 24 Sep 2010 17:22:28 -0700
Message-ID: <20100925002228.GP4211@atomide.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <1285319748-28976-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56857 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab0IYAW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 20:22:26 -0400
Content-Disposition: inline
In-Reply-To: <1285319748-28976-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Benoit,

* Benoit Cousson <b-cousson@ti.com> [100924 02:07]:
> Starting on OMAP4, the pin mux configuration is located in two
> different partitions of the control module (CODE_PAD and WKUP_PAD).
> The first one is inside the core power domain whereas the second
> one is inside the wakeup.
> Since each partition has a different physical base address, an
> ID is added for each mux entry in order to identify the proper
> partition and thus the correct base address.

Few comments below..
 
>  /**
>   * struct omap_mux - data for omap mux register offset and it's value
>   * @reg_offset:	mux register offset from the mux base
>   * @gpio:	GPIO number
> + * @id:		Partition identifier
>   * @muxnames:	available signal modes for a ball
>   */
>  struct omap_mux {
>  	u16	reg_offset;
>  	u16	gpio;
> +	u8	id;
>  #ifdef CONFIG_OMAP_MUX
>  	char	*muxnames[OMAP_MUX_NR_MODES];
>  #ifdef CONFIG_DEBUG_FS

We might want to think a bit more how we want to handle the various
partitions for registers.

What do you think of the following:

We could convert u16 reg_offset into u32 reg_phys, and build the ioremap
areas based on those ranges.

After ioremap we're copying the data for used pins anyways, so we could 
write them as virtual addresses.

struct omap_mux {
	union mux_reg_union {
		u32		reg_phys;
		void __iomem	*reg_virt; 
	};
	u16	gpio;
#ifdef CONFIG_OMAP_MUX
	char	*muxnames[OMAP_MUX_NR_MODES];
#ifdef CONFIG_DEBUG_FS
	char	*balls[OMAP_MUX_NR_SIDES];
#endif
#endif
};

This would make the code more generic and simplify some parts of the
code. Muxing signals based on the signal name or gpio number would
work transparently

Then omapX_mux_init(board_mux, OMAP_PACKAGE_XYZ) would work
in a transparent way, but would have to figure out the partition
from the define.

If we wanted to use only the offset in the data, we could initialize
the various sections separately. But then omapX_mux_init() would have
to know the partition number somehow..

Regards,

Tony
