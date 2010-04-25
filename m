From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] usb: Fix tusb6010 for DMA API (Re: [patch-2.6.34-rc2+
 00/11] musb patches (v2))
Date: Sun, 25 Apr 2010 16:35:32 +0300
Message-ID: <20100425133531.GB2219@gandalf>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
 <20100423210854.GA13366@kroah.com>
 <20100423212307.GY18272@atomide.com>
 <20100423220853.GA16165@kroah.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50655 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab0DYNev (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Apr 2010 09:34:51 -0400
Content-Disposition: inline
In-Reply-To: <20100423220853.GA16165@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Apr 23, 2010 at 03:08:53PM -0700, Greg KH wrote:
> On Fri, Apr 23, 2010 at 02:23:08PM -0700, Tony Lindgren wrote:
> > * Greg KH <greg@kroah.com> [100423 14:05]:
> > > On Thu, Mar 25, 2010 at 01:14:22PM +0200, Felipe Balbi wrote:
> > > > Hi Greg,
> > > > 
> > > > sorry for the last time. There was a bug in my script
> > > > which caused it to rebased against the wrong branch.
> > > 
> > > All queued up, thanks
> > 
> > This compile fix still needs to be queued too. Can also
> > merge via omap tree if you guys ack.
> 
> That's up to Felipe.  I have no objection to it, it's his call.

please Greg take it. I seem to have missed from my queue.

fwiw:

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi
