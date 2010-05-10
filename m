From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] omap iommu: renamed omap3-iommu to omap-iommu
Date: Mon, 10 May 2010 13:09:32 +0300
Message-ID: <p2z94a0d4531005100309v78f4fc0bw7f805f9dceffbcb4@mail.gmail.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:21135 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0EJKJe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 06:09:34 -0400
Received: by ey-out-2122.google.com with SMTP id d26so230639eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 03:09:33 -0700 (PDT)
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Mon, May 10, 2010 at 12:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: Kanigeri, Hari <h-kanigeri2@ti.com>
>
> This patch includes changes to omap3-iommu.c file to make it generic
> for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c
>
> [Hiroshi DOYU: Remove unnecessary "iommy-y" in Makefile]
>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |    5 +---
>  .../arm/mach-omap2/{omap3-iommu.c => omap-iommu.c} |   23 +++++++++++--------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>  rename arch/arm/mach-omap2/{omap3-iommu.c => omap-iommu.c} (79%)

There's no need to have an 'omap-' prefix... iommu.c suffices.


> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 4b9fc57..7d2cf0f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -89,10 +89,7 @@ obj-$(CONFIG_OMAP3_EMU)                      += emu.o
>  obj-$(CONFIG_OMAP_MBOX_FWK)            += mailbox_mach.o
>  mailbox_mach-objs                      := mailbox.o
>
> -iommu-y                                        += iommu2.o
> -iommu-$(CONFIG_ARCH_OMAP3)             += omap3-iommu.o
> -
> -obj-$(CONFIG_OMAP_IOMMU)               += $(iommu-y)
> +obj-$(CONFIG_OMAP_IOMMU)               := iommu2.o omap-iommu.o

Hiroshi, these objects have to be always built-in, but if
CONFIG_OMAP_IOMMU=m, that would not be the case.

-- 
Felipe Contreras
