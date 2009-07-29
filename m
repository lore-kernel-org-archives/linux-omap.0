From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Wed, 29 Jul 2009 09:36:17 +0300 (EEST)
Message-ID: <20090729.093617.241930259.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A941FEA@dlee03.ent.ti.com>
	<20090727.094731.260080790.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E3A9D17C1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60813 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbZG2Ggc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 02:36:32 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A9D17C1@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, grgupta@ti.com, linux@arm.linux.org.uk, vpasam@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Tue, 28 Jul 2009 17:42:21 +0200

> Hi Hiroshi,
> 
> > 
> > This "omap iommu" driver is used in OMAP4 IPC and its interface is a
> > character device node. IOW, the client of this device will be an
> > userland process and kernel won't know if it uses or not, but kernel
> > just provides "/dev/iommu?" for userland. So I don't think that we
> > have to care about the dependency of the existance of clients, at
> > least, for a moment.
> > 
> > >
> The first patch set that I sent is to provide support in IOMMU for OMAP4 just like how it is done in OMAP3 today. The define "CONFIG_MPU_TESLA_IOMMU" is used for now because in the first phase we are planning to use DSP-Bridge to communicate with Tesla (until we move the new user-land IPC to replace DSP-Bridge for OMAP4).
> IMHO, let's go ahead with these changes and any changes to support
> IOMMU from user-land we can address them in next set of patches.

Got it. Let's go for it;) I'll queue them up if you send the updated ones.
