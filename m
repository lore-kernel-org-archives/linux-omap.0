From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Thu, 2 Oct 2008 16:48:25 +0300
Message-ID: <20081002134825.GK9133@gandalf.research.nokia.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com> <200810021601.18006.peter.ujfalusi@nokia.com> <20081002130641.GG9133@gandalf.research.nokia.com> <200810021632.31667.peter.ujfalusi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27315 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbYJBNyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 09:54:07 -0400
Content-Disposition: inline
In-Reply-To: <200810021632.31667.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: felipe.balbi@nokia.com, ext Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, Oct 02, 2008 at 04:32:31PM +0300, Peter Ujfalusi wrote:
> Yes, I know that, I just mentioned that other things are still broken in the omap-keypad driver.
> In the OMAP1 board files the resource is filled in, but in the driver you can see this:
> 
> static ssize_t omap_kp_enable_store(struct device *dev, struct device_attribute *attr,
> 				    const char *buf, size_t count)
> .
> .
> 	if (state != kp_enable) {
> 		if (state)
> 			enable_irq(INT_KEYBOARD);
> 		else
> 			disable_irq(INT_KEYBOARD);
> 		kp_enable = state;
> 	}
> .
> .
> 
> So, pretty much not a sane thing to do...
> It is easy to fix, but that was not my point.
> I'll make a patch to fix this one.

that is surely broken :-)

-- 
balbi
