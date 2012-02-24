From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/6] ARM: OMAP3: Mark only those mmc devices which use
 gpio_cd, as deferred
Date: Fri, 24 Feb 2012 14:21:36 -0800
Message-ID: <20120224222136.GB18901@atomide.com>
References: <1330077537-19618-1-git-send-email-rnayak@ti.com>
 <1330077537-19618-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52509 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758181Ab2BXWVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 17:21:39 -0500
Content-Disposition: inline
In-Reply-To: <1330077537-19618-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120224 01:27]:
> mmc devices which actually do not depend on twl4030-gpio for
> gpio_cd should not be maked as deferred.
> 
> Also on overo, since none of the mmc devices need to be deferred,
> get rid of omap_hsmmc_late_init() altogether.
> 
> Reported-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, I'll fold this into the original patch with your SOB
so we avoid the extra churn.

Regards,

Tony
