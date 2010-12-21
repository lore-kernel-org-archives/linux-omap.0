From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Add 104MHz support for OMAP OneNAND
Date: Tue, 21 Dec 2010 12:18:31 -0800
Message-ID: <20101221201831.GI5829@atomide.com>
References: <20101221194433.3127.74744.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48412 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab0LUUSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 15:18:42 -0500
Content-Disposition: inline
In-Reply-To: <20101221194433.3127.74744.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

* Adrian Hunter <adrian.hunter@nokia.com> [101221 11:44]:
> Hi
> 
> Here is OMAP2/3: OneNAND: add 104MHz support.
> 
> Adrian Hunter (2):
>       OMAP2/3: GPMC: put sync_clk value in picoseconds instead of nanoseconds
>       OMAP2/3: OneNAND: add 104MHz support

Gave these a quick try and the GPMC changes work fine for smc91x
on 2430sdp and tusb6010 g_ether for n810.  So I'll queue these,
thanks.

Tony
