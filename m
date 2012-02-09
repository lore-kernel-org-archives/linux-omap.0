From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Thu, 9 Feb 2012 09:27:47 -0800
Message-ID: <20120209172747.GG1426@atomide.com>
References: <20120208184539.GE29796@atomide.com>
 <87ty312ae0.fsf@ti.com>
 <20120208235358.GD16877@atomide.com>
 <20120208235620.GE25414@n2100.arm.linux.org.uk>
 <87sjikx3xv.fsf@ti.com>
 <20120209001135.GF25414@n2100.arm.linux.org.uk>
 <87ipjgx3g3.fsf@ti.com>
 <20120209004027.GF16877@atomide.com>
 <20120209164913.GB19159@n2100.arm.linux.org.uk>
 <20120209171830.GH16877@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29681 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab2BIR1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 12:27:54 -0500
Content-Disposition: inline
In-Reply-To: <20120209171830.GH16877@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120209 08:47]:
> 
> So that leaves me only the second one to queue that adds checks
> for the PMIC info for boards that don't have it, see below.
...
 
> From d269914ece0498f31603ecd85ed3d7a586b3cbcd Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Fri, 30 Sep 2011 11:24:04 -0700
> Subject: [PATCH] ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
> 
> Current code registers voltage layer details for TWL PMIC even when a TWL
> has not been registered.  Fix this to only register the TWL with voltage
> layer when the TWL PMIC is initialized by board-level code.
> 
> Tested-by: Abhilash Koyamangalath <abhilash.kv@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Never mind. This one is already in mainline as commit
46232a3622c6e33605906ee6690dfef372925f53.

Regards,

Tony
