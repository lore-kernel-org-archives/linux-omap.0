From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/11] OMAP2+: board-generic: Add i2c static init
Date: Mon, 26 Sep 2011 09:45:55 -0700
Message-ID: <20110926164555.GA17771@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-9-git-send-email-b-cousson@ti.com>
 <20110923231208.GE6324@atomide.com>
 <20110923234744.GL24631@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42014 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750782Ab1IZQqB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 12:46:01 -0400
Content-Disposition: inline
In-Reply-To: <20110923234744.GL24631@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

* Grant Likely <grant.likely@secretlab.ca> [110923 16:14]:
> On Fri, Sep 23, 2011 at 04:12:08PM -0700, Tony Lindgren wrote:
> > * Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> > > Still needed to boot until the i2c & twl driver is adapted to
> > > device-tree. Otherwise the voltage control code will try to
> > > access the twl and crash.
> > 
> > That sounds OK to me for now. For merging these patches, how
> > about the following:
> > 
> > - Kevin queues up the omap_device related changes
> > 
> > - Grant queues up the .dts changes
> > 
> > - I'll queue the map_io and board changes based on Kevin's
> >   omap_device changes
> 
> Go ahead and queue up the .dts changes in your tree.  No need to split them up.

OK, will do.

Thanks,

Tony
