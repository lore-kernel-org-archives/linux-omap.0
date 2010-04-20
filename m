From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3][v2] OMAP:iommu support for OMAP4
Date: Wed, 21 Apr 2010 00:48:33 +0300
Message-ID: <w2h94a0d4531004201448s1ad276f5ncf7c0de273481fe2@mail.gmail.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B3445E5@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48261 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0DTVsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 17:48:35 -0400
Received: by bwz25 with SMTP id 25so7357743bwz.28
        for <linux-omap@vger.kernel.org>; Tue, 20 Apr 2010 14:48:33 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B3445E5@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

On Wed, Apr 21, 2010 at 12:31 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> From 9a6f91b0c108fd010afdb6bddcae92579c87fcbd Mon Sep 17 00:00:00 2001
> From: Hari Kanigeri <h-kanigeri2@ti.com>
> Date: Tue, 20 Apr 2010 12:03:03 -0500
> Subject: [PATCH 1/3] OMAP:iommu support for OMAP4
>
> This patch provides the iommu support for OMAP4 co-processors.
> This includes changes to omap3-iommu.c file to make it generic
> for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c

This smells like two patches: one that moves omap3-iommu to
omap-iommu, and another one that adds omap4 support.

But unfortunately this would break multi-omap support. I think both
omap3 and omap4 devices should be there, and selected at run-time.

Cheers.

-- 
Felipe Contreras
