From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Thu, 10 May 2012 12:11:52 -0700
Message-ID: <20120510191152.GN21851@atomide.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61424 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480Ab2EJTLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 15:11:55 -0400
Content-Disposition: inline
In-Reply-To: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>, Paul Walmsley <paul@pwsan.com>, Ameya Palande <ameya.palande@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [120510 06:09]:
> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> The commit (bce492c0  ARM: OMAP2+: UART: Fix incorrect population of
> default uart pads) removed default uart pads that where getting populated
> and which was making rx pin wakeup capable. If uart pads was used in

Nitpick.. this should say "were used" here                 ^^^

> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -295,8 +353,7 @@ void __init omap_serial_board_init(struct omap_uart_port_info *info)
>  		bdata.pads = NULL;
>  		bdata.pads_cnt = 0;
>  
> -		if (cpu_is_omap44xx() || cpu_is_omap34xx())
> -			omap_serial_fill_default_pads(&bdata);
> +		omap_serial_check_wakeup(&bdata, uart);

Should this section become:

		if (!info) {
			omap_serial_check_wakeup(&bdata, uart);
			omap_serial_init_port(&bdata, NULL);
		} else {
			omap_serial_init_port(&bdata, &info[uart->num]);
		}

As if you have bdata, then there should not be anything to mux,
right?

Regards,

Tony
