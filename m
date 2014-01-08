From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP2: fix interrupt number for rng
Date: Tue, 7 Jan 2014 16:28:44 -0800
Message-ID: <20140108002843.GI5074@atomide.com>
References: <1387839579-58292-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51524 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbaAHA2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jan 2014 19:28:49 -0500
Content-Disposition: inline
In-Reply-To: <1387839579-58292-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk

* Suman Anna <s-anna@ti.com> [131223 15:01]:
> The irq data for rng module defined in hwmod data previously
> missed the OMAP_INTC_START relative offset, so the interrupt
> number is probably misconfigured during the DT node addition
> adjusting for this OMAP_INTC_START. Interrupt #36 is associated
> with a watchdog timer, so fix the rng module's interrupt to the
> appropriate interrupt #52.

Hmm indeed as the .dtsi files were generated from the hwmod
data. Are the other interrupts fixed earlier OK?

With earlier I mean your commit 6d4c8830479444 (ARM: OMAP2+:
hwmod_data: fix missing OMAP_INTC_START in irq data).

Regards,

Tony
