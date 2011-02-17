From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: IOMMU: add missing function declaration
Date: Thu, 17 Feb 2011 15:48:20 -0800
Message-ID: <20110217234820.GJ20795@atomide.com>
References: <1297769473-24052-1-git-send-email-dacohen@gmail.com>
 <20110215.150904.31489671848521371.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61189 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab1BQXsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 18:48:25 -0500
Content-Disposition: inline
In-Reply-To: <20110215.150904.31489671848521371.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: dacohen@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [110215 05:07]:
> From: David Cohen <dacohen@gmail.com>
> Subject: [PATCH v2] OMAP: IOMMU: add missing function declaration
> Date: Tue, 15 Feb 2011 13:31:13 +0200
> 
> > Declaration of exported function 'iopgtable_lookup_entry' is missing from
> > header file. Currently we have a sparse warning as it's not being used
> > externally. Adding its declaration to avoid such warning and allow its usage
> > in future.
> > 
> > Signed-off-by: David Cohen <dacohen@gmail.com>
> > ---
> >  arch/arm/plat-omap/include/plat/iommu.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> Thanks. Tony, Please put this into your queue.

Adding to devel-cleanup for the upcoming merge window.

Tony
