From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH RESEND] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
Date: Tue, 20 Mar 2012 16:53:53 +0100
Message-ID: <20120320155353.GE17818@sortiz-mobl>
References: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53095 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760651Ab2CTPpt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 11:45:49 -0400
Content-Disposition: inline
In-Reply-To: <1332139367-1302-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com

Hi Keshava,

On Mon, Mar 19, 2012 at 12:12:47PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda@ti.com>
> 
> It is observed that the echi ports of 3430 sdp board
> are not working due to the random timing of programming
> the associated GPIOs of the ULPI PHYs of the EHCI for reset.
> If the PHYs are reset at during usbhs core driver, host ports will
> not work because EHCI driver is loaded after the resetting PHYs.
> The PHYs should be in reset state while initializing the EHCI
> controller.
> The code which does the GPIO pins associated with the PHYs
> are programmed to reset is moved from the USB host core driver
> to EHCI driver.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak <parthab@india.ti.com>
Felipe, are you ok with that patch ?
I'll most likely queue it after this merge window is closed though.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
