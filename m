From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/7] OMAP: WDT: Implement WDT in hwmod way
Date: Fri, 17 Sep 2010 10:22:15 -0700
Message-ID: <20100917172215.GE29610@atomide.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58256 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab0IQRWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 13:22:23 -0400
Content-Disposition: inline
In-Reply-To: <1284733136-20952-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

* Varadarajan, Charulatha <charu@ti.com> [100917 07:11]:
> Series of patches to port watchdog module to use hwmod APIs
> for OMAP2PLUS chips and use runtime APIs for all OMAP chips.
> For this hwmod database for OMAP2PLUS watchdog instances are
> populated. This patch series also implements watchdog
> module to use PM runtime APIs.
> 
> This patch series is created on "origin/pm-core" and is
> tested on OMAP2430, OMAP44430, OMAP3430 SDP boards and zoom3 board.
> Also verified that this patch series does not break the OMAP1 build.
> 
> This series is tested on OMAP4430 ES2 using the below series
> http://www.spinics.net/lists/linux-omap/msg36023.html

Can you please list the exact dependencies to other patches
for the mainline kernel? Are they the same as for the
omap serial driver just posted?

Tony
