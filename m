From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Thu, 9 Dec 2010 13:53:21 +0100
Message-ID: <201012091353.22971.laurent.pinchart@ideasonboard.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com> <201012071911.39270.hverkuil@xs4all.nl> <20101207190328.GA789@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101207190328.GA789@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 07 December 2010 20:03:28 Mark Brown wrote:
> On Tue, Dec 07, 2010 at 07:11:39PM +0100, Hans Verkuil wrote:
> > Ah, now I understand what you mean. Would 'activated' be better than
> > 'active'?
> 
> Better, yes, though it still sounds a bit like something should be
> actively (IYSWIM) happening.   In the absence of better ideas I could go
> with this.
> 
> > Or perhaps just say: the link 'is on' or the link 'is switched on'?
> > 
> > So: ...LINK_SWITCHED_ON (sorry, forgot what the prefix is).
> > 
> > Actually, I think 'switched on' is a pretty good description of what is
> > going on in the hardware.
> 
> I prefer activated, this makes me think of power.  Bear in mind that for
> most audio the power is a big portion of the control - either the audio
> is analogue or it looks like it.

Do I understand it correctly that the outcome of this discussion is that I 
just need to rename active to activated when talking about links ?

-- 
Regards,

Laurent Pinchart
