From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin omap3isp
Date: Mon, 27 Feb 2012 09:00:51 +0200
Message-ID: <CAK=WgbZRjGEyx0mKmgoWYiOnuvUAka0kTzpLAYbra94Mfpp6qg@mail.gmail.com>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com>
 <3215700.hj2jFm3b0A@avalon> <CAK=WgbYkVALqrVMVv1ma3WzN5dYriM8X0MfwH4knwWwojB6hjg@mail.gmail.com>
 <35010303.ArkW8BdIu6@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39470 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab2B0HBL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Feb 2012 02:01:11 -0500
Received: by iazz13 with SMTP id z13so2876871iaz.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Feb 2012 23:01:11 -0800 (PST)
In-Reply-To: <35010303.ArkW8BdIu6@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi Laurent,

On Mon, Feb 27, 2012 at 12:47 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> I'm asking about the probe deferral mechanism. The omap3-isp driver will still
> call iommu_attach_device() in its probe function. What will happen then ? Will
> it return an error ? On what basis will it do so ?

Yes, iommu_attach_device() will fail, and omap3isp's probe function
will then need to return -EAGAIN to request that its probe function
will be invoked again later on.

> That's what the comment in the Makefile is for ;-) I don't think it's a
> perfect solution either, but it avoids playing with the various initcalls. The
> OMAP3 IOMMU isn't a subsystem, subsys_initcall() looks a bit like an API abuse
> to me.

Yes, it's dirty.

But it's explicit and consistent across build system changes (without
imposing anything on the build system). We do it all the time with
other subsystems. We don't like it, but luckily Grant came up with the
deferred probing mechanism, which will fix this all very nicely.

> Are drivers supposed to call iommu_attach_device() in their probe() function
> or later on ?

If you can defer attaching to a later point, most commonly to a point
where the device is opened by the user, it's better - less power will
be consumed.

Thanks,
Ohad.
