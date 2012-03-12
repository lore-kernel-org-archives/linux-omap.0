From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/8] ARM: OMAP1: Move 16xx GPIO system clock to
 platform init code
Date: Mon, 12 Mar 2012 11:05:01 -0700
Message-ID: <20120312180500.GJ12083@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234042.18709.57610.stgit@kaulin.local>
 <20120312173005.A11093E07B0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48702 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab2CLSFF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 14:05:05 -0400
Content-Disposition: inline
In-Reply-To: <20120312173005.A11093E07B0@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Grant Likely <grant.likely@secretlab.ca> [120312 10:32]:
> On Tue, 21 Feb 2012 15:40:42 -0800, Tony Lindgren <tony@atomide.com> wrote:
> > This way we can remove omap_read/write call from the GPIO driver
> > and remove include to linux/io.h.
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Who will be picking up this series?  How intertwined is it with your tree Tony?

Thanks for following up on this, no need to do anything on this.

This popped up few weeks ago and was resolved by pulling your GPIO
branch into arm-soc. For more info, please see:

Subject: linux-next: manual merge of the arm-soc tree with the gpio tree

http://lkml.org/lkml/2012/3/1/7

Regards,

Tony
