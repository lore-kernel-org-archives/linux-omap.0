From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/5] OMAP: mux: Add support for control module split in
 several partitions
Date: Mon, 27 Sep 2010 08:46:11 -0700
Message-ID: <20100927154611.GT4211@atomide.com>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com>
 <1285319748-28976-2-git-send-email-b-cousson@ti.com>
 <20100925002228.GP4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58599 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732Ab0I0PqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 11:46:05 -0400
Content-Disposition: inline
In-Reply-To: <20100925002228.GP4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Tony Lindgren <tony@atomide.com> [100924 17:14]:
> 
> * Benoit Cousson <b-cousson@ti.com> [100924 02:07]:
> 
> If we wanted to use only the offset in the data, we could initialize
> the various sections separately. But then omapX_mux_init() would have
> to know the partition number somehow..

After thinking about this a bit more, to me it seems like this is
the best way to go. Then there's no need to repeat the partition data
for each entry. How about this:

Earlier defines stay the same:

#define OMAP3_MUX(mode0, mux_value)					\
{									\
	.reg_offset	= (OMAP3_CONTROL_PADCONF_##mode0##_OFFSET),	\
	.value		= (mux_value),					\
}

Then for omap4, we need to add a separate board mux table for each
partition:

#define OMAP4_MUX_PARTXXX(mode0, mux_value)				\
{									\
	.reg_offset	= (OMAP4_PART_XXX_PADCONF_##mode0##_OFFSET),	\
	.value		= (mux_value),					\
}

#define OMAP4_MUX_PARTYYY(mode0, mux_value)				\
{									\
	.reg_offset	= (OMAP4_PARTYYY_PADCONF_##mode0##_OFFSET),	\
	.value		= (mux_value),					\
}
...

For omap2 and 3, we just call omap_mux_init once with the mux_pbase
as we currently already do. Then for omap4, we call omap_mux_init for
each partition.

We also need to change omap_mux_read/write to allow specifying the
partition base address:

u16 omap_mux_read(void __iomem *base, u16 offset)
{
	if (cpu_is_omap24xx())
		return __raw_readb(base + offset);
	else
		return __raw_readw(base + offset);
}

All the other mux interface functions can stay the same, we just need
to modify the mux.c code to look for signal names or GPIO number in
each registered partition.

Regards,

Tony
