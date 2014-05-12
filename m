From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 12 May 2014 08:03:52 -0700
Message-ID: <20140512150351.GE31772@atomide.com>
References: <1399895353-3663-1-git-send-email-pekon@ti.com>
 <1399895353-3663-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10528 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752274AbaELPD5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 11:03:57 -0400
Content-Disposition: inline
In-Reply-To: <1399895353-3663-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, bcousson@baylibre.com

Hi,

* Pekon Gupta <pekon@ti.com> [140512 04:50]:
> +
> +&gpmc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_flash_x16>;
> +	ranges = <0 0 0 0x01000000>;	/* CS0: min address-space configurable under GPMC chip-select = 16MB*/
> +	nand@0,0 {
> +		reg = <0 0 0x380>; /* CS0, offset=0x0, GPMC register-space size=0x380 */

Just a nitpick comment on the comments.. But as we've gotten them
wrong for almost every GPMC entry so far, we should fix it.

The "GPMC register-space" here can be a bit confusing still
as they are really the the device IO registers. I suggest we
standardize the comments like this for GPMC:

&gpmc {
	pinctrl-names = "default";
	pinctrl-0 = <&nand_flash_x16>;
	ranges = <0 0 0 0x01000000>;	/* 16MB GPMC partition */
	nand@0,0 {
		reg = <0 0 0x380>;	/* device IO registers */
		...
};

Regards,

Tony
