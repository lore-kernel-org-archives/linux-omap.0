From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Fri, 25 Jun 2010 15:16:35 +0200
Message-ID: <4C24AC33.1080902@ti.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com> <1277423084-25528-9-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55341 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab0FYNQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 09:16:41 -0400
In-Reply-To: <1277423084-25528-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>

Kevin,

On 6/25/2010 1:44 AM, Kevin Hilman wrote:
> From: Rajendra Nayak<rnayak@ti.com>
>
> Enable omap_device layer support for OMAP4, so that drivers can
> use them to enable/idle/shutdown devices.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Signed-off-by: Kevin Hilman<khilman@deeprootsystems.com>
> ---
>   arch/arm/plat-omap/Makefile |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 98f0191..9405831 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>   # omap_device support (OMAP2+ only at the moment)
>   obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
>   obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> +obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
>
>   obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>   obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o

You need as well to enable omap_hwmod.c build otherwise it cannot build 
on OMAP4.

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile 
index 8ed47ea..5de06c3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,7 +15,7 @@ clock-common                          = clock.o 
clock_common_data.o \

  obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) 
$(hwmod-common)
  obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) 
$(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common) $(hwmod-common)

  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o


Benoit
