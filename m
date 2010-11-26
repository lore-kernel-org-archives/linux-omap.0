From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Fri, 26 Nov 2010 14:14:42 +0000
Message-ID: <20101126141442.GI30360@rakim.wolfsonmicro.main>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <201011251640.42206.laurent.pinchart@ideasonboard.com>
 <20101125154952.GJ22298@rakim.wolfsonmicro.main>
 <201011261513.37491.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201011261513.37491.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 26, 2010 at 03:13:36PM +0100, Laurent Pinchart wrote:
> On Thursday 25 November 2010 16:49:52 Mark Brown wrote:
> > On Thu, Nov 25, 2010 at 04:40:41PM +0100, Laurent Pinchart wrote:

> > > It's supposed to reflect whether the link can carry data. Think of the
> > > active flag as a valve on a pipe. If the valve is open, the link is
> > > active. If the valve is closed, the link is inactive. This is unrelated
> > > to whether water actually flows through the pipe.

> > This seems a confusing name, then - I'd expect an active link to be one
> > which is actually carrying data rather than one which is available to
> > carry data.  How a more neutrally worded name such as "connected" (which
> > is what ASoC uses currently)?

> In our current vocabulary "connected" refers to entities between which a link 
> exist, regardless of the link state ("valve opened" or "valve closed"). I'm 
> not totally happy with "active" either, but if we replace it with "connected" 
> we need another word to replace current uses of "connected".

Linked?
