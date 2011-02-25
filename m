From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] usb: musb: Remove platform context save/restore
 APIs
Date: Fri, 25 Feb 2011 12:13:09 +0200
Message-ID: <20110225101309.GA4190@legolas.emea.dhcp.ti.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com>
 <1298628663-27650-3-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:43870 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932514Ab1BYKNP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 05:13:15 -0500
Content-Disposition: inline
In-Reply-To: <1298628663-27650-3-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Feb 25, 2011 at 03:41:00PM +0530, Hema HK wrote:
> For OMAP3 and OMAP4 for offmode and retention support, musb
> sysconfig is configured to force idle and standby with ENABLE_FORCE bit
> of OTG_FORCESTNDBY set.
> And on wakeup configure to no idle/standby with resetting the ENABLE_FORCE
> bit. There is no need to save and restore of this register anymore
> so removed omap2430_save_context/omap2430_restore_context functions.
> and also removed otg_forcestandby member of musb_context_registers
> structure
> 
> Signed-off-by: Hema HK <hemahk@ti.com>

Nice, good one ;-)

-- 
balbi
