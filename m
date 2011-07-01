From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/1] omap: blaze: add mmc5/wl1283 device support
Date: Fri, 1 Jul 2011 00:47:09 -0700
Message-ID: <20110701074708.GG23145@atomide.com>
References: <1308950189-7357-1-git-send-email-vishalm@ti.com>
 <1308950189-7357-2-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35294 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755294Ab1GAHrM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:47:12 -0400
Content-Disposition: inline
In-Reply-To: <1308950189-7357-2-git-send-email-vishalm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishal Mahaveer <vishalm@ti.com>
Cc: linux-omap@vger.kernel.org

* Vishal Mahaveer <vishalm@ti.com> [110624 12:43]:
> Add MMC5 support on BLAZE, which has the wl1283 device hardwired to.
> 
> The wl1283 is a 4-wire, 1.8V, embedded SDIO WLAN device with an external IRQ line,
> and power-controlled by a GPIO-based fixed regulator.

Applying into devel-board branch.

> +static struct fixed_voltage_config sdp4430_vwlan = {
> +	.supply_name = "vwl1271",
> +	.microvolts = 1800000, /* 1.8V */
> +	.gpio = GPIO_WIFI_PMENA,
> +	.startup_delay = 70000, /* 70msec */
> +	.enable_high = 1,
> +	.enabled_at_boot = 0,
> +	.init_data = &sdp4430_vmmc5,
> +};

Tabified this struct for better formatting.

Tony
