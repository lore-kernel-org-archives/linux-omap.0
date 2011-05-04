From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] OMAP PM: create a PM layer plugin for per-device
 constraints
Date: Wed, 4 May 2011 06:59:30 -0700
Message-ID: <20110504135930.GE2092@atomide.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
 <1304516117-9334-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33351 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753560Ab1EDN7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 09:59:34 -0400
Content-Disposition: inline
In-Reply-To: <1304516117-9334-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> [110504 06:32]:
>
> +int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
...

> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
...

> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
...

You should implement this as a Linux generic framework, we don't
want to add more omap specific frameworks.

Or maybe you can leave this out if they're just stubs for TI CDP code?

Tony
