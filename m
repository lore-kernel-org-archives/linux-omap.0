From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 1/1] omap3: Provide means for changing CSI2 PHY
 configuration
Date: Wed, 9 May 2012 09:19:28 +0300
Message-ID: <20120509061927.GL852@valkosipuli.localdomain>
References: <1336539641-28424-1-git-send-email-sakari.ailus@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:56567 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754076Ab2EIGTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 02:19:33 -0400
Content-Disposition: inline
In-Reply-To: <1336539641-28424-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com, laurent.pinchart@ideasonboard.com

Hi,

On Wed, May 09, 2012 at 08:00:41AM +0300, Sakari Ailus wrote:
> The OMAP 3630 has configuration how the ISP CSI-2 PHY pins are connected to
> the actual CSI-2 receivers outside the ISP itself. Allow changing this
> configuration from the ISP driver.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>

I just realised also this one is missing:

<URL:http://www.spinics.net/lists/linux-media/msg43913.html>

I wonder if we could have these in... :-)

Cheers,

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	jabber/XMPP/Gmail: sailus@retiisi.org.uk
