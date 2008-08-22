From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch [2/2] DaVinci CPPI TX DMA tasklet
Date: Fri, 22 Aug 2008 10:21:26 +0300
Message-ID: <20080822072126.GA9474@gandalf.research.nokia.com>
References: <1219327122-28334-1-git-send-email-swami.iyer@ti.com> <200808211215.37760.david-b@pacbell.net> <FCCFB4CDC6E5564B9182F639FC3560870229F52486@dbde02.ent.ti.com> <200808212024.11659.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23886 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYHVHUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 03:20:39 -0400
Content-Disposition: inline
In-Reply-To: <200808212024.11659.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Thu, Aug 21, 2008 at 08:24:11PM -0700, David Brownell wrote:
> They'll need to be in nicely reviewable chunks ... I remember seeing
> some DaVinci patches in late 2006 which broke on TUSB6010 silicon,
> for example.
> 
> DMA in particular could really stand some cleanup.  Having four
> different chunks of DMA code -- RX/TX vs Host/Peripheral -- with
> ifdeffery for multiple DMA engines is ... chaotic.

Yeah, after the debugfs changes I plan to clean up those. Might take a
while due to internal tasks

> > I discussed with Kevin on the DaVinci Git tree and Filipe here and they recommended that
> > I take the changes to linux-usb, linux-omap tree (w.r.t musb changes) to get a wider 
> > audience for review and acceptance.
> > 
> > Kevin would then pull in the changes as part of his regular synch ups.
> 
> I think the plan should be to have various SOC-specific trees (DaVinci,
> OMAP, Blackfin, etc) stop hosting MUSB-specific patches.  They should
> be pushed up to mainline ASAP ... the linux-omap tree should stop being
> the place where the latest MUSB code sits.

It's not anymore, we Cc that list so interested people might also take a
look on the patches, since we pushed musb code via Greg's queue,
linux-usb is the place for musb discussion.

-- 
balbi
