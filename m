From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: device: improve errors handling
Date: Wed, 4 Aug 2010 12:46:39 +0300
Message-ID: <20100804094638.GC9881@atomide.com>
References: <1278941887.16634.85.camel@localhost>
 <alpine.DEB.2.00.1007121028410.19255@utopia.booyaka.com>
 <alpine.DEB.2.00.1007121030120.19255@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59563 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0HDJqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 05:46:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1007121030120.19255@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "ext Menon, Nishanth" <nm@ti.com>, Thara Gopinath <thara@ti.com>

* Paul Walmsley <paul@pwsan.com> [100712 19:24]:
> Tony,
> 
> by the way,
> 
> On Mon, 12 Jul 2010, Paul Walmsley wrote:
> 
> > On Mon, 12 Jul 2010, Artem Bityutskiy wrote:
> > 
> > > From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> > > 
> > > Do not forget to check the 'platform_device_add_data()' error code
> > > in 'omap_device_build_ss()'.
> > 
> > Looks fine to me, platform_device_add_data() can return -ENOMEM in the 
> > unlikely event that its kmemdup() fails.
> > 
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> you want to take this one, or want me to queue it up for .37?

Thanks, I'll add it to omap-for-linus for 2.6.36.

Regards,

Tony
