From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Fri, 3 Dec 2010 14:54:08 +0000
Message-ID: <20101203145408.GW859@rakim.wolfsonmicro.main>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <201012031119.36771.laurent.pinchart@ideasonboard.com>
 <201012031306.18520.hverkuil@xs4all.nl>
 <201012031450.59137.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201012031450.59137.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 03, 2010 at 02:50:58PM +0100, Laurent Pinchart wrote:
> On Friday 03 December 2010 13:06:18 Hans Verkuil wrote:

> > > Just to confirm thinks, Mark's proposal is to replace 'connected' by
> > > 'linked' and 'active' by 'connected'. Are we on the same page here ?

> > Yes, but when I read it back it does not make me happy. 'Connected' and
> > 'linked' basically have the same meaning in English.

> I unfortunately agree that it's a bit confusing :-(

It feels like the problem here is that for whatever reason (I'm not sure
what?) you're trying to come up with verbs for links that are currently
disconnected - in ASoC we just say we've got paths that exist and then
we talk about the paths that are connected.  Verbing everything makes it
all sound active which is confusing when you're talking about links that
are idle.
