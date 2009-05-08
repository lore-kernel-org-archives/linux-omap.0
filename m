From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Fri, 08 May 2009 07:14:10 +0300 (EEST)
Message-ID: <20090508.071410.173868238.Hiroshi.DOYU@nokia.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
	<1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33691 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZEHEOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 00:14:40 -0400
In-Reply-To: <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, felipe.contreras@nokia.com, tony@atomide.com, h-kanigeri2@ti.com

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Thu, 7 May 2009 22:11:06 +0200

> This patch series cleanups up a bit the opap3-iommu device registration and
> then allows registration from other parts of the code.

I think that this part of code is just a simple conventional
platform_device registration and there may be no need to add more
complexicity by introducing a new special structure/function just for
a workaround of a client module("tidspbridge"). Also having these
device registrations here and there doesn't look so nice, looking at
other ones around kernel.

> Currently the iva2 code (tidspbridge) is not using iommu, therefore it can't be
> used as-is with the current omap iommu. By allowing devies to be registered
> externaly (either isp, or iva2) this problem goes away.

Fixing tidspbridge itself is the way to go, and it seems that Hari has
already verified this iommu with tidspbridge and he's pointed out some
of missing features(*1). I hope that tidspbridge will start to use
iommu soon.

*1: http://marc.info/?l=linux-omap&m=124148814309478&w=2




