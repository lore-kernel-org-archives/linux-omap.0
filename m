From: Tony Lindgren <tony@atomide.com>
Subject: Re: State of LDP3430 platform
Date: Mon, 6 Dec 2010 10:19:13 -0800
Message-ID: <20101206181913.GH8345@atomide.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12054 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab0LFSTZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 13:19:25 -0500
Content-Disposition: inline
In-Reply-To: <20101206125526.GC31777@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101206 04:45]:
>
> NET: Registered protocol family 16
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1185 _omap_hwmod_enable+0x34/0x114()
> omap_hwmod: wd_timer2: enabled state can only be entered from initialized, idle, or disabled state
> Modules linked in:
> ---[ end trace 1b75b31a2719ed1c ]---
> wd_timer2: Could not enable clocks for omap2_disable_wdt

Can you check if these patches posted by Paul earlier help?

OMAP: wd_timer: update integration code to use new hwmod change
https://patchwork.kernel.org/patch/327472/

OMAP2+: wd_timer: disable on boot via hwmod postsetup mechanism
https://patchwork.kernel.org/patch/327492/

OMAP: wd_timer: remove old, dead probing code
https://patchwork.kernel.org/patch/327482/

Regards,

Tony
