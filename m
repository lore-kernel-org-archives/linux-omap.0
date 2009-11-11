From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP7XX] Add missing clocks for MMC
Date: Tue, 10 Nov 2009 16:36:15 -0800
Message-ID: <20091111003615.GH23952@atomide.com>
References: <6cb013310910031458x666606cagdd1c5f9d4fb26dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59501 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZKKAgL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 19:36:11 -0500
Content-Disposition: inline
In-Reply-To: <6cb013310910031458x666606cagdd1c5f9d4fb26dac@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [091003 15:09]:
> The omap730 and omap850 both use a different clock for the "fck"
> clock of the MMC interface than other omap processors based on the
> SOFT_REQ_REG, pin 12.  The "ick" clock is the same as that used
> by other omap processors.
> 
> * Added the missing clock definition as mmc3_ck to clock.h
> * Added the clock definition to omap_clks in clock.c
> * Added CK_7XX to the mmci-omap.0 "ick" clock already in clock.c
> 
> With this change, it is now possible to initialize and use MMC
> cards with omap730 and omap850 devices.

Pushing all the 7xx mmc platform init code as a single patch to
for-next today. Can you please check?

The drivers/mmc/host/omap.c patch you need to get merged via
linux-mmc@vger.kernel.org list :)

Tony
