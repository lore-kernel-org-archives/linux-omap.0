From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Tue, 7 Dec 2010 19:03:28 +0000
Message-ID: <20101207190328.GA789@rakim.wolfsonmicro.main>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <201012071813.35501.hverkuil@xs4all.nl>
 <20101207175505.GI9689@rakim.wolfsonmicro.main>
 <201012071911.39270.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36229 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752574Ab0LGTDa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 14:03:30 -0500
Content-Disposition: inline
In-Reply-To: <201012071911.39270.hverkuil@xs4all.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net

On Tue, Dec 07, 2010 at 07:11:39PM +0100, Hans Verkuil wrote:

> Ah, now I understand what you mean. Would 'activated' be better than 'active'?

Better, yes, though it still sounds a bit like something should be
actively (IYSWIM) happening.   In the absence of better ideas I could go
with this.

> Or perhaps just say: the link 'is on' or the link 'is switched on'?

> So: ...LINK_SWITCHED_ON (sorry, forgot what the prefix is).

> Actually, I think 'switched on' is a pretty good description of what is going on
> in the hardware.

I prefer activated, this makes me think of power.  Bear in mind that for
most audio the power is a big portion of the control - either the audio
is analogue or it looks like it.
