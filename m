From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH v6 05/12] media: Reference count and power handling
Date: Thu, 25 Nov 2010 16:43:16 +0100
Message-ID: <201011251643.17313.laurent.pinchart@ideasonboard.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com> <1290652099-15102-6-git-send-email-laurent.pinchart@ideasonboard.com> <20101125134908.GC24208@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37502 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0KYPnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 10:43:03 -0500
In-Reply-To: <20101125134908.GC24208@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net

Hi Mark,

On Thursday 25 November 2010 14:49:08 Mark Brown wrote:
> On Thu, Nov 25, 2010 at 03:28:12AM +0100, Laurent Pinchart wrote:
> > 	If the entity is of node type, the power change is distributed to
> > 	all connected entities. For non-nodes it only affects that very
> > 	node. A mutex is used to serialise access to the entity graph.
> 
> ASoC has its own power management stuff which doesn't *quite* map onto
> this one as-is.  The power determination stuff is essentially identical
> (and this is actually nicer) but we have a separate postprocessing stage
> that actually applies the changes in a sequence which minimises audible
> issues caused by doing things in a bad order (eg, power down a PGA
> before you turn off inputs).  This is noddy enough to implement, though
> - we just need a pre and post run notifications to set up and implement
> the changes I think.

That sounds feasible. Sakari, you've implemented power management, what do you 
think about this ?


> BTW, I notice you've not CCed the ALSA list, Liam, Takashi or Jaroslav
> on any of this - might be good.

I've just subscrived to the alsa-devel list. I will make sure to CC it, as 
well as Liam, Takashi and Jaroslav, on the next version of the patches. Sorry 
about the missing CC's in these e-mails.

-- 
Regards,

Laurent Pinchart
