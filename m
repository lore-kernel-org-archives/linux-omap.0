From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/4] ARM: dts: am437x-gp-evm: add support for parallel
 NAND flash
Date: Tue, 6 May 2014 08:39:57 -0700
Message-ID: <20140506153956.GE18474@atomide.com>
References: <1398152020-19391-1-git-send-email-pekon@ti.com>
 <1398152020-19391-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:12978 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751085AbaEFPkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 11:40:01 -0400
Content-Disposition: inline
In-Reply-To: <1398152020-19391-3-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: bcousson@baylibre.com, linux-omap <linux-omap@vger.kernel.org>

* Pekon Gupta <pekon@ti.com> [140422 00:34]:
> +&gpmc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_flash_x8>;
> +	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */

Please use the minimum size 16MB GPMC range here, NAND only
has few registers addressable unlike NOR that actually uses the
whole range.

> +	nand@0,0 {
> +		reg = <0 0 0>; /* CS0, offset 0 */

Then here map the true size of the NAND device IO register area.

BTW, we should do the similar changes to other files so we can
unify the GPMC partitioning a bit. But that's unsafe to do until 
we have fixed the issue of mapping GPMC devices to a different
location from the bootloader location.

Regards,

Tony
