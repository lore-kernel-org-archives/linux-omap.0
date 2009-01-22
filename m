From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 6/6] omap2 iommu: entries for Kconfig and Makefile
Date: Thu, 22 Jan 2009 17:02:12 +0200 (EET)
Message-ID: <20090122.170212.39296966.Hiroshi.DOYU@nokia.com>
References: <20090116083003.18344.38307.stgit@oreo.research.nokia.com>
	<20090116083735.18344.92890.stgit@oreo.research.nokia.com>
	<20090117165920.GD12341@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Jan_22_17_02_12_2009_320)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44354 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbZAVPCh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 10:02:37 -0500
In-Reply-To: <20090117165920.GD12341@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

----Next_Part(Thu_Jan_22_17_02_12_2009_320)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Russell,

From: "ext Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/6] omap2 iommu: entries for Kconfig and Makefile
Date: Sat, 17 Jan 2009 16:59:20 +0000

> On Fri, Jan 16, 2009 at 10:37:35AM +0200, Hiroshi DOYU wrote:
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > ---
> > 
> >  arch/arm/mach-omap2/Makefile |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index bbd12bc..443e71f 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -24,6 +24,11 @@ endif
> >  obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
> >  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
> >  
> > +obj-$(CONFIG_OMAP_IOMMU)		+= iommu2.o
> > +ifeq ($(CONFIG_ARCH_OMAP3),y)
> > +obj-$(CONFIG_OMAP_IOMMU)		+= omap3-iommu.o
> > +endif
> > +
> 
> I can see this expanding still further... so what about nipping it now
> before it gets out of hand:
> 
> iommu-y					+= iommu2.o
> iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
> 
> obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)

Much simpler. Thanks. The updated one is attached.

----Next_Part(Thu_Jan_22_17_02_12_2009_320)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0006-omap2-iommu-entries-for-Kconfig-and-Makefile.patch"

>From 80c17b5d26e89a3c5a65b2dfac02eeaf6426404b Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Mon, 19 Jan 2009 13:01:01 +0200
Subject: [PATCH 6/6] omap2 iommu: entries for Kconfig and Makefile

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bbd12bc..4f6123d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,6 +24,11 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
+iommu-y					+= iommu2.o
+iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
+
+obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
-- 
1.6.1.rc4


----Next_Part(Thu_Jan_22_17_02_12_2009_320)----
