From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix
 issues.
Date: Fri, 29 Jun 2012 11:33:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206291104270.1638-100000@iolanthe.rowland.org>
References: <1340848783-9480-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36967 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752557Ab2F2Pdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 11:33:35 -0400
In-Reply-To: <1340848783-9480-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Partha Basak <parthab@india.ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Samuel Ortiz <sameo@linux.intel.com>, mantesh@ti.com, s-sapna1@ti.com, Russ Dill <Russ.Dill@gmail.com>

On Wed, 27 Jun 2012, Russ Dill wrote:

> From: Russ Dill <Russ.Dill@gmail.com>
> 
> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0) fixes
> an issue where the ULPI PHYs were not held in reset while initializing
> the EHCI controller. However, it also changes behavior in
> omap-usb-host.c omap_usbhs_init by releasing reset while the
> configuration in that function was done.
> 
> This change caused a regression on BB-xM where USB would not function
> if 'usb start' had been run from u-boot before booting. A change was
> made to release reset a little bit earlier which fixed the issue on
> BB-xM and did not cause any regressions on 3430 sdp, the board for
> which the fix was originally made.
> 
> This new fix, 'USB: EHCI: OMAP: Finish ehci omap phy reset cycle
> before adding hcd.', (3aa2ae74) caused a regression on OMAP5.
> 
> The original fix to hold the EHCI controller in reset during
> initialization was correct, however it appears that changing
> omap_usbhs_init to not hold the PHYs in reset during it's
> configuration was incorrect. This patch first reverts both fixes, and
> then changes ehci_hcd_omap_probe in ehci-omap.c to hold the PHYs in
> reset as the original patch had done. It also is sure to incorporate
> the _cansleep change that has been made in the meantime.
> 
> Tested on Beagleboard xM.

Looking at the result of this patch, there seem to be a few mistakes 
remaining in the probe routine.

If the regulator_get() call fails, the failure is logged but ignored.  
Is that really the right thing to do?

The pm_runtime_get_sync() call occurs before the probe is finished.  
This means that ehci-hcd's resume routine will try to power-up the 
device before its data structures have been initialized.  That can't be 
right.

The "get clocks" section occurs after the call to usb_add_hcd().  This
means the controller will start running before the clock references are
acquired -- so the clocks might still be turned off.  That can't be
right either.

If the clk_get(dev, "utmi_p1_gfclk") call fails, the error path never 
calls usb_remove_hcd().

The "err_add_hcd" pathway never calls usb_put_hcd().

I'm going to resubmit my most recent patch based the current 
ehci-omap.c, but you or someone else will still have to fix these 
problems.

Alan Stern

