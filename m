From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Thu, 25 Nov 2010 15:49:52 +0000
Message-ID: <20101125154952.GJ22298@rakim.wolfsonmicro.main>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290652099-15102-4-git-send-email-laurent.pinchart@ideasonboard.com>
 <20101125133650.GA24208@opensource.wolfsonmicro.com>
 <201011251640.42206.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201011251640.42206.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 25, 2010 at 04:40:41PM +0100, Laurent Pinchart wrote:
> On Thursday 25 November 2010 14:36:50 Mark Brown wrote:
> > On Thu, Nov 25, 2010 at 03:28:10AM +0100, Laurent Pinchart wrote:

> > > +	MEDIA_LINK_FLAG_ACTIVE indicates that the link is active and can be
> > > +	used to transfer media data. When two or more links target a sink pad,
> > > +	only one of them can be active at a time.

> > Is this supposed to reflect the current state (if the link is carrying
> > data right now) or if it's possible for the link to carry data?

> It's supposed to reflect whether the link can carry data. Think of the active 
> flag as a valve on a pipe. If the valve is open, the link is active. If the 
> valve is closed, the link is inactive. This is unrelated to whether water 
> actually flows through the pipe.

This seems a confusing name, then - I'd expect an active link to be one
which is actually carrying data rather than one which is available to
carry data.  How a more neutrally worded name such as "connected" (which
is what ASoC uses currently)?

This also falls through into the power management stuff, we don't want
to be powering things up unless they're actually doing something right
now.

> Immutable links have no valve (in theory you could have an inactive immutable 
> link, but that's not very useful, unless we define immutable as no user-
> controllable valve, in which case it might be better to rename it as read-
> only, or create separate immutable and read-only flags - just brainstorming 
> here).

That was what I was expecting immutable to mean - no user control.  A
link that's permanantly wired can have the data flow controlled through
its inputs and outputs, even if it is not itself controllable.
