From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Tue, 5 Jun 2012 04:28:34 -0700
Message-ID: <20120605112834.GO12766@atomide.com>
References: <1336655139-8908-1-git-send-email-govindraj.raja@ti.com>
 <1336729242-16168-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52260 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934013Ab2FEL2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 07:28:38 -0400
Content-Disposition: inline
In-Reply-To: <1336729242-16168-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>, Paul Walmsley <paul@pwsan.com>, Ameya Palande <ameya.palande@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [120511 02:45]:
> From: "Govindraj.R" <govindraj.raja@ti.com>
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
>  #else
> -static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
> +static void __init omap_serial_check_wakeup(struct omap_board_data *bdata
> +		struct omap_uart_state *uart) {}
>  #endif

There's a comma missing here that breaks CONFIG_OMAP_MUX is not set here   ^^^.
I've updated the patch to add it.

Tony
