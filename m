From: Ameya Palande <ameya.palande@Nokia.com>
Subject: Re: [PATCH 3/3] DSPBRIDGE: Use dspbridge to initialize platform
 data
Date: Mon, 18 Jan 2010 12:32:03 +0200
Message-ID: <1263810723.1968.8.camel@sanganak>
References: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-3-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35810 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab0ARKcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 05:32:55 -0500
In-Reply-To: <1263607307-21693-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@Nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@Nokia.com>, Nishanth Menon <nm@ti.com>

On Sat, 2010-01-16 at 03:01 +0100, ext Omar Ramirez Luna wrote:
> Include dspbridge compilation whenever bridge driver is selected to
> be compiled, either as a module or part of the kernel. This will
> initialize platform data specific PM functions.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index a37c713..1693c03 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -57,7 +57,9 @@ obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
>  # Debobs
>  obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
>  
> -obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
> +ifneq ($(CONFIG_MPU_BRIDGE),)
> +obj-y					+= dspbridge.o
> +endif
>  
>  # Specific board support
>  obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o

Acked-by: Ameya Palande <ameya.palande@nokia.com>

