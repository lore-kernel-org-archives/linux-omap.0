From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Sun, 13 Nov 2011 10:43:46 +0900
Message-ID: <CAHQjnOPkhR2SWO5Tov_V6Zw=zYb9EOJPbC1bENXJ+ttw_TB1HA@mail.gmail.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
	<1318850846-16066-3-git-send-email-ohad@wizery.com>
	<CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
	<1320938930.22195.17.camel@i7.infradead.org>
	<20111110170918.GE13213@amd.com>
	<4EBC3E20.20301@codeaurora.org>
	<20111111132411.GH13213@amd.com>
	<4EBDD426.4050105@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33439 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1KMBnr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Nov 2011 20:43:47 -0500
In-Reply-To: <4EBDD426.4050105@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stepan Moskovchenko <stepanm@codeaurora.org>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, Ohad Ben-Cohen <ohad@wizery.com>, Kai Huang <mail.kai.huang@gmail.com>, kvm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org

On Sat, Nov 12, 2011 at 11:04 AM, Stepan Moskovchenko
<stepanm@codeaurora.org> wrote:
> Yes, the scatterlist is allowed to have different page sizes. But, they are
> required to have a length that is a multiple of 4K. If a page in the list is

An element in scatterlist may not be aligned by 4K but I think IOMMU driver
must round it up to 4K if IOMMU API support iommu_map_range().

The first element in scatterlist is often not aligned by 4K if the pages are
provided from userspace. Length + offset of  the element must be
aligned by 4K, though.

Thank you,
KyongHo.
