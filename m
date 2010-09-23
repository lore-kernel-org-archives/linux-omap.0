From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v8 3/6] OMAP2430: hwmod data: Add watchdog timer
Date: Thu, 23 Sep 2010 16:25:11 +0100
Message-ID: <20100923152511.GA26295@n2100.arm.linux.org.uk>
References: <1285252363-3630-1-git-send-email-charu@ti.com> <1285252363-3630-4-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42208 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0IWPZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 11:25:34 -0400
Content-Disposition: inline
In-Reply-To: <1285252363-3630-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: tony@atomide.com, wim@iguana.be, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, khilman@deeprootsystems.com, rnayak@ti.com, p-basak2@ti.com

On Thu, Sep 23, 2010 at 08:02:40PM +0530, Varadarajan, Charulatha wrote:
> +static struct omap_hwmod omap2430_wd_timer2_hwmod = {
> +	.name		= "wd_timer2",
> +	.class		= &omap2430_wd_timer_hwmod_class,
> +	.main_clk	= "mpu_wdt_fck",

Why are we going backwards to naming clocks by source rather than
looking them up by device + connection ?
