From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: pandaboard: fix up mmc card detect logic
Date: Mon, 18 Oct 2010 17:31:09 -0700
Message-ID: <20101019003109.GM13341@atomide.com>
References: <1287149087-16656-1-git-send-email-nm@ti.com>
 <2E5804DAE93D403D9F7FCEDBF6367E59@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61208 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab0JSAbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 20:31:14 -0400
Content-Disposition: inline
In-Reply-To: <2E5804DAE93D403D9F7FCEDBF6367E59@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Nishanth Menon' <nm@ti.com>, 'l-o' <linux-omap@vger.kernel.org>, 'Dave' <x0132446@ti.com>, 'Adrian Hunter' <adrian.hunter@nokia.com>, 'Samuel Ortiz' <sameo@linux.intel.com>

* Madhusudhan <madhu.cr@ti.com> [101018 09:57]:
> 
> 
> > -----Original Message-----
> > From: Nishanth Menon [mailto:nm@ti.com]
> > Sent: Friday, October 15, 2010 8:25 AM
> > To: l-o
> > Cc: Dave; Nishanth Menon; Tony Lindgren; Madhusudhan Chikkature; Adrian
> > Hunter; Samuel Ortiz
> > Subject: [PATCH] omap4: pandaboard: fix up mmc card detect logic
> > 
> > For MMC1 Controller, card detect interrupt source is
> > twl6030 which is non-gpio. The card detect call back function provides
> > card present/absent status by reading MMC Control register present
> > on twl6030. This functionality was introduced in mfd tree on
> > track to kernel.org
> > 
> > Sync pandaboard to the same and make mmc work.
> > 
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> > Cc: Adrian Hunter <adrian.hunter@nokia.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > 
> > Acked-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> 
> The patch looks good.
> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > 
> > Depends on
> > http://git.kernel.org/?p=linux/kernel/git/sameo/mfd-
> > 2.6.git;a=commitdiff;h=1bf5197061a4aec99e9fd4f92d4a543310f83585;hp=0c9b33e
> > 5a23e2053165c9e30ffff3b3a3cf1b2b8
> > This patch probably should be squashed to that.

Nishant, please post one more time with linux-arm-kernel list
also cc'd for review and add all the acks.

After that, Samuel, can you please apply it to your queue because
of the depenency above?

Acked-by: Tony Lindgren <tony@atomide.com>
