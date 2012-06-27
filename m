From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
Date: Wed, 27 Jun 2012 10:36:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1397795.nxQGnEDtVe@avalon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57686 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab2F0QgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 12:36:05 -0400
In-Reply-To: <1397795.nxQGnEDtVe@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rajendra Nayak <rnayak@ti.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sakari Ailus <sakari.ailus@iki.fi>

Hi Laurent

On Wed, 27 Jun 2012, Laurent Pinchart wrote:

> I think you've missed drivers/media/video/omap3isp/isp.c. Should I send a 
> patch for that ? Do these changes depend on anything not yet in mainline that 
> I should apply to my tree for testing ?

What would be ideal is if omap3isp could be converted to runtime PM for 
its internal IP block control.  Almost all of the other OMAP on-chip 
oC drivers have been converted.  Please let us know if more information or 
assistance is needed with this.


- Paul
