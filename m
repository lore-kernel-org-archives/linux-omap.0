From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/4] ARM: dts: dra7: add support for parallel NAND
 flash
Date: Tue, 6 May 2014 08:42:16 -0700
Message-ID: <20140506154215.GF18474@atomide.com>
References: <1398157362-32571-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18598 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932250AbaEFPmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 11:42:19 -0400
Content-Disposition: inline
In-Reply-To: <1398157362-32571-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: bcousson@baylibre.com, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>

* Pekon Gupta <pekon@ti.com> [140422 02:03]:
> +
> +&gpmc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_flash_x16>;
> +	ranges = <0 0 0x08000000 0x10000000>;

Here too please use the minimum 16MB GPMC partition for NAND.

> +	nand@0,0 {
> +		reg = <0 0 0>;

And the true IO range size of the device registers here for reg.

Cheers,

Tony
