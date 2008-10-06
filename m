From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [patch/rfc/rft 2.6.27-rc8-omap-git] twl4030-pwrirq
	simplification, cleanup
Date: Mon, 6 Oct 2008 11:46:09 +0300
Message-ID: <20081006084609.GD7437@gandalf.research.nokia.com>
References: <200810060119.18848.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38889 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbYJFIqw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 04:46:52 -0400
Content-Disposition: inline
In-Reply-To: <200810060119.18848.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Mon, Oct 06, 2008 at 01:19:18AM -0700, David Brownell wrote:
> I can't test the pwrbutton stuff, but rtc and musb behave...
> 
> With one issue:  the usb transceiver glue misbehaves on
> startup if the device is connected.  (Again.)  I looked at
> this a bit, and I think the issue is probably caused by
> not actually using key USB registers ... IRQ trigger
> mode state transitions are at best a fragile proxy for the
> real state.
> 
> (This is similar to the GPIO patch I just sent, but simpler
> except for the impact on the few drivers thinking oddly
> about IRQs.  Those patches cover the key SIH modules, and
> a similar one affects the PIH in twl4030-core.)

What are the dependencies for this patch ? It doesn't apply cleanly.

-- 
balbi
