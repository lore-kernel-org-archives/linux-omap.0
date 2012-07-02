From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Mon, 2 Jul 2012 00:35:47 -0700
Message-ID: <20120702073547.GA1122@atomide.com>
References: <cover.1339586624.git.afzal@ti.com>
 <1340789755.29342.12.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:37612 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab2GBHfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 03:35:52 -0400
Content-Disposition: inline
In-Reply-To: <1340789755.29342.12.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, ivan.djelic@parrot.com

* Artem Bityutskiy <artem.bityutskiy@linux.intel.com> [120627 02:36]:
> On Wed, 2012-06-13 at 17:02 +0530, Afzal Mohammed wrote:
> > Hi,
> > 
> > This series cleans up gpmc mtd interactions so that GPMC driver
> > conversion which is going to happen shortly would happen smoothly
> > by not creating much disturbance outside of arch/arm/*omap*/
> 
> Dunno if Tony picked this, but the MTD changes look good an the quick
> glance. Feel free to add
> 
> Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Thanks will add to the drivers/mtd touching patches in this series.

Tony
