From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 31 May 2011 00:57:02 -0700
Message-ID: <20110531075701.GN11352@atomide.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
 <20110517152954.477365e6.jhnikula@gmail.com>
 <20110517125700.GY5323@atomide.com>
 <201105181539.46959.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50789 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758109Ab1EaH5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 03:57:05 -0400
Content-Disposition: inline
In-Reply-To: <201105181539.46959.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110518 05:36]:
> Hi Tony,
> 
> On Tuesday 17 May 2011 15:57:00 Tony Lindgren wrote:
> > This file should be under drivers/ somewhere, can you
> > guys please take care of that?
> 
> Do you have a place in mind?

How about drivers/mcbsp?

> We have several things under arch/arm/plat-omap, like i2c, dma, fb, gpio, 
> mcbsp, usb...

These are all going away into drivers. Only the code to initialize
platform dta should be under arch/arm/*omap*/.

> Should we create a directory for omap specific drivers under drivers?

No, this was discussed few weeks ago on LAKML. The drivers should be
grouped by type instead.

> For example drivers/omap/ and move the mcbsp there first, without any API 
> change?

This is up to Greg, but I'd assume that a generic framework is the preferred
way to go.

> If needed we can think of changing the interface within McBSP if it is needed 
> for other use later.
> IMHO invention a common framework (as Jarkko was suggesting) for similar 
> interfaces need more work, and synchronization between other platforms.

Sure, but that's the only option we have to merge any new code.

Regards,

Tony
