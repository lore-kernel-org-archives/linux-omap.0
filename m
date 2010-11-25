From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 05/12] media: Reference count and power handling
Date: Thu, 25 Nov 2010 13:49:08 +0000
Message-ID: <20101125134908.GC24208@opensource.wolfsonmicro.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290652099-15102-6-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51904 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752454Ab0KYNtA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 08:49:00 -0500
Content-Disposition: inline
In-Reply-To: <1290652099-15102-6-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net

On Thu, Nov 25, 2010 at 03:28:12AM +0100, Laurent Pinchart wrote:

> 	If the entity is of node type, the power change is distributed to
> 	all connected entities. For non-nodes it only affects that very
> 	node. A mutex is used to serialise access to the entity graph.

ASoC has its own power management stuff which doesn't *quite* map onto
this one as-is.  The power determination stuff is essentially identical
(and this is actually nicer) but we have a separate postprocessing stage
that actually applies the changes in a sequence which minimises audible
issues caused by doing things in a bad order (eg, power down a PGA
before you turn off inputs).  This is noddy enough to implement, though
- we just need a pre and post run notifications to set up and implement
the changes I think.

BTW, I notice you've not CCed the ALSA list, Liam, Takashi or Jaroslav
on any of this - might be good.
