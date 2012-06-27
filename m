From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
Date: Wed, 27 Jun 2012 20:05:27 +0200
Message-ID: <1854687.1eeiLuW4oH@avalon>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1397795.nxQGnEDtVe@avalon> <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37786 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719Ab2F0SF3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 14:05:29 -0400
In-Reply-To: <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sakari Ailus <sakari.ailus@iki.fi>

Hi Paul,

On Wednesday 27 June 2012 10:36:04 Paul Walmsley wrote:
> On Wed, 27 Jun 2012, Laurent Pinchart wrote:
> > I think you've missed drivers/media/video/omap3isp/isp.c. Should I send a
> > patch for that ? Do these changes depend on anything not yet in mainline
> > that I should apply to my tree for testing ?
> 
> What would be ideal is if omap3isp could be converted to runtime PM for its
> internal IP block control. Almost all of the other OMAP on-chip oC drivers
> have been converted. Please let us know if more information or assistance is
> needed with this.

How does that integrate with the clock framework ?

-- 
Regards,

Laurent Pinchart

