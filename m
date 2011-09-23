From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 08/11] OMAP2+: board-generic: Add i2c static init
Date: Fri, 23 Sep 2011 17:47:44 -0600
Message-ID: <20110923234744.GL24631@ponder.secretlab.ca>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-9-git-send-email-b-cousson@ti.com>
 <20110923231208.GE6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61104 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab1IWXrs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 19:47:48 -0400
Received: by gxk6 with SMTP id 6so3062439gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 16:47:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110923231208.GE6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Fri, Sep 23, 2011 at 04:12:08PM -0700, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> > Still needed to boot until the i2c & twl driver is adapted to
> > device-tree. Otherwise the voltage control code will try to
> > access the twl and crash.
> 
> That sounds OK to me for now. For merging these patches, how
> about the following:
> 
> - Kevin queues up the omap_device related changes
> 
> - Grant queues up the .dts changes
> 
> - I'll queue the map_io and board changes based on Kevin's
>   omap_device changes

Go ahead and queue up the .dts changes in your tree.  No need to split them up.

g.

