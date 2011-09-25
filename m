From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH v3 3/6] iommu/msm: announce supported page sizes
Date: Sat, 24 Sep 2011 22:03:08 -0700
Message-ID: <20110925050308.GA6493@huya.qualcomm.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
 <1316195506-9777-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:65000 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1IYFDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Sep 2011 01:03:11 -0400
Content-Disposition: inline
In-Reply-To: <1316195506-9777-4-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Stepan Moskovchenko <stepanm@codeaurora.org>

On Fri, Sep 16, 2011 at 08:51:43PM +0300, Ohad Ben-Cohen wrote:
> Let the IOMMU core know we support 4KiB, 64KiB, 1MiB and 16MiB page sizes.
> 
> This way the IOMMU core can split any arbitrary-sized physically
> contiguous regions (that it needs to map) as needed.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> ---
>  drivers/iommu/msm_iommu.c |    8 +++++++-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
