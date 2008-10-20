From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Mon, 20 Oct 2008 20:10:48 +0300
Message-ID: <20081020171048.GE25323@gandalf.research.nokia.com>
References: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com> <20081020102659.GA31599@gandalf.research.nokia.com> <20081020151512.GA8298@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25270 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877AbYJTRL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 13:11:57 -0400
Content-Disposition: inline
In-Reply-To: <20081020151512.GA8298@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

On Mon, Oct 20, 2008 at 08:15:16AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [081020 03:27]:
> > up to 1000khz it's Fast Mode+, not highspeed.
> 
> Have you tested this? To me it seems this code is needed for
> dev->speed > 400, and the comment may be wrong.

the thing is that looks like omap i2c controller doesn't support fast
mode+ devices, would be useful if someone had a fastmode+ device to test
with.

Let's drop this one.

btw, at least triton still works, but then again it could be working as
a high speed with a lower speed.

-- 
balbi
