From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 29 Jun 2012 02:05:16 -0700
Message-ID: <20120629090515.GA4202@atomide.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <20120629055509.11091.2780.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14819 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab2F2JFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 05:05:21 -0400
Content-Disposition: inline
In-Reply-To: <20120629055509.11091.2780.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, rostedt@goodmis.org

* Andy Green <andy.green@linaro.org> [120628 22:59]:
> 
> Introduce a generic helper function that can generate a valid MAC
> address using data from the OMAP unique CPU ID register.
...

> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -530,3 +530,42 @@ void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
>  	else
>  		tap_prod_id = 0x0208;
>  }
> +
> +/*
> + * this uses the unique per-cpu info from the cpu fuses set at factory to
> + * generate a 6-byte MAC address.  Two bits in the generated code are used
> + * to elaborate the generated address into four, so it can be used on multiple
> + * network interfaces.
> + */
> +
> +void omap2_die_id_to_ethernet_mac(u8 *mac, int subtype)
> +{
> +	struct omap_die_id odi;
> +	u32 tap = read_tap_reg(OMAP_TAP_IDCODE);
> +
> +	omap_get_die_id(&odi);
> +
> +	mac[0] = odi.id_2;
> +	mac[1] = odi.id_2 >> 8;
> +	mac[2] = odi.id_1;
> +	mac[3] = odi.id_1 >> 8;
> +	mac[4] = odi.id_1 >> 16;
> +	mac[5] = odi.id_1 >> 24;
> +
> +	/* XOR other chip-specific data with ID */
> +
> +	tap ^= odi.id_3;
> +
> +	mac[0] ^= tap;
> +	mac[1] ^= tap >> 8;
> +	mac[2] ^= tap >> 16;
> +	mac[3] ^= tap >> 24;
> +
> +	/* allow four MACs from this same basic data */
> +
> +	mac[1] = (mac[1] & ~0xc0) | ((subtype & 3) << 6);
> +
> +	/* mark it as not multicast, and outside official 80211 MAC namespace */
> +
> +	mac[0] = (mac[0] & ~1) | 2;
> +}

Let's just make this omap_die_id_to_ethernet_mac, no need to keep the
omap2 naming there as this should not conflict with any omap1 stuff.

Tony
