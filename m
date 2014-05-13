From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/6] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Tue, 13 May 2014 10:31:04 -0700
Message-ID: <20140513173103.GI16837@atomide.com>
References: <1399668015-10499-1-git-send-email-pekon@ti.com>
 <1399668015-10499-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47417 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbaEMRbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 13:31:08 -0400
Content-Disposition: inline
In-Reply-To: <1399668015-10499-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: bcousson@baylibre.com, linux-omap <linux-omap@vger.kernel.org>

* Pekon Gupta <pekon@ti.com> [140509 13:41]:
> +&gpmc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_flash_x16>;
> +	ranges = <0 0 0 0x01000000>;	/* CS0: NAND */
> +	nand@0,0 {
> +		reg = <0 0 0x380>; /* CS0, offset=0x0, reg-map size=0x380 */

Just noticed this, can you please use the comments I suggested
here too?

That way we know which ones we've fixed up and can also
grep easier eventually to unify the GPMC mappings a bit.

Thanks,

Tony
