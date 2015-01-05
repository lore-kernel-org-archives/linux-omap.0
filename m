From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 1/9] ARM: OMAP2+: use common l2cache initialization
 code
Date: Mon, 5 Jan 2015 08:21:12 -0800
Message-ID: <20150105162111.GA4081@atomide.com>
References: <1420460348-20302-1-git-send-email-m.szyprowski@samsung.com>
 <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49917 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbbAEQZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2015 11:25:08 -0500
Content-Disposition: inline
In-Reply-To: <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linus.walleij@linaro.org, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>, nm@ti.com, khilman@linaro.org

* Marek Szyprowski <m.szyprowski@samsung.com> [150105 04:22]:
> This patch implements generic DT L2C initialisation (the one from
> init_IRQ in arch/arm/kernel/irq.c) for Omap4 and AM43 platforms and
> kills the SoC specific stuff in arch/arm/mach-omap2/omap4-common.c.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Seems to work just fine for me:

Acked-by: Tony Lindgren <tony@atomide.com>
