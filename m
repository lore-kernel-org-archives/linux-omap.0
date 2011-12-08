From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] am35xx-emac: move generic EMAC init to separate file
Date: Wed, 7 Dec 2011 16:15:03 -0800
Message-ID: <20111208001503.GV31337@atomide.com>
References: <1321490199-24371-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57797 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753223Ab1LHAPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 19:15:07 -0500
Content-Disposition: inline
In-Reply-To: <1321490199-24371-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

* Ilya Yanok <yanok@emcraft.com> [111116 16:01]:
> AM35xx SoCs include DaVinci EMAC IP. Initialization code in
> board-am3517evm.c is pretty board independent and will work for any
> AM35xx based board so move this code to it's own file to be reused by
> other boards.

Should this be just called emac-common.c? Or is it so am35xx specific
that it won't work with others?
 
> +	clk_add_alias(NULL, dev_name(&am35xx_emac_device.dev),
> +		      "emac_clk", &am35xx_emac_device.dev);
> +	clk_add_alias(NULL, dev_name(&am35xx_mdio_device.dev),
> +		      "phy_clk", &am35xx_emac_device.dev);

Hmm after moving the code and should be a separate patch, don't
we already have these clock aliases in cloc3xxx_data.c?

Tony
