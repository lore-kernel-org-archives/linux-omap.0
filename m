From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: mux: Add api to retrieve padconf offset based on
 muxname
Date: Thu, 1 Jul 2010 15:15:56 +0300
Message-ID: <20100701121556.GL2822@atomide.com>
References: <48791.192.168.10.88.1276524799.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53403 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab0GAMPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 08:15:46 -0400
Content-Disposition: inline
In-Reply-To: <48791.192.168.10.88.1276524799.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

* Govindraj.R <govindraj.raja@ti.com> [100614 17:07]:
> Adds a padconf offset retrieval api which will
> get us the padconf offset based on muxname provided
> which can be later used with omap_ctrl_writew,
> omap_ctrl_readw calls for remuxing signals.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> Patch is based on earlier discussion with Tony
> http://marc.info/?l=linux-omap&m=127609369220618&w=2
> 
>  arch/arm/mach-omap2/mux.c |   17 +++++++++++++++++
>  arch/arm/mach-omap2/mux.h |    6 ++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 8b3d269..afe45ce 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -882,6 +882,23 @@ free:
> 
>  #endif	/* CONFIG_OMAP_MUX */
> 
> +u16 omap_mux_request_signal(char *muxname)
> +{
> +	struct omap_mux_entry *e;
> +	u16 offset = -EINVAL;
> +
> +	list_for_each_entry(e, &muxmodes, node) {
> +		struct omap_mux *m = &e->mux;
> +		char *m0_entry = m->muxnames[0];
> +
> +		if (!strcmp(muxname, m0_entry)) {
> +			offset = m->reg_offset + OMAP_MUX_BASE_OFFSET;
> +			break;
> +		}
> +	}
> +	return offset;
> +}

You need to consider few more things..

Note that omap_mux_late_init frees the memory for all pins except
for GPIO pins unless CONFIG_DEBUG_FS is set.

This means that omap_mux_request_signal needs to be __init function
and accessible only in the board-*.c files. Then the board-*.c file
can then implement it's pin muxing functions and pass the function 
pointers along to a driver via platform data as needed. Then the
driver can call the board specific function if implemented.

Then you need to also consider full pin names such as
mcbsp2_clkx.gpio_12. Relying on the mode0 name is not enough
as there can be multiple pinouts. Also from user point of view
it is confusing to have to look up the mode0 name when 
omap_mux_request_signal can do the work.

Then you probably want to add a comment about using omap_mux_read/write
on the returned offset to avoid accidentally modifying other
registers :)

Anyways, please also make sure you code does the right thing
with CONFIG_OMAP_MUX set and not set, and CONFIG_DEBUG_FS
set and not set.

Regards,

Tony
