From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] omap3: Provide means for changing CSI2 PHY
 configuration
Date: Wed, 4 Jul 2012 04:53:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040452120.6760@utopia.booyaka.com>
References: <1336539641-28424-1-git-send-email-sakari.ailus@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54740 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017Ab2GDKxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 06:53:32 -0400
In-Reply-To: <1336539641-28424-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, laurent.pinchart@ideasonboard.com

Hello Sakari,

On Wed, 9 May 2012, Sakari Ailus wrote:

> The OMAP 3630 has configuration how the ISP CSI-2 PHY pins are connected to
> the actual CSI-2 receivers outside the ISP itself. Allow changing this
> configuration from the ISP driver.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>

just checking on this one.  Any update?

A few comments: it would be nice to have some kerneldoc for this function.  
Also it would be nice to use macros rather than the raw bitshifts in this 
function.  And one level of indentation can be saved if you bail out early 
if the function is not running on a 3630.

- Paul
