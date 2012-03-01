From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin omap3isp
Date: Thu, 01 Mar 2012 17:37:40 +0100
Message-ID: <6354375.6C9sXAHKbF@avalon>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com> <35010303.ArkW8BdIu6@avalon> <CAK=WgbZRjGEyx0mKmgoWYiOnuvUAka0kTzpLAYbra94Mfpp6qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:41053 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934Ab2CAQhZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 11:37:25 -0500
In-Reply-To: <CAK=WgbZRjGEyx0mKmgoWYiOnuvUAka0kTzpLAYbra94Mfpp6qg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi Ohad,

On Monday 27 February 2012 09:00:51 Ohad Ben-Cohen wrote:
> On Mon, Feb 27, 2012 at 12:47 AM, Laurent Pinchart wrote:
> > I'm asking about the probe deferral mechanism. The omap3-isp driver will
> > still call iommu_attach_device() in its probe function. What will happen
> > then ? Will it return an error ? On what basis will it do so ?
> 
> Yes, iommu_attach_device() will fail, and omap3isp's probe function will
> then need to return -EAGAIN to request that its probe function will be
> invoked again later on.
> 
> > That's what the comment in the Makefile is for ;-) I don't think it's a
> > perfect solution either, but it avoids playing with the various initcalls.
> > The OMAP3 IOMMU isn't a subsystem, subsys_initcall() looks a bit like an
> > API abuse to me.
> 
> Yes, it's dirty.
> 
> But it's explicit and consistent across build system changes (without
> imposing anything on the build system). We do it all the time with other
> subsystems. We don't like it, but luckily Grant came up with the deferred
> probing mechanism, which will fix this all very nicely.
> 
> > Are drivers supposed to call iommu_attach_device() in their probe()
> > function or later on ?
> 
> If you can defer attaching to a later point, most commonly to a point
> where the device is opened by the user, it's better - less power will
> be consumed.

I'll try that then. How expensive is the iommu_attach_device() (and detach) 
operation in terms of CPU time ?

-- 
Regards,

Laurent Pinchart

