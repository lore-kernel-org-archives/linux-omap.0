From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH:v4 00/13] OMAP: GPIO: Implement GPIO in HWMOD way
Date: Tue, 6 Jul 2010 16:17:41 +0300
Message-ID: <20100706131741.GR3192@atomide.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49310 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968Ab0GFNRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 09:17:47 -0400
Content-Disposition: inline
In-Reply-To: <1277218916-15213-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, rnayak@ti.com, p-basak2@ti.com, b-cousson@ti.com

* Charulatha V <charu@ti.com> [100622 17:55]:
> This patch series makes OMAP2PLUS specific GPIO implemented in HWMOD
> FW way. This is done by implementing GPIO module in platform device model.
> 
> This patch series is generated on "origin/pm-wip/hwmods-omap4".

Do we still have a dependency on this series to pm-wip?

Can you please try to rebase this on top of linux-omap for-next
branch?

Let's see if we can merge this into linux-omap master
branch for some testing before we merge it.

Regards,

Tony
