From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Tue, 7 Dec 2010 19:11:39 +0100
Message-ID: <201012071911.39270.hverkuil@xs4all.nl>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com> <201012071813.35501.hverkuil@xs4all.nl> <20101207175505.GI9689@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101207175505.GI9689@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On Tuesday, December 07, 2010 18:55:05 Mark Brown wrote:
> On Tue, Dec 07, 2010 at 06:13:35PM +0100, Hans Verkuil wrote:
> 
> > Personally I think this is perfectly clear. The original confusion came from
> > the word 'active', which I understand means 'streaming' in alsa. By adding
> > a 'streaming' flag in addition to the active flag I think it will be clear
> > that 'active' and 'streaming' are two different things.
> 
> It's not that, it's the fact that active sounds to me like the link
> ought to be powered up which isn't the case - it's too verby.  Like I
> say, I think I'd prefer a more passive name like "connected".

Ah, now I understand what you mean. Would 'activated' be better than 'active'?

Or perhaps just say: the link 'is on' or the link 'is switched on'?

So: ...LINK_SWITCHED_ON (sorry, forgot what the prefix is).

Actually, I think 'switched on' is a pretty good description of what is going on
in the hardware.

Regards,

	Hans
 
> I guess if nobody else finds it confusing I can live with it.
> 

-- 
Hans Verkuil - video4linux developer - sponsored by Cisco
