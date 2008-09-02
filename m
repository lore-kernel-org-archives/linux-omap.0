From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/15] OMAP3 camera driver: V4L2: Adding IOCTL command
	to get slave private data.
Date: Tue, 2 Sep 2008 15:53:36 -0700
Message-ID: <20080902225336.GM23085@atomide.com>
References: <A24693684029E5489D1D202277BE89441191E320@dlee02.ent.ti.com> <200808311435.47689.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61124 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbYIBWxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:53:41 -0400
Content-Disposition: inline
In-Reply-To: <200808311435.47689.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [080831 14:36]:
> On Friday 29 August 2008, Aguirre Rodriguez, Sergio Alberto wrote:
> > From: Sakari Ailus <sakari.ailus@nokia.com>
> > Date: Tue, 15 Apr 2008 10:35:15 +0300
> > Subject: [PATCH] Adding IOCTL command to get slave private data.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> > ---
> >  include/media/v4l2-int-device.h |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> Seeing that series of patches from Felipe makes me wonder why
> these patches shouldn't go *first* to the V4L list ... to help
> avoid letting code sit for a long time in the OMAP tree without
> going upstream.
> 
> This particular patch for example is not OMAP-specific.
> 
> And in general, the relevant review team for a V4L driver
> (the rest of this series) is the V4L team not the OMAP team.
> And if this driver passes their review, why not just merge
> to mainline right away?

Yeah, this series should go via V4L list.

Tony
