From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: gpio: omap3_gpio_pads_init current only works
 for omap3
Date: Tue, 3 Aug 2010 10:54:52 +0300
Message-ID: <20100803075451.GU12293@atomide.com>
References: <20100713145953.GA17852@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52186 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab0HCHy1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 03:54:27 -0400
Content-Disposition: inline
In-Reply-To: <20100713145953.GA17852@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: janboe <janboe.ye@gmail.com>
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

* janboe <janboe.ye@gmail.com> [100713 18:06]:
> Since omap4 gpio pad config offset is different with omap3, so
> omap3_gpio_pads_init only works for omap3, and this will break
> omap4 build.

<snip>

> -/*
> - * Following pad init code in addition to the context / restore hooks are
> - * needed to fix glitches in GPIO outputs during off-mode. See OMAP3
> - * errate section 1.158
> - */
> -static int __init omap3_gpio_pads_init(void)
> -{
> -	int i, j, min, max, gpio_amt;
> -	u16 offset;

How about just add this to the existing function:

	if (!cpu_is_omap34xx())
		return -ENODEV;

Regards,

Tony
