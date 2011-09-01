From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in iommu_vmap
Date: Thu, 1 Sep 2011 14:47:26 +0300
Message-ID: <CAK=WgbaOSaKcxmsG2L3G3g+bORvtq4nyzCg9yhA=tTLhsYmh3w@mail.gmail.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com> <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64266 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1IALru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 07:47:50 -0400
Received: by wyh22 with SMTP id 22so897953wyh.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 04:47:46 -0700 (PDT)
In-Reply-To: <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

On Wed, Aug 31, 2011 at 1:52 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> omap_iovmm requires page-aligned buffers, and that sometimes causes
> omap3isp failures (i.e. whenever the buffer passed from userspace is not
> page-aligned).
>
> Remove this limitation by rounding the address of the first page entry
> down, and adding the offset back to the device address.

Seems like the unmap paths were skipped (need to adjust the sizes in
the unmap path too).

Laurent, if it looks good to you, I'll just squash it to the original
patch and repost:

diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index d28a256..39bdb92 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -447,7 +447,7 @@ err_out:
        for_each_sg(sgt->sgl, sg, i, j) {
                size_t bytes;

-               bytes = sg->length;
+               bytes = sg->length + sg->offset;
                order = get_order(bytes);

                /* ignore failures.. we're already handling one */
@@ -476,7 +476,7 @@ static void unmap_iovm_area(struct iommu_domain *domain, str
                size_t bytes;
                int order;

-               bytes = sg->length;
+               bytes = sg->length + sg->offset;
                order = get_order(bytes);

                err = iommu_unmap(domain, start, order);
