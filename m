From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Wed, 3 Sep 2008 15:22:57 -0700
Message-ID: <20080903222256.GE23085@atomide.com>
References: <20080903221218.GD23085@atomide.com> <20080903221807.GC6693@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50074 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYICWXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 18:23:01 -0400
Content-Disposition: inline
In-Reply-To: <20080903221807.GC6693@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, Vikram Pandita <vikram.pandita@ti.com>, Kamat@atomide.com, Nishant <nskamat@ti.com>

* Felipe Balbi <me@felipebalbi.com> [080903 15:18]:
> On Wed, Sep 03, 2008 at 03:12:19PM -0700, Tony Lindgren wrote:
> > Hi all,
> > 
> > I've updated our git tree to -rc5. Now drivers/usb is pretty close to
> > being in sync with mainline except for the following diff.
> > 
> > Dave, could you take a look at the following USB patch and see what
> > should be merged, fixed or removed?
> > 
> > The patch is mostly some ehci-omap.[ch] and musb include fixes. And
> > then there are also the H4 OTG patches from Imre still floating on
> > this list.
> 
> The musb part I sent to Greg already, you should get on -rc6. Here's the
> link on linux-usb archive:
> 
> http://marc.info/?l=linux-usb&m=122011455015140&w=2

OK thanks.

Vikram and Nishant, can you send your ehci-omap patches to
linux-usb for integration?

Tony
