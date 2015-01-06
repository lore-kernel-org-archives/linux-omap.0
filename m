From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: DT support for OMAP3 ISP
Date: Wed, 7 Jan 2015 00:00:50 +0200
Message-ID: <20150106220050.GT17565@valkosipuli.retiisi.org.uk>
References: <CAK8F28mM1qwxaSJ4pdy2DC6+7sY-c_-yQGxDfYqi50B7SOBpdQ@mail.gmail.com>
 <20150106214218.GZ4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:56897 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755545AbbAFWBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 17:01:25 -0500
Content-Disposition: inline
In-Reply-To: <20150106214218.GZ4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ash Charles <ashcharles@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, laurent.pinchard@ideasonboard.com

Moikka,

On Tue, Jan 06, 2015 at 01:42:18PM -0800, Tony Lindgren wrote:
> * Ash Charles <ashcharles@gmail.com> [150106 12:45]:
> > Hi,
> > 
> > I'm playing with the Caspa camera (mt9v032) and Overo on the 3.17
> > kernel.  It looks like there has been some work on dt-bindings for the
> > omap3isp (notably [1] and [2]) but I didn't see anything heading for
> > mainline.
> > 
> > What would be needed to support cameras using the omap3isp in a mainline kernel?
> 
> No idea about the camera, but at least the legacy omap DMA calls need
> to be replaced or removed as the legacy DMA API will go away soon.

OMAP DMA is only used by the histogram block which can cope with PIO as well
--- I think there at least was a #define for it. That's not a reason not to
convert it however, it's just not as urgent it otherwise might be. I wonder
if someone has patches for that already.

Cc Laurent.

-- 
Terveisin,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
