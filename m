From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MTD: NAND: ams-delta: drop omap_read/write, use ioremap
Date: Fri, 17 Dec 2010 15:52:19 -0800
Message-ID: <20101217235218.GU5941@atomide.com>
References: <201012151543.46341.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:37728 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab0LQXw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 18:52:59 -0500
Content-Disposition: inline
In-Reply-To: <201012151543.46341.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-mtd@lists.infradead.org, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101215 06:44]:
> There is a common requirement for not using OMAP specific omap_readw() / 
> omap_writew() function calls in drivers/, but replace them with 
> readw() / writew() on ioremap()ped addresses passed from arch/ instead.
> 
> The patch implements this idea for the Amstrad Delta NAND driver. To be 
> able to use the modified driver, the board file is updated with the 
> platform device I/O resource declaration, which is passed from there.
> 
> Created and tested against linux-2.6.37-rc5, on top of recent patch 
> 'MTD: NAND: ams-delta: convert to platform driver'.

Acked-by: Tony Lindgren <tony@atomide.com>
