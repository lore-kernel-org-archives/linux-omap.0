From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest config warning
Date: Fri, 7 Jan 2011 08:47:49 -0800
Message-ID: <20110107164748.GC880@atomide.com>
References: <20110107113506.GK1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30750 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab1AGQsK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 11:48:10 -0500
Content-Disposition: inline
In-Reply-To: <20110107113506.GK1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 03:34]:
> warning: (ARCH_STMP3XXX && <choice> || ARCH_OMAP3 && ARCH_OMAP2PLUS) selects USB_ARCH_HAS_EHCI which has unmet direct dependencies (USB_SUPPORT)
> 
> This didn't happen with 2.6.37.  Maybe a missing select USB_SUPPORT
> somewhere?

Felipe, care to take a look at this one?

Regards,

Tony
