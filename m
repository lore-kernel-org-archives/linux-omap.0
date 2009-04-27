From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC] dspbridge: staging todo list
Date: Sun, 26 Apr 2009 22:05:38 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AA64125@dlee03.ent.ti.com>
References: <983c694e0904260907o2e10da56xffeade20f1b3ff7c@mail.gmail.com>
 <20090426.203643.35024594.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52291 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbZD0DFu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 23:05:50 -0400
In-Reply-To: <20090426.203643.35024594.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "or.rmz1@gmail.com" <or.rmz1@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "dedekind@yandex.ru" <dedekind@yandex.ru>, "Gupta, Ramesh" <grgupta@ti.com>

Hi,

> This DMM feature should be replaced with "omap iommu" driver which
> commonly supports omap iommu feature. Currently it supports just a
> mapping of in-kernel buffers(contiguous/discontiguous), but will be
> extened to an user buffer soon. Anyway, "bitmap_find_free_region"
> would bring better performance if the number of VMAs becomes huge.
>

-- DMM is dynamic memory mapping, where DSP VA is mapped to Physical address of the buffers allocated by Multimedia applications. At present, Bridge is using its own version of MMU module for mapping the DSP VA to physical address, and this Bridge's MMU module can be replaced with the omap iommu. But before we do that, following things need to happen:

	- The iommu should reside in linux-omap tree :)
	- IOMMU module provides support for preservation of TLB entries.
	- IOMMU module provides support for notification of MMU faults.

I did some basic sanity testing in Bridge by replacing the Bridge's MMU module with the iommu module and the above items need to happen before we migrate to use iommu.

Thank you,
Best regards,
Hari
