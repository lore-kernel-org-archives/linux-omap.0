From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4
	iommu
Date: Wed, 5 Aug 2009 21:22:59 +0100
Message-ID: <20090805202259.GA9303@n2100.arm.linux.org.uk>
References: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2@dlee03.ent.ti.com> <20090804224241.GA17716@n2100.arm.linux.org.uk> <20090805.073538.258116604.Hiroshi.DOYU@nokia.com> <8F7AF80515AF0D4D93307E594F3CB40E3ABDC0EF@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47961 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbZHEUXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 16:23:16 -0400
Content-Disposition: inline
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3ABDC0EF@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Wed, Aug 05, 2009 at 11:44:53AM -0500, Kanigeri, Hari wrote:
> -- I agree with your comments from OMAP3 point of view. 
> For OMAP4, I guess Camera is not going to use IOMMU module. IOMMU
> modules will be used only by the IPC that are communicating with 2
> remote Cores (Ducati and Tesla).

In which case what you do is:

config OMAP_CAMERA
	...
	select OMAP_IOMMU if ARCH_OMAP3

which means the IOMMU support will only be built if the camera is enabled
and we're building for OMAP3.

However, if the OMAP3 hardware uses the IOMMU but the OMAP4 hardware
doesn't, I'd hazard a guess (and it's only a guess) that the drivers
will be soo different that squeezing them into one file/config option
would be silly.

> Having said this, there might not
> be any clients of IOMMU in the Kernel space as we are looking at
> the option of using the IOMMU as a character driver from User-space.
> For this reason, I think we should have the configuration option to
> build iommu. Please let me know your comments.

In which case, the IOMMU character driver can select the core IOMMU
support.

Making symbols which are 'selected' visible causes problems - you
can't disable them and you can't work out why they're being
forcefully enabled, which just annoys people who are trying to
configure the kernel.
