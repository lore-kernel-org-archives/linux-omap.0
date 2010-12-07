From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Tue, 7 Dec 2010 17:55:05 +0000
Message-ID: <20101207175505.GI9689@rakim.wolfsonmicro.main>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <201012031450.59137.laurent.pinchart@ideasonboard.com>
 <20101203145408.GW859@rakim.wolfsonmicro.main>
 <201012071813.35501.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201012071813.35501.hverkuil@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 07, 2010 at 06:13:35PM +0100, Hans Verkuil wrote:

> Personally I think this is perfectly clear. The original confusion came from
> the word 'active', which I understand means 'streaming' in alsa. By adding
> a 'streaming' flag in addition to the active flag I think it will be clear
> that 'active' and 'streaming' are two different things.

It's not that, it's the fact that active sounds to me like the link
ought to be powered up which isn't the case - it's too verby.  Like I
say, I think I'd prefer a more passive name like "connected".

I guess if nobody else finds it confusing I can live with it.
