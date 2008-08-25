From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] OMAP:MUSB: Fixes the TT programming.
Date: Mon, 25 Aug 2008 10:57:13 +0300
Message-ID: <20080825075712.GA9910@frodo>
References: <1219385613-20108-1-git-send-email-ajay.gupta@ti.com> <200808212330.06650.david-b@pacbell.net> <20080825035322.GC3128@kroah.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41024 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbYHYH50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2008 03:57:26 -0400
Content-Disposition: inline
In-Reply-To: <20080825035322.GC3128@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, ajay.gupta@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, felipe.balbi@nokia.com

On Sun, Aug 24, 2008 at 08:53:22PM -0700, Greg KH wrote:
> On Thu, Aug 21, 2008 at 11:30:06PM -0700, David Brownell wrote:
> > On Thursday 21 August 2008, ajay.gupta@ti.com wrote:
> > > From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > 
> > > Fixes enumeration failures when a USB device attached to a LS hub
> > > is connected to OMAP EVM via HS hub. This is fixed by correctly
> > > programming hub address register in enqueue path.  
> > > 
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > 
> > Looks right to me, other than the lack of line wrapping in that
> > summary (corrected above).  Moreover, there ought to be some way
> > to make all high speed hosts share TT scheduling code ... ;)
> > 
> > Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> Ok, for all MUSB patches, I'm going to wait until Felipe tells me to
> accept them, as he's the subsystem/driver maintainer.
> 
> Felipe, is this ok?  Can you just bundle up what you feel is good and
> send them to me when they are ready (usually as soon as possible)?

Ok. I'll queue them today and send to you in a few hours.

-- 
balbi
