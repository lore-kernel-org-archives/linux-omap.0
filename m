From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2] OMAP: IOMMU: add missing function declaration
Date: Tue, 15 Feb 2011 15:09:04 +0200 (EET)
Message-ID: <20110215.150904.31489671848521371.Hiroshi.DOYU@nokia.com>
References: <1297769473-24052-1-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:64512 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab1BONJB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 08:09:01 -0500
In-Reply-To: <1297769473-24052-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dacohen@gmail.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v2] OMAP: IOMMU: add missing function declaration
Date: Tue, 15 Feb 2011 13:31:13 +0200

> Declaration of exported function 'iopgtable_lookup_entry' is missing from
> header file. Currently we have a sparse warning as it's not being used
> externally. Adding its declaration to avoid such warning and allow its usage
> in future.
> 
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/iommu.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Thanks. Tony, Please put this into your queue.
