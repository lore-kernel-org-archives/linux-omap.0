From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Fri, 16 Dec 2011 17:39:39 -0800
Message-ID: <20111217013939.GG6464@atomide.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59018 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab1LQBju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 20:39:50 -0500
Content-Disposition: inline
In-Reply-To: <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, MyungJoo Ham <myungjoo.ham@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Linux PM <linux-pm@vger.kernel.org>

* Omar Ramirez Luna <omar.ramirez@ti.com> [111214 19:47]:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations, reset and sysconfig
> handling.
> 
> Removed clk handling during interrupt, given that in order to receive one,
> the device should be powered on in advance. Now doing pm_runtime_get/put
> on iommu_enable/disable so it doesn't rely on others to keep the clocks on.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

The omap parts look OK to me for Ohad to queue:

Acked-by: Tony Lindgren <tony@atomide.com>
