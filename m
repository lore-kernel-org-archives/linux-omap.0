From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: mux: add support for PAD wakeup event
 handler
Date: Mon, 10 Sep 2012 11:39:44 -0700
Message-ID: <20120910183943.GA1303@atomide.com>
References: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41161 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932142Ab2IJSju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 14:39:50 -0400
Content-Disposition: inline
In-Reply-To: <1347273528-2056-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, keshava_mgowda@ti.com

* Ruslan Bilovol <ruslan.bilovol@ti.com> [120910 03:39]:
> OMAP mux now parses active wakeup events from pad registers and calls
> corresponding handler, if handler is not registered - corresponding
> hwmod ISRs once a wakeup is detected.
> This is useful for cases when routing wakeups to corresponding hwmod
> ISRs complicates those ISRs handlers (for example, ISR handler may
> not know who the interrupt source is)

The mux code in arch/arm/mach-omap2 will be going away and replaced
by device tree based pinctrl-single. It's not a good idea to add more
dependencies to custom frameworks as that just makes the transition
harder on us.

Regards,

Tony

