From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH v6 0/2] ARM: New cache API for iommu
Date: Mon, 17 Sep 2012 23:16:13 +0530
Message-ID: <CADysL2b7Tf7qbjZest7zUmESRXcq=BoxnD8yKAFR5O8rp=eyYw@mail.gmail.com>
References: <CADysL2Y=aLJ8Eq5aJhB28VhwBvVY+4DyMFpu=MyOg6Sj+D+rYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:48483 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753971Ab2IQRqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Sep 2012 13:46:14 -0400
Received: by iahk25 with SMTP id k25so5475531iah.19
        for <linux-omap@vger.kernel.org>; Mon, 17 Sep 2012 10:46:13 -0700 (PDT)
In-Reply-To: <CADysL2Y=aLJ8Eq5aJhB28VhwBvVY+4DyMFpu=MyOg6Sj+D+rYg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, tony@atomide.com

Hi Russell,


On Thu, Sep 13, 2012 at 12:39 PM, Gupta, Ramesh <grgupta@ti.com> wrote:
> From a00cbfadc0053a3c21812593997a1b7338234a9f Mon Sep 17 00:00:00 2001
> From: Ramesh Gupta G <grgupta@ti.com>
> Date: Thu, 13 Sep 2012 11:43:20 +0530
> Subject: [PATCH v6  0/2] ARM: New cache API for iommu
>
> This patch series is the next version to
> - add a new cache maintenance api to support non-coherent iommu drivers.
> - flush both L1 and L2 caches from OMAP iommu whenever the page table
>   memory is updated.
>
> Changes since the previous patch set (v5)
> - Fixed the RMK's comments on the flush function names in omap-iommu
> to reflect the
>   purpose.
>
> The implementation of the new api is based on
> the approach[1] discussed.
>
> [1]http://marc.info/?l=linux-kernel&m=131316512713815&w=2
>
> Ramesh Gupta G (2):
>   ARM: new cache maintenance api for iommu
>   OMAP:IOMMU:flush L1 and L2 caches

I have included your review comments in this series.
Could you please pull these patches if every thing looks fine?

thank you and regards
Ramesh Gupta G
