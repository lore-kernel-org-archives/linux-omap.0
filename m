From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 01/10] OMAP3: PM: Adding voltage driver support.
Date: Wed, 22 Dec 2010 14:29:35 -0800
Message-ID: <87hbe5o300.fsf@deeprootsystems.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
	<1292864357-13939-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:57998 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0LVW3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 17:29:40 -0500
Received: by pxi20 with SMTP id 20so1515334pxi.10
        for <linux-omap@vger.kernel.org>; Wed, 22 Dec 2010 14:29:40 -0800 (PST)
In-Reply-To: <1292864357-13939-2-git-send-email-thara@ti.com> (Thara
	Gopinath's message of "Mon, 20 Dec 2010 22:29:08 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, nm@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch adds voltage driver support for OMAP3. The driver
> allows  configuring the voltage controller and voltage
> processors during init and exports APIs to enable/disable
> voltage processors, scale voltage and reset voltage.
> The driver maintains the global voltage table on a per
> VDD basis which contains the various voltages supported by the
> VDD along with per voltage dependent data like smartreflex
> efuse offset, errminlimit and voltage processor errorgain.
> The driver also allows the voltage parameters dependent on the
> PMIC to be passed from the PMIC file through an API.
> The driver allows scaling of VDD voltages either through
> "vc bypass method" or through "vp forceupdate method" the
> choice being configurable through the board file.
>
> This patch contains code originally in linux omap pm branch
> smartreflex driver.  Major contributors to this driver are
> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
> Nishant Menon, Kevin Hilman. The separation of PMIC parameters
> into a separate structure which can be populated from
> the PMIC file is based on the work of Lun Chang from Motorola
> in an internal tree.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
> This patch has 14 checkpatch.pl above 80-chars warnings for
> the definitions of omap34xx_vddmpu_volt_data, omap36xx_vddmpu_volt_data,
> omap34xx_vddcore_volt_data and omap36xx_vddcore_volt_data structures.
> IMHO splitting of the entries in these structures affects
> readability and looks very ugly. Hence they are left as is.
>
>  arch/arm/mach-omap2/Makefile              |    3 +-
>  arch/arm/mach-omap2/control.h             |   17 +
>  arch/arm/mach-omap2/pm.c                  |    8 +
>  arch/arm/mach-omap2/voltage.c             | 1226 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/voltage.h |  134 ++++
>  5 files changed, 1387 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/voltage.c
>  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 7c79683..5034797 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -57,7 +57,8 @@ endif
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
> -obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o pm_bus.o
> +obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
> +					   cpuidle34xx.o pm_bus.o

This will not link when building OMAP2 only (common for n8x0 testing due
to kernel size limitation.)  In this config, voltage.o is not compiled,
but its functions are still called from the common pm.c.

Will fold the following diff into this patch.

Kevin


diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 91c9b60..4ab82f6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -59,7 +59,7 @@ endif
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
+obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o voltage.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
 					   cpuidle34xx.o pm_bus.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o

