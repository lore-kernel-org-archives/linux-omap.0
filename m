From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/5 v3] usb: musb: Power management support
Date: Tue, 1 Mar 2011 11:32:11 +0200
Message-ID: <20110301093211.GD2942@legolas.emea.dhcp.ti.com>
References: <1298882976-4997-1-git-send-email-hemahk@ti.com>
 <20110228085611.GL2459@legolas.emea.dhcp.ti.com>
 <20110228142030.GA25724@kroah.com>
 <20110228212227.GK20560@atomide.com>
 <20110301092656.GC2942@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34618 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754721Ab1CAJcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 04:32:15 -0500
Content-Disposition: inline
In-Reply-To: <20110301092656.GC2942@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, Hema HK <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Mar 01, 2011 at 11:26:56AM +0200, Felipe Balbi wrote:
> On Mon, Feb 28, 2011 at 01:22:28PM -0800, Tony Lindgren wrote:
> > * Greg KH <greg@kroah.com> [110228 06:21]:
> > > On Mon, Feb 28, 2011 at 10:56:11AM +0200, Felipe Balbi wrote:
> > > > On Mon, Feb 28, 2011 at 02:19:31PM +0530, Hema HK wrote:
> > > > > 
> > > > > There is some problem with idle path offmode in mainline, I could not test
> > > > > with offmode. But I have tested this patch with resetting the controller
> > > > > in the idle path when wakeup from retention just to make sure that the
> > > > > context is lost, and restore path is working fine.
> > > > 
> > > > Tony and Greg, how do we handle this one ? Who should take my pull request
> > > > for this series ? I hope we still have a little time to get this into
> > > > 2.6.39, but if we don't I can hold on to them until 2.6.40.
> > > 
> > > Doesn't bother me which tree they go through, I can take them, or, if
> > > it's easier due to omap merges, Tony can.
> > 
> > I prefer Greg's queue unless there's some dependency issue to the
> > patches we have in omap-for-linus.
> 
> Turns out I can easily split what's supposed to go for you and what's
> supposed to go for Greg, so I'll do it. Tony which commit can I use for
> your tree ? Is mainline 2.6.38-rc6 ok ?

Forget it, there's a dependency on a patch which is in Greg's queue, so
I'll send them all through Greg.

-- 
balbi
