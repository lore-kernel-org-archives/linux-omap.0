From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from
 driver
Date: Tue, 8 Mar 2011 15:38:21 -0800
Message-ID: <20110308233820.GJ26463@atomide.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
 <4D76A164.2060801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30438 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428Ab1CHXih (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:38:37 -0500
Content-Disposition: inline
In-Reply-To: <4D76A164.2060801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Andy Green <andy@warmcat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Cousson, Benoit <b-cousson@ti.com> [110308 13:34]:
> Hi Andy,
> 
> Thanks for that really fast update. That looks pretty good at first
> glance. I still have to review in details.

Yes nice job!
 
> And we need to find some volunteers for OMAP1 & 2 testing.

I gave it a quick try on osk5912, seems to work just fine.
Will apply these for testing purposes to linux-omap tree while
waiting for the minor fixes.

Looks like Benoit should take the arch/arm/*omap*/*hwmod*
patches, the rest should go throug Ben. So for all of them:

Acked-by: Tony Lindgren <tony@atomide.com>
