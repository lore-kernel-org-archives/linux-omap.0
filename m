From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Tue, 27 Mar 2012 16:43:49 +0200
Message-ID: <20120327144349.GH17616@sortiz-mobl>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
 <20120320155353.GE17818@sortiz-mobl>
 <20120320155541.GF32693@arwen.pp.htv.fi>
 <4F71CC49.4080903@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16503 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab2C0Ofe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 10:35:34 -0400
Content-Disposition: inline
In-Reply-To: <4F71CC49.4080903@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: balbi@ti.com, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, parthab@india.ti.com, govindraj.raja@ti.com

Hi Igor,

On Tue, Mar 27, 2012 at 04:18:49PM +0200, Igor Grinberg wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Felipe, Samuel,
> 
> On 03/20/12 17:55, Felipe Balbi wrote:
> > On Tue, Mar 20, 2012 at 04:53:53PM +0100, Samuel Ortiz wrote:
> >> Hi Keshava,
> >>
> >> On Mon, Mar 19, 2012 at 12:12:47PM +0530, Keshava Munegowda wrote:
> >>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
> >>>
> >>> It is observed that the echi ports of 3430 sdp board
> >>> are not working due to the random timing of programming
> >>> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
> >>> If the PHYs are reset at during usbhs core driver, host ports will
> >>> not work because EHCI driver is loaded after the resetting PHYs.
> >>> The PHYs should be in reset state while initializing the EHCI
> >>> controller.
> >>> The code which does the GPIO pins associated with the PHYs
> >>> are programmed to reset is moved from the USB host core driver
> >>> to EHCI driver.
> >>>
> >>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> >>> Reviewed-by: Partha Basak <parthab@india.ti.com>
> >> Felipe, are you ok with that patch ?
> >> I'll most likely queue it after this merge window is closed though.
> 
> I've just sent a patch that depends on this one (ehci-omap.c part),
> though it needs a review, but Samuel, you still haven't applied/pushed
> the patch to your git.kernel.org, so can this one go through Felipe's
> tree to minimize the dependencies/conflicts?
Once (and if) Linus pulls from my for-next branch, I'll start taking patches
again. It's a matter of days, so you can either wait for me to apply this
patch or have Felipe taking both.
I'm fine either ways.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
