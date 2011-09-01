From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in iommu_vmap
Date: Thu, 1 Sep 2011 17:02:35 +0300
Message-ID: <CAK=WgbY0YTBVbHwHDDa-+8j8d_navvKN=JXFJDpdWp2BX0LFCg@mail.gmail.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
 <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
 <CAK=WgbaOSaKcxmsG2L3G3g+bORvtq4nyzCg9yhA=tTLhsYmh3w@mail.gmail.com> <201109011559.33491.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47823 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553Ab1IAOC5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:02:57 -0400
Received: by eyx24 with SMTP id 24so1633948eyx.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 07:02:55 -0700 (PDT)
In-Reply-To: <201109011559.33491.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

On Thu, Sep 1, 2011 at 4:59 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> It looks good to me.

Thanks.

> I haven't tested it though.

I did, but I always get aligned buffers so my testing is a bit moot. I
can't see how unmap could work without this patch, though, so I'll
squash this and re-post.
