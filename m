From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 04:14:43 -0700
Message-ID: <20120807111442.GZ11011@atomide.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
 <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
 <20120807084815.GK8468@arwen.pp.htv.fi>
 <1344330329.4091.16.camel@deskari>
 <20120807091415.GN8468@arwen.pp.htv.fi>
 <1344331672.4091.22.camel@deskari>
 <20120807093207.GO8468@arwen.pp.htv.fi>
 <1344333436.7216.32.camel@lappyti>
 <20120807102712.GP8468@arwen.pp.htv.fi>
 <1344337046.4091.32.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15328 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab2HGLOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 07:14:45 -0400
Content-Disposition: inline
In-Reply-To: <1344337046.4091.32.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, Chandrabhanu Mahapatra <cmahapatra@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120807 03:57]:
> On Tue, 2012-08-07 at 13:27 +0300, Felipe Balbi wrote:
> > Hi,
> 
> > > Yes, they can be overridden, but I think it's still quite difficult to
> > > manage. DSS is modeled with multiple blocks, also in DT data. So you'd
> > > need to override multiple entries.
> > > 
> > > And it'd also require a new dts file for each version of your board with
> > > different ES version.
> > > 
> > > Also, I don't really see why this information would need to be present
> > > in the DT data (especially as it's not simple). It's all trivially found
> > > out in the code, by using cpu_is & soc_is.
> > 
> > Fair enough. I just think we should remove all cpu_is_* and soc_is_*
> > from drivers.
> 
> I agree, that's part of the idea here. Instead of having cpu_is checks
> all around, we'll have them in only certain centralized places. Then
> it's easier to implement a way to move them totally out of the driver,
> when we come up with a good idea how to accomplish that.

Yes limiting them to driver init and setting some driver specific flags
based on that is a good start. But eventually no drivers should have
those checks.

Regards,

Tony
