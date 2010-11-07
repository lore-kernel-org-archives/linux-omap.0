From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Sun, 7 Nov 2010 14:02:13 -0800
Message-ID: <20101107220213.GB21070@kroah.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com> <1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:34445 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab0KGWIj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 17:08:39 -0500
Content-Disposition: inline
In-Reply-To: <1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

On Sun, Nov 07, 2010 at 11:43:24PM +0200, Felipe Contreras wrote:
> Hi,
> 
> Paul already sent these, but I did some minor modifications, mostly to minimize
> the amount of changes.
> 
> Also, I'm re-sending my memblock patch so that the driver can actually be
> compiled.
> 
> With these, and reverting the iommu patches[1], the driver should be working. I
> don't see a more straight-forward way to achieve that.

I can't take these through the staging tree unless I get an ack from the
omap maintainers.

And as you are adding new infrastructure to the core kernel, this really
needed to be there before .37-rc1, I don't think it's acceptable to
merge this late in the development cycle.

thanks,

greg k-h
