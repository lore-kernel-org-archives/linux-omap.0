From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: gadget: Fix out-of-sync runtime pm calls
Date: Mon, 2 May 2011 12:30:09 +0300
Message-ID: <20110502093007.GO2529@legolas.emea.dhcp.ti.com>
References: <1304083055-2809-1-git-send-email-jhnikula@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46181 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755616Ab1EBJgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 05:36:00 -0400
Content-Disposition: inline
In-Reply-To: <1304083055-2809-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Hema HK <hemahk@ti.com>

On Fri, Apr 29, 2011 at 04:17:35PM +0300, Jarkko Nikula wrote:
> If cable is not connected to peripheral only board when initializing the
> gadget driver, then runtime pm calls are out-of-sync and the musb cannot
> idle with omap2430.c. This was noted on Nokia N900 where musb prevented the
> CPU to be able to enter deeper retention idle state.
> 
> This was working in 2.6.38 before runtime pm conversions but there musb
> smart standby/idle modes were configured statically where they are now
> updated runtime depending on use and cable status.
> 
> Reason for out-of-sync is that runtime pm is activated in function
> musb_gadget.c: usb_gadget_probe_driver but suspended only in OTG mode if
> cable is not connected when initializing. In peripheral only mode this leads
> to out-of-sync runtime pm since runtime pm remain active and is activated
> another time in omap2430.c: musb_otg_notifications for VBUS Connect event
> and thus cannot suspend for VBUS Disconnect event since the use count remains
> active.
> 
> Fix this by moving cable status check and pm_runtime_put call in
> usb_gadget_probe_driver out of is_otg_enabled block.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

applied, thanks

-- 
balbi
