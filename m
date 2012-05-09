From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source
 selection runtime
Date: Wed, 9 May 2012 10:33:06 -0700
Message-ID: <20120509173305.GR5088@atomide.com>
References: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36072 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2EIRdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 13:33:09 -0400
Content-Disposition: inline
In-Reply-To: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120503 01:02]:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
 
I'll apply these into cleanup-timer branch now that we have the
related hwmod patches merged into devel-hwmod-data.

Regards,

Tony
