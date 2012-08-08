From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Fix multi.h when only ARCH_OMAP3 and SOC_AM33XX
 are selected
Date: Wed, 8 Aug 2012 07:23:10 -0700
Message-ID: <20120808142309.GH11011@atomide.com>
References: <1344356985-21801-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25948 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2HHOXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 10:23:13 -0400
Content-Disposition: inline
In-Reply-To: <1344356985-21801-1-git-send-email-jlu@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jan Luebbe <jlu@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

* Jan Luebbe <jlu@pengutronix.de> [120807 09:30]:
> When only ARCH_OMAP3 (or -2,-4,...) and SOC_AM33XX are selected, multi.h
> doesn't set MULTI_OMAP2. In this case, cpu.h will simply define
> cpu_is_omap24xx() as 1.
> 
> This causes problems for example for omap_hwmod.c:omap_hwmod_init which
> checks for cpu_is_omap24xx() first, using the wrong soc_ops for AM33xx.
> 
> Fix this by defining MULTI_OMAP2 when using SOC_AM33XX together with
> something else.

Thanks applying into fixes.

Tony
