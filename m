From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Add OMAP4 Panda Support
Date: Fri, 25 Jun 2010 06:59:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032194B79C@dbde02.ent.ti.com>
References: <1277407989-30914-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45781 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab0FYB3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 21:29:16 -0400
In-Reply-To: <1277407989-30914-1-git-send-email-x0132446@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Anders, David" <x0132446@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

> +static void __init omap4_panda_init(void)
> +{
> +	int status;
> +
> +	omap4_panda_i2c_init();
> +	omap_serial_init();
> +	omap4_twl6030_hsmmc_init(mmc);
> +	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
> +	usb_nop_xceiv_register();
> +	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
> +	if (!cpu_is_omap44xx())
> +		usb_musb_init(&musb_board_data);
> +}

Dave,

I think this should be resolved by now - the OMAP4 MUSB support went
through linux-usb for .35-rc1. So it should be safe to call
usb_musb_init() unconditionally.

(Not actually tested by me yet. I'll try and do this tomorrow).


- Anand
