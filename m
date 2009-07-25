From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Sat, 25 Jul 2009 14:32:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5AA0392@dbde02.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35986 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbZGYJCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jul 2009 05:02:35 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Pasam, Vijay" <vpasam@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> Sent: Friday, July 24, 2009 10:53 PM
> To: tony@atomide.com; Hiroshi DOYU
> Cc: linux-omap@vger.kernel.org; Gupta, Ramesh; rmk@arm.linux.org.uk; Pasam,
> Vijay
> Subject: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
> 
> This patch adds omap4 support in iommu
> module. This creates OMAP4 platform specific file
> for iommu and defines the Ducati MMU fault interrupt.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/omap4-iommu.c      |  112
> ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/irqs.h |    2 +-
>  2 files changed, 113 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap4-iommu.c
> 
> diff --git a/arch/arm/mach-omap2/omap4-iommu.c b/arch/arm/mach-
> omap2/omap4-iommu.c
> new file mode 100644
> index 0000000..5a782df
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap4-iommu.c
> @@ -0,0 +1,112 @@
> +/*
> + * omap iommu: omap4 device registration
> + *
> + * Copyright (C) 2009-2010 Nokia Corporation
Hari, 
	We are still in 2009 :)
Regards,
Santosh
