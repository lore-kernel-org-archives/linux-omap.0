From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin omap3isp
Date: Sun, 26 Feb 2012 23:47:56 +0100
Message-ID: <35010303.ArkW8BdIu6@avalon>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com> <3215700.hj2jFm3b0A@avalon> <CAK=WgbYkVALqrVMVv1ma3WzN5dYriM8X0MfwH4knwWwojB6hjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35206 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab2BZWrt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Feb 2012 17:47:49 -0500
In-Reply-To: <CAK=WgbYkVALqrVMVv1ma3WzN5dYriM8X0MfwH4knwWwojB6hjg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi Ohad,

On Sunday 26 February 2012 20:30:17 Ohad Ben-Cohen wrote:
> On Sun, Feb 26, 2012 at 7:34 PM, Laurent Pinchart wrote:
> > On Sunday 26 February 2012 12:14:14 Ohad Ben-Cohen wrote:
> >> omap3isp depends on omap's iommu and will fail to probe if
> >> initialized before it (which always happen if they are builtin).
> >> 
> >> Make omap's iommu subsys_initcall as an interim solution until
> >> the probe deferral mechanism is merged.
> > 
> > How will that fix the problem ?
> 
> Sorry, I'm not entirely sure I understand the question: are you asking
> about this patch or about the probe deferral thingy ?

I'm asking about the probe deferral mechanism. The omap3-isp driver will still 
call iommu_attach_device() in its probe function. What will happen then ? Will 
it return an error ? On what basis will it do so ?

> > I'm fine with this patch, as it fixes the problem as well, although I
> > still believe modifying the link order would be a better fix in this case.
> 
> I'm personally not a huge fan of implicit link order dependencies, as
> someone may change the order in the future (for whatever benign
> reason) without even realizing he's breaking drivers.

That's what the comment in the Makefile is for ;-) I don't think it's a 
perfect solution either, but it avoids playing with the various initcalls. The 
OMAP3 IOMMU isn't a subsystem, subsys_initcall() looks a bit like an API abuse 
to me. But as I mentioned in my previous mail, I'm fine with the patch if you 
think it's a better solution.

> >> +/* must be ready before omap3isp is probed */
> > 
> > The problem is not limited to the omap3isp driver, the DSP driver could be
> > affected as well.
> 
> If you refer to tidspbridge, then I'm not sure it has the same issue:
> IIUC it doesn't enable the iommu hw on probe; only in response to an
> ioctl command (btw, tidspbridge doesn't even use this omap iommu
> driver - it manipulates the iommu registers directly. iicks.)

Looking at the tidspbridge driver, it seems to handle its IOMMU itself. That's 
an item for someone's to-do list :-)

Are drivers supposed to call iommu_attach_device() in their probe() function 
or later on ? The API doesn't seem to be documented.

> The omap4 solutions (remoteproc et al.) will only enable the iommu
> after userspace is alive, so no risk there as well.

-- 
Regards,

Laurent Pinchart
