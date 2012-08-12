From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 1/1] omap3: Provide means for changing CSI2 PHY
 configuration
Date: Sun, 12 Aug 2012 09:13:26 +0300
Message-ID: <20120812061326.GO29636@valkosipuli.retiisi.org.uk>
References: <1336539641-28424-1-git-send-email-sakari.ailus@iki.fi>
 <alpine.DEB.2.00.1207040452120.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:58787 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750929Ab2HLGTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Aug 2012 02:19:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1207040452120.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, laurent.pinchart@ideasonboard.com

Hi Paul,

On Wed, Jul 04, 2012 at 04:53:32AM -0600, Paul Walmsley wrote:
> Hello Sakari,
> 
> On Wed, 9 May 2012, Sakari Ailus wrote:
> 
> > The OMAP 3630 has configuration how the ISP CSI-2 PHY pins are connected to
> > the actual CSI-2 receivers outside the ISP itself. Allow changing this
> > configuration from the ISP driver.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
> 
> just checking on this one.  Any update?

Not yet; I need to address Laurent's comments also. I might have time to do
that during the next week.

> A few comments: it would be nice to have some kerneldoc for this function.  
> Also it would be nice to use macros rather than the raw bitshifts in this 
> function.  And one level of indentation can be saved if you bail out early 
> if the function is not running on a 3630.

Thanks. I'll do the changes for the next version.

Cheers,

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	jabber/XMPP/Gmail: sailus@retiisi.org.uk
