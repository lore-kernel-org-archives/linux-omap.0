From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin omap3isp
Date: Sun, 26 Feb 2012 20:30:17 +0200
Message-ID: <CAK=WgbYkVALqrVMVv1ma3WzN5dYriM8X0MfwH4knwWwojB6hjg@mail.gmail.com>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com> <3215700.hj2jFm3b0A@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50924 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab2BZSah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Feb 2012 13:30:37 -0500
Received: by iazz13 with SMTP id z13so2316772iaz.19
        for <linux-omap@vger.kernel.org>; Sun, 26 Feb 2012 10:30:37 -0800 (PST)
In-Reply-To: <3215700.hj2jFm3b0A@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi Laurent,

On Sun, Feb 26, 2012 at 7:34 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Sunday 26 February 2012 12:14:14 Ohad Ben-Cohen wrote:
>> omap3isp depends on omap's iommu and will fail to probe if
>> initialized before it (which always happen if they are builtin).
>>
>> Make omap's iommu subsys_initcall as an interim solution until
>> the probe deferral mechanism is merged.
>
> How will that fix the problem ?

Sorry, I'm not entirely sure I understand the question: are you asking
about this patch or about the probe deferral thingy ?

> I'm fine with this patch, as it fixes the problem as well, although I still
> believe modifying the link order would be a better fix in this case.

I'm personally not a huge fan of implicit link order dependencies, as
someone may change the order in the future (for whatever benign
reason) without even realizing he's breaking drivers.

>> +/* must be ready before omap3isp is probed */
>
> The problem is not limited to the omap3isp driver, the DSP driver could be
> affected as well.

If you refer to tidspbridge, then I'm not sure it has the same issue:
IIUC it doesn't enable the iommu hw on probe; only in response to an
ioctl command (btw, tidspbridge doesn't even use this omap iommu
driver - it manipulates the iommu registers directly. iicks.)

The omap4 solutions (remoteproc et al.) will only enable the iommu
after userspace is alive, so no risk there as well.

Thanks,
Ohad.
